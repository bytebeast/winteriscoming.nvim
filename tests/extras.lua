-- Run: nvim --headless --clean -u NONE --cmd "set rtp^=." -l tests/extras.lua
-- Every extra checked against the tool's own key list (inline for small
-- formats, tests/fixtures/ for large ones) and against the Neovim colors.
local fails = 0
local function check(cond, msg)
  if not cond then
    fails = fails + 1
    io.stderr:write("FAIL: " .. msg .. "\n")
  end
end
local function eq(a, b, msg)
  check(vim.deep_equal(a, b), ("%s: expected %s, got %s"):format(msg, vim.inspect(b), vim.inspect(a)))
end

local Util = require("winteriscoming.util")
local Extras = require("winteriscoming.extra")
local styles = { "blue", "black", "light" }
local function colors(style)
  return Extras.colors(style)
end
local function is_color(v, alpha)
  return type(v) == "string" and (v:match("^#%x%x%x%x%x%x$") or (alpha and v:match("^#%x%x%x%x%x%x%x%x$"))) ~= nil
end
local function hl(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end
local function hex(v)
  return v and string.format("#%06x", v)
end
local function load(style)
  require("winteriscoming").setup({ cache = false, plugins = { all = true } })
  vim.cmd.colorscheme("winteriscoming-" .. style)
end
-- non-comment lines of a fixture file, optionally under one `[section]`
local function fixture(path, section)
  local out, current = {}, nil
  for line in io.lines(path) do
    local sec = line:match("^%[(.+)%]$")
    if sec then
      current = sec
    elseif line ~= "" and not line:find("^#") and (not section or current == section) then
      out[line] = true
    end
  end
  return out
end
-- leaves of the flat, two-space-indented YAML the eza/k9s generators emit
local function yaml_leaves(text)
  local out, stack = {}, {}
  for line in text:gmatch("[^\n]+") do
    if not line:match("^%s*#") and line:match("%S") then
      local indent, key, rest = line:match("^(%s*)([%w_]+):%s*(.-)%s*$")
      if key then
        local depth = #indent / 2
        for i = #stack, depth + 1, -1 do
          stack[i] = nil
        end
        stack[depth + 1] = key
        if rest ~= "" then
          out[table.concat(stack, ".", 1, depth + 1)] = rest
        end
      end
    end
  end
  return out
end
local function keyset(words)
  local out = {}
  for k in words:gmatch("%S+") do
    out[k] = true
  end
  return out
end

-- every extra renders, the files on disk are current
for name in pairs(Extras.extras) do
  for path, content in pairs(Extras.files(name)) do
    check(#content > 50 and not content:find("%${"), path .. ": rendered without template leftovers")
    local fd = io.open(path, "r")
    check(fd and fd:read("*a") == content, path .. " is out of date: regenerate the extras")
    if fd then
      fd:close()
    end
  end
end

-- eza: keys from src/options/config.rs (eza silently ignores unknown keys)
do
  local S = {}
  local function add(prefix, keys)
    for k in keys:gmatch("%S+") do
      S[prefix .. k] = true
    end
  end
  add("filekinds.", "normal directory symlink pipe block_device char_device socket special executable mount_point")
  add(
    "perms.",
    "user_read user_write user_execute_file user_execute_other group_read group_write group_execute other_read other_write other_execute special_user_file special_other attribute"
  )
  add(
    "size.",
    "major minor number_byte number_kilo number_mega number_giga number_huge unit_byte unit_kilo unit_mega unit_giga unit_huge"
  )
  add("users.", "user_you user_root user_other group_yours group_other group_root")
  add("links.", "normal multi_link_file")
  add("git.", "new modified deleted renamed typechange ignored conflicted")
  add("git_repo.", "branch_main branch_other git_clean git_dirty")
  add("security_context.", "none")
  add("security_context.selinux.", "colon user role typ range")
  add("file_type.", "image video music lossless crypto document compressed temp compiled build source")
  add(
    "",
    "punctuation date inode blocks header octal flags symlink_path control_char broken_symlink broken_path_overlay"
  )
  local attrs = keyset("foreground background is_bold is_dimmed is_italic is_underline")
  for _, style in ipairs(styles) do
    local seen = 0
    for path, value in pairs(yaml_leaves(Extras.render("eza", style))) do
      if path ~= "colourful" then
        check(S[path], style .. ": unknown eza key " .. path)
        seen = seen + 1
        for attr, v in value:gmatch("([%w_]+):%s*([^,}]+)") do
          check(attrs[attr], ("%s: %s has unknown attribute %s"):format(style, path, attr))
          if attr == "foreground" then
            check(v:match('^"#%x%x%x%x%x%x"$'), ("%s: %s color %s"):format(style, path, v))
          end
        end
        for _, attr in ipairs({ "is_bold", "is_dimmed", "is_italic", "is_underline" }) do
          check(
            value:find(attr, 1, true),
            ("%s: %s must set %s (eza keeps its default otherwise)"):format(style, path, attr)
          )
        end
      end
    end
    eq(seen, vim.tbl_count(S), style .. ": every eza style key is set")
  end
end

-- k9s: keys from internal/config/styles.go (yaml tags)
do
  local K = {}
  local function add(prefix, keys)
    for k in keys:gmatch("%S+") do
      K["k9s." .. prefix .. k] = true
    end
  end
  add("body.", "fgColor bgColor logoColor logoColorMsg logoColorInfo logoColorWarn logoColorError")
  add("prompt.", "fgColor bgColor suggestColor")
  add("prompt.border.", "command default")
  add("help.", "fgColor bgColor sectionColor keyColor numKeyColor")
  add("frame.title.", "fgColor bgColor highlightColor counterColor filterColor")
  add("frame.border.", "fgColor focusColor")
  add("frame.menu.", "fgColor fgStyle keyColor numKeyColor")
  add("frame.crumbs.", "fgColor bgColor activeColor")
  add("frame.status.", "newColor modifyColor addColor pendingColor errorColor highlightColor killColor completedColor")
  add("info.", "sectionColor fgColor cpuColor memColor k9sRevColor")
  add("views.table.", "fgColor bgColor cursorFgColor cursorBgColor markColor")
  add("views.table.header.", "fgColor bgColor sorterColor selectedSortColumnColor")
  add("views.xray.", "fgColor bgColor cursorColor cursorTextColor graphicColor")
  add(
    "views.charts.",
    "bgColor dialBgColor chartBgColor defaultDialColors defaultChartColors resourceColors focusFgColor focusBgColor"
  )
  add("views.yaml.", "keyColor valueColor colonColor")
  add("views.picker.", "mainColor focusColor shortcutColor")
  add("views.logs.", "fgColor bgColor")
  add("views.logs.indicator.", "fgColor bgColor toggleOnColor toggleOffColor")
  add(
    "dialog.",
    "fgColor bgColor buttonFgColor buttonBgColor buttonFocusFgColor buttonFocusBgColor labelFgColor fieldFgColor"
  )
  for _, style in ipairs(styles) do
    for _, variant in ipairs({ "default", "transparent" }) do
      local leaves = yaml_leaves(Extras.render("k9s", style, variant))
      for path, value in pairs(leaves) do
        if not path:find("resourceColors", 1, true) then
          check(K[path], ("%s/%s: unknown k9s key %s"):format(style, variant, path))
          check(
            value:match('^"#%x%x%x%x%x%x"$') or value == '"default"',
            ("%s/%s: %s = %s"):format(style, variant, path, value)
          )
          check(
            variant ~= "default" or value ~= '"default"',
            style .. ": " .. path .. " must be a color in the opaque skin"
          )
        end
      end
      if variant == "transparent" then
        eq(leaves["k9s.body.bgColor"], '"default"', style .. ": transparent skin uses the terminal background")
      end
    end
  end
end

-- windows terminal: microsoft/terminal profiles.schema.json SchemeList
do
  local keys = keyset(
    "name background black blue brightBlack brightBlue brightCyan brightGreen brightPurple brightRed brightWhite "
      .. "brightYellow cursorColor cyan foreground green purple red selectionBackground white yellow"
  )
  for _, style in ipairs(styles) do
    local scheme = vim.json.decode(Extras.render("windows_terminal", style))
    eq(vim.tbl_count(scheme), vim.tbl_count(keys), style .. ": every Windows Terminal key set")
    for k, v in pairs(scheme) do
      check(keys[k], style .. ": unknown Windows Terminal key " .. k)
      check(k == "name" or is_color(v), ("%s: %s = %s"):format(style, k, tostring(v)))
    end
  end
end

-- foot: dnkl/foot config.c parse_color_theme() plus regularN/brightN/N
do
  local keys = keyset(
    "foreground background cursor selection-foreground selection-background urls flash flash-alpha "
      .. "jump-labels scrollback-indicator search-box-match search-box-no-match"
  )
  local two = keyset("cursor jump-labels scrollback-indicator search-box-match search-box-no-match")
  for _, style in ipairs(styles) do
    local text = Extras.render("foot", style)
    local sections = {}
    for sec in text:gmatch("\n%[([%w-]+)%]") do
      sections[#sections + 1] = sec
    end
    eq(sections, { style == "light" and "colors-light" or "colors-dark" }, style .. ": foot section")
    for k, v in text:gmatch("\n([%w-]+)=([^\n]+)") do
      check(
        keys[k] or k:match("^regular[0-7]$") or k:match("^bright[0-7]$") or k:match("^%d+$"),
        style .. ": foot " .. k
      )
      local n = 0
      for color in v:gmatch("%S+") do
        check(color:match("^%x%x%x%x%x%x$"), ("%s: foot %s=%s (RRGGBB, no #)"):format(style, k, v))
        n = n + 1
      end
      eq(n, two[k] and 2 or 1, style .. ": foot value count for " .. k)
    end
    eq(text:match("\nbackground=(%x+)"), colors(style).bg:sub(2), style .. ": foot background")
  end
end

-- btop: aristocratos/btop src/btop_theme.cpp Default_theme
do
  local keys = keyset(
    "main_bg main_fg title hi_fg selected_bg selected_fg inactive_fg graph_text meter_bg proc_misc cpu_box mem_box "
      .. "net_box proc_box div_line temp_start temp_mid temp_end cpu_start cpu_mid cpu_end free_start free_mid "
      .. "free_end cached_start cached_mid cached_end available_start available_mid available_end used_start "
      .. "used_mid used_end download_start download_mid download_end upload_start upload_mid upload_end "
      .. "process_start process_mid process_end proc_pause_bg proc_follow_bg proc_banner_bg proc_banner_fg "
      .. "followed_bg followed_fg"
  )
  for _, style in ipairs(styles) do
    local seen = {}
    for k, v in Extras.render("btop", style):gmatch('theme%[([%w_]+)%]="([^"]*)"') do
      check(keys[k], style .. ": unknown btop key " .. k)
      check(is_color(v), ("%s: btop %s=%s"):format(style, k, v))
      seen[k] = true
    end
    eq(vim.tbl_count(seen), vim.tbl_count(keys), style .. ": every btop key set")
  end
end

-- fish: fish-shell doc_src/interactive.rst
do
  local keys = {}
  for k in
    (
      "normal command keyword quote redirection end error param valid_path option comment selection operator "
      .. "escape autosuggestion cwd cwd_root user host host_remote status cancel search_match history_current "
      .. "builtin function"
    ):gmatch("%S+")
  do
    keys["fish_color_" .. k] = true
  end
  for k in
    (
      "progress background prefix completion description selected_background selected_prefix "
      .. "selected_completion selected_description secondary_background secondary_prefix "
      .. "secondary_completion secondary_description"
    ):gmatch("%S+")
  do
    keys["fish_pager_color_" .. k] = true
  end
  local flags = keyset("--bold --italics --underline")
  for _, style in ipairs(styles) do
    local seen = {}
    for line in Extras.render("fish", style):gmatch("[^\n]+") do
      if not line:find("^#") then
        local k, v = line:match("^(%S+) (.+)$")
        check(keys[k], style .. ": unknown fish variable " .. tostring(k))
        for word in v:gmatch("%S+") do
          check(
            word:match("^%x%x%x%x%x%x$") or word:match("^%-%-background=%x%x%x%x%x%x$") or flags[word],
            style .. ": " .. line
          )
        end
        seen[k] = v
      end
    end
    eq(seen.fish_color_normal, colors(style).fg:sub(2), style .. ": fish normal text")
    check(seen.fish_color_comment:find("--italics", 1, true), style .. ": fish comments italic like Neovim")
  end
end

-- zellij: zellij-utils/src/kdl/mod.rs named styles and multiplayer colors
do
  local Zellij = require("winteriscoming.extra.zellij")
  for _, style in ipairs(styles) do
    local text = Extras.render("zellij", style)
    local c = colors(style)
    local defs, current = {}, nil
    for line in text:gmatch("[^\n]+") do
      local block = line:match("^        ([%w_]+) {$")
      if block then
        current, defs[block] = block, {}
      end
      local k, r, g, b = line:match("^            ([%w_]+) (%d+) (%d+) (%d+)$")
      if k then
        defs[current][k] = string.format("#%02x%02x%02x", tonumber(r), tonumber(g), tonumber(b))
      end
    end
    eq(select(2, text:gsub("{", "")), select(2, text:gsub("}", "")), style .. ": zellij balanced braces")
    check(text:find("    winteriscoming_" .. style .. " {", 1, true), style .. ": zellij theme named after the file")
    for _, name in ipairs(Zellij.styles) do
      eq(vim.tbl_count(defs[name] or {}), 6, style .. ": zellij " .. name .. " components")
    end
    eq(vim.tbl_count(defs.multiplayer_user_colors), 10, style .. ": zellij player colors")
    eq(vim.tbl_count(defs), #Zellij.styles + 1, style .. ": no unknown zellij blocks")
    eq(defs.ribbon_selected.background, c.accent, style .. ": selected zellij tab in the accent")
    for _, name in ipairs({ "text_unselected", "text_selected", "ribbon_unselected", "ribbon_hover" }) do
      local d = defs[name]
      for _, k in ipairs({ "base", "emphasis_0", "emphasis_1", "emphasis_2", "emphasis_3" }) do
        local ratio = Util.contrast(d[k], d.background)
        check(ratio >= 4.5, ("%s: zellij %s.%s at %.2f:1"):format(style, name, k, ratio))
      end
    end
  end
end

-- zathura: pwmt/zathura zathura/config.c color settings
do
  local keys = keyset(
    "default-fg default-bg inputbar-fg inputbar-bg statusbar-fg statusbar-bg completion-fg completion-bg "
      .. "completion-group-fg completion-group-bg completion-highlight-fg completion-highlight-bg "
      .. "notification-error-fg notification-error-bg notification-warning-fg notification-warning-bg "
      .. "notification-fg notification-bg index-fg index-bg index-active-fg index-active-bg scrollbar-fg "
      .. "scrollbar-bg recolor-darkcolor recolor-lightcolor highlight-color highlight-fg highlight-active-color "
      .. "visual-caret-color render-loading-bg render-loading-fg signature-success-color "
      .. "signature-warning-color signature-error-color"
  )
  for _, style in ipairs(styles) do
    local seen = {}
    for k, v in Extras.render("zathura", style):gmatch('\nset ([%w-]+) "([^"]+)"') do
      check(keys[k], style .. ": unknown zathura option " .. k)
      check(is_color(v) or v:match("^rgba%(%d+,%d+,%d+,[%d.]+%)$"), ("%s: zathura %s %s"):format(style, k, v))
      seen[k] = v
    end
    eq(seen["default-bg"], colors(style).bg, style .. ": zathura page background")
  end
end

-- xresources, termux and st: exactly the keys each reads, ANSI colors in order
for _, style in ipairs(styles) do
  local c = colors(style)
  local ansi = Extras.ansi(c)
  local x = {}
  for k, v in Extras.render("xresources", style):gmatch("\n%*%.(%w+): (%S+)") do
    x[k] = v
  end
  eq(vim.tbl_count(x), 19, style .. ": xresources keys")
  eq({ x.background, x.color0, x.color15 }, { c.bg, ansi[1], ansi[16] }, style .. ": xresources")
  -- termux-app TerminalColorScheme.updateWith(): anything else throws
  local t = {}
  for line in Extras.render("termux", style):gmatch("[^\n]+") do
    if not line:find("^#") then
      local k, v = line:match("^([%w]+)=(#%x+)$")
      check(
        k and (k == "foreground" or k == "background" or k == "cursor" or k:match("^color%d+$")),
        style .. ": " .. line
      )
      if k then
        t[k] = v
      end
    end
  end
  eq(vim.tbl_count(t), 19, style .. ": termux keys")
  eq({ t.background, t.color1 }, { c.bg, ansi[2] }, style .. ": termux")
  -- st config.def.h: 16 colors, then cursor, reverse cursor, fg, bg at 256..259
  local st = Extras.render("st", style)
  local list = {}
  for v in st:gmatch('\t"(#%x+)",') do
    list[#list + 1] = v
  end
  eq(#list, 20, style .. ": st colors")
  eq({ list[1], list[16], list[19], list[20] }, { ansi[1], ansi[16], c.terminal.white, c.bg }, style .. ": st order")
  if vim.fn.executable("cc") == 1 then
    local dir = vim.fn.tempname()
    vim.fn.mkdir(dir, "p")
    vim.fn.writefile(vim.split(st, "\n"), dir .. "/colors.h")
    vim.fn.writefile({
      "#include <stdio.h>",
      '#include "colors.h"',
      "int main(void) {",
      '  printf("%s %s %s %s", colorname[defaultfg], colorname[defaultbg], colorname[defaultcs], colorname[defaultrcs]);',
      "  return colorname[255] != 0;",
      "}",
    }, dir .. "/main.c")
    local out = vim.fn.system({ "cc", "-Wall", "-Werror", "-o", dir .. "/main", dir .. "/main.c" })
    eq(vim.v.shell_error, 0, style .. ": st header compiles: " .. out)
    eq(
      vim.fn.system({ dir .. "/main" }),
      table.concat({ c.terminal.white, c.bg, c.blue, c.bg }, " "),
      style .. ": st defaults"
    )
  end
end

-- helix: keys from book/src/themes.md, colors as in Neovim
do
  local keys = fixture("tests/fixtures/helix-keys.txt")
  local mods = keyset("bold dim italic underlined slow_blink rapid_blink reversed hidden crossed_out")
  local curls = keyset("line curl dashed dotted double_line")
  for _, style in ipairs(styles) do
    load(style)
    local text = Extras.render("helix", style)
    local theme = {}
    for k, v in text:gmatch('\n"([%w.%-]+)" = ([^\n]+)') do
      check(keys[k], style .. ": undocumented helix key " .. k)
      theme[k] = v
      for color in v:gmatch('"(#%x+)"') do
        check(is_color(color), ("%s: helix %s color %s"):format(style, k, color))
      end
      for list in v:gmatch("modifiers = %[([^%]]*)%]") do
        for m in list:gmatch('"([%w_]+)"') do
          check(mods[m], ("%s: helix %s modifier %s"):format(style, k, m))
        end
      end
      local curl = v:match('style = "([%w_]+)"')
      check(not curl or curls[curl], ("%s: helix %s underline style %s"):format(style, k, tostring(curl)))
    end
    check(text:find('\nrainbow = %["#'), style .. ": helix rainbow brackets")
    eq(theme["ui.selection"]:match('bg = "(#%x+)"'), hex(hl("Visual").bg), style .. ": helix selection as in Neovim")
    eq(theme["function"]:match("#%x+"), hex(hl("@function").fg), style .. ": helix functions as in Neovim")
    eq(theme["keyword"]:match("#%x+"), hex(hl("@keyword").fg), style .. ": helix keywords as in Neovim")
    eq(theme["diff.plus"]:match("#%x+"), hex(hl("Added").fg), style .. ": helix added as in Neovim")
  end
end

-- zed: keys from Zed's theme content and the bundled One theme, colors as in Neovim
do
  local style_keys = fixture("tests/fixtures/zed-keys.txt", "style")
  local syntax_keys = fixture("tests/fixtures/zed-keys.txt", "syntax")
  for _, style in ipairs(styles) do
    load(style)
    local family = vim.json.decode(Extras.render("zed", style))
    eq(family["$schema"], "https://zed.dev/schema/themes/v0.2.0.json", style .. ": zed schema")
    eq(#family.themes, 1, style .. ": one zed theme per file")
    local theme = family.themes[1]
    eq(theme.appearance, style == "light" and "light" or "dark", style .. ": zed appearance")
    for k, v in pairs(theme.style) do
      if k == "syntax" then
        for capture, hs in pairs(v) do
          check(syntax_keys[capture], style .. ": unknown zed syntax capture " .. capture)
          check(is_color(hs.color), ("%s: zed syntax %s color"):format(style, capture))
          check(hs.font_style == nil or hs.font_style == "italic", style .. ": zed font_style " .. capture)
        end
      elseif k == "players" or k == "accents" then
        check(#v > 0, style .. ": zed " .. k)
      else
        check(style_keys[k], style .. ": unknown zed style key " .. k)
        check(is_color(v, true), ("%s: zed %s = %s"):format(style, k, tostring(v)))
      end
    end
    local s = theme.style
    eq(s["editor.background"], hex(hl("Normal").bg), style .. ": zed editor background")
    eq(s["editor.active_line.background"], hex(hl("CursorLine").bg), style .. ": zed current line")
    eq(s["element.selection_background"], hex(hl("Visual").bg), style .. ": zed selection")
    eq(s["editor.diff_hunk.added.background"], hex(hl("DiffAdd").bg), style .. ": zed added lines")
    eq(s.syntax["function"].color, hex(hl("@function").fg), style .. ": zed functions")
  end
end

-- yazi: a flavor folder per style, preset keys only, previews use the bat theme
do
  local keys = fixture("tests/fixtures/yazi-keys.txt")
  local files = Extras.files("yazi")
  eq(vim.tbl_count(files), 2 * #styles, "yazi: flavor.toml and tmtheme.xml per style, no flat files")
  for _, style in ipairs(styles) do
    local dir = "extras/yazi/winteriscoming-" .. style .. ".yazi/"
    eq(files[dir .. "tmtheme.xml"], Extras.render("bat", style), style .. ": yazi tmtheme.xml is the bat theme")
    local section
    for line in assert(files[dir .. "flavor.toml"], style .. ": flavor.toml"):gmatch("[^\n]+") do
      local sec = line:match("^%[(%w+)%]$")
      local key = line:match("^([%w_]+) = ")
      if sec then
        section = sec
      elseif key then
        check(keys[section .. "." .. key], ("%s: unknown yazi key %s.%s"):format(style, section, key))
      end
      for color in line:gmatch('"(#%x+)"') do
        check(is_color(color), ("%s: yazi color %s"):format(style, color))
      end
    end
  end
end

-- zettlr: balanced CSS, every rule scoped to one Zettlr mode
for _, style in ipairs(styles) do
  local css = Extras.render("zettlr", style):gsub("/%*.-%*/", "")
  eq(select(2, css:gsub("{", "")), select(2, css:gsub("}", "")), style .. ": zettlr balanced braces")
  local mode = style == "light" and "html body:not(.dark)" or "html body.dark"
  for selectors in css:gmatch("([^{}]+){") do
    for sel in selectors:gmatch("[^,]+") do
      sel = vim.trim(sel)
      check(sel:sub(1, #mode) == mode, ("%s: unscoped zettlr selector %q"):format(style, sel))
    end
  end
end

-- vim: valid :highlight lines, same colors as Neovim, loads cleanly in Vim
do
  local files = Extras.files("vim")
  eq(vim.tbl_count(files), #styles, "vim: one colorscheme per style")
  local words = keyset("bold italic underline undercurl strikethrough reverse standout nocombine NONE")
  for _, style in ipairs(styles) do
    local text = files["extras/vim/colors/winteriscoming-" .. style .. ".vim"]
    check(text:find('let g:colors_name = "winteriscoming-' .. style .. '"', 1, true), style .. ": vim colors_name")
    local defined = {}
    for line in text:gmatch("[^\n]+") do
      local from, to = line:match("^hi! link (%S+) (%S+)$")
      if from then
        check(to:match("^[%w_]+$"), style .. ": vim link to a name Vim accepts: " .. from .. " -> " .. to)
      elseif line:match("^hi [%w_]+ ") then
        defined[line:match("^hi ([%w_]+)")] = line
        for k, v in line:gmatch("gui(%a*)=(%S+)") do
          if k == "" then
            for w in v:gmatch("[^,]+") do
              check(words[w], style .. ": vim attribute " .. w .. " in " .. line)
            end
          else
            check(v == "NONE" or is_color(v), style .. ": " .. line)
          end
        end
      end
    end
    load(style)
    for _, name in ipairs({ "Normal", "Comment", "Function", "DiffAdd", "Visual" }) do
      local h, line = hl(name), defined[name] or ""
      check(not h.fg or line:find("guifg=" .. hex(h.fg), 1, true), style .. ": vim " .. name .. " fg as in Neovim")
      check(not h.bg or line:find("guibg=" .. hex(h.bg), 1, true), style .. ": vim " .. name .. " bg as in Neovim")
    end
  end
  if vim.fn.executable("vim") == 1 then
    local dir = vim.fn.tempname()
    for path, content in pairs(files) do
      local file = dir .. "/" .. path:gsub("^extras/vim/", "")
      vim.fn.mkdir(vim.fs.dirname(file), "p")
      vim.fn.writefile(vim.split(content, "\n"), file)
    end
    local script, out = dir .. "/check.vim", dir .. "/check.out"
    vim.fn.writefile({
      "set termguicolors",
      "let s:out = []",
      "for s in " .. vim.json.encode(styles),
      "  let v:errmsg = ''",
      "  try | execute 'colorscheme winteriscoming-' . s | catch | let v:errmsg = v:exception | endtry",
      "  call add(s:out, s . '|' . v:errmsg . '|' . synIDattr(synIDtrans(hlID('Normal')), 'bg#'))",
      "endfor",
      "call writefile(s:out, " .. vim.fn.string(out) .. ")",
      "qa!",
    }, script)
    vim.fn.system({ "vim", "-Nu", "NONE", "-i", "NONE", "-es", "--cmd", "set rtp^=" .. dir, "-S", script })
    local lines = vim.fn.filereadable(out) == 1 and vim.fn.readfile(out) or {}
    eq(#lines, #styles, "vim ran every colorscheme")
    for i, style in ipairs(styles) do
      eq(lines[i], ("%s||%s"):format(style, colors(style).bg), style .. ": loads in Vim without errors")
    end
  end
end

if fails > 0 then
  io.stderr:write(fails .. " failures\n")
  os.exit(1)
end
print("all extras tests passed")

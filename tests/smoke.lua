-- Run: nvim --headless --clean -u NONE --cmd "set rtp^=." -l tests/smoke.lua
local fails = 0
local function check(cond, msg)
  if not cond then
    fails = fails + 1
    io.stderr:write("FAIL: " .. msg .. "\n")
  end
end

local wic = require("winteriscoming")
wic.setup({ cache = false, plugins = { all = true } })

for _, style in ipairs({ "blue", "black", "light" }) do
  vim.cmd.colorscheme("winteriscoming-" .. style)
  check(vim.g.colors_name == "winteriscoming-" .. style, "colors_name for " .. style)
  check(vim.o.background == (style == "light" and "light" or "dark"), "background for " .. style)

  local _, groups = require("winteriscoming.theme").setup({ style = style, cache = false, plugins = { all = true } })
  for name, hl in pairs(groups) do
    if type(hl) == "string" then
      check(groups[hl] ~= nil or vim.fn.hlexists(hl) == 1, style .. ": " .. name .. " links to missing " .. hl)
    else
      for _, key in ipairs({ "fg", "bg", "sp" }) do
        local v = hl[key]
        check(
          v == nil or v == "NONE" or (type(v) == "string" and v:match("^#%x%x%x%x%x%x$")),
          style .. ": bad " .. key .. " in " .. name .. ": " .. tostring(v)
        )
      end
      check(hl.style == nil, style .. ": unresolved style in " .. name)
    end
  end
end

-- defaults: comments and keywords italic, other code not
wic.setup({ cache = false, plugins = { all = true } })
vim.cmd.colorscheme("winteriscoming-blue")
check(vim.api.nvim_get_hl(0, { name = "Comment", link = false }).italic == true, "comments italic by default")
for _, g in ipairs({ "@keyword", "@keyword.return", "@keyword.import", "@keyword.conditional", "Statement" }) do
  check(vim.api.nvim_get_hl(0, { name = g, link = false }).italic == true, g .. " should be italic by default")
end
for _, g in ipairs({
  "@variable",
  "@function",
  "@function.method",
  "@property",
  "@variable.member",
  "@attribute",
  "@tag.attribute",
  "@operator",
  "@string",
  "@variable.parameter",
  "@type",
}) do
  check(not vim.api.nvim_get_hl(0, { name = g, link = false }).italic, g .. " should not be italic by default")
end

-- faithful restores the exact VS Code values
local hex = function(g)
  return string.format("#%06x", vim.api.nvim_get_hl(0, { name = g, link = false }).fg or 0)
end
check(hex("@function") == "#8fa2f8" and hex("Comment") == "#8a9db3", "adjusted defaults")
check(hex("@string.documentation") == "#a3c7ba", "docstring color")
wic.setup({ cache = false, faithful = true })
vim.cmd.colorscheme("winteriscoming-blue")
check(hex("@function") == "#87aff4", "faithful function color, got " .. hex("@function"))
check(hex("@variable") == "#a4ceee", "faithful variable color")
check(hex("@constant") == "#82aaff", "faithful constant color")
check(hex("@string.documentation") == "#bcf0c0", "faithful docstrings are strings")
check(hex("Comment") == "#999999", "faithful comment color, got " .. hex("Comment"))
vim.cmd.colorscheme("winteriscoming-black")
check(string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Visual" }).bg) == "#103362", "faithful black selection")
wic.setup({ cache = false, plugins = { all = true } })
vim.cmd.colorscheme("winteriscoming-blue")
check(hex("@lsp.typemod.property.declaration") == "#d6deeb", "declared fields use VS Code field color")
check(hex("BufferLineBufferSelected") ~= "#000000", "bufferline groups defined")
check(hex("BufferLineErrorSelected") == hex("BufferLineBufferSelected"), "tab name keeps its color with errors")
check(hex("BufferLineErrorDiagnosticSelected") == "#ef5350", "error count is red")
-- bufferline's `highlights` option follows the loaded style, and steps aside for other colorschemes
local bl = require("winteriscoming.groups.bufferline")
vim.cmd.colorscheme("winteriscoming-light")
check(bl.highlights().buffer_selected.bg == "#e3e3e3", "bufferline highlights follow the loaded style")
vim.cmd.colorscheme("default")
check(next(bl.highlights()) == nil, "bufferline highlights empty under another colorscheme")
vim.cmd.colorscheme("winteriscoming-blue")

-- background switching keeps the family
vim.cmd.colorscheme("winteriscoming-black")
vim.o.background = "light"
check(vim.g.colors_name == "winteriscoming-light", "bg=light switches to light, got " .. tostring(vim.g.colors_name))
vim.o.background = "dark"
check(vim.g.colors_name == "winteriscoming-black", "bg=dark returns to black, got " .. tostring(vim.g.colors_name))

-- plain :colorscheme follows background
vim.cmd("hi clear")
vim.g.colors_name = nil
vim.o.background = "light"
vim.cmd.colorscheme("winteriscoming")
check(vim.g.colors_name == "winteriscoming-light", "plain colorscheme on light bg")
vim.o.background = "dark"
vim.cmd.colorscheme("winteriscoming")
check(vim.g.colors_name == "winteriscoming-blue", "plain colorscheme on dark bg -> " .. tostring(vim.g.colors_name))

-- starting light and switching to dark uses the configured dark style
wic.setup({ cache = false, style = "black" })
wic.styles = {}
vim.o.background = "light"
vim.cmd.colorscheme("winteriscoming")
vim.o.background = "dark"
check(vim.g.colors_name == "winteriscoming-black", "light start, bg=dark -> " .. tostring(vim.g.colors_name))

-- italics = false removes every italic the theme sets. Only the theme's own
-- groups are checked: Neovim adds built-in groups over time (BoldItalic came
-- in 0.12), and plugins define their own, so a scan of every group breaks
-- whenever Neovim changes.
wic.setup({ cache = false, plugins = { all = true }, italics = false })
vim.cmd.colorscheme("winteriscoming-blue")
local _, owned = require("winteriscoming.theme").setup({ style = "blue" })
local italic = {}
for name in pairs(owned) do
  if vim.api.nvim_get_hl(0, { name = name, link = false }).italic then
    italic[#italic + 1] = name
  end
end
table.sort(italic)
check(#italic == 0, "italics=false left italics: " .. table.concat(italic, ", "))
check(not vim.api.nvim_get_hl(0, { name = "Comment", link = false }).italic, "italics=false: comments upright")
check(not vim.api.nvim_get_hl(0, { name = "@keyword", link = false }).italic, "italics=false: keywords upright")

-- transparent
wic.setup({ cache = false, transparent = true })
vim.cmd.colorscheme("winteriscoming-blue")
check(vim.api.nvim_get_hl(0, { name = "Normal" }).bg == nil, "transparent Normal has no bg")

-- cache round trip
local Util = require("winteriscoming.util")
Util.cache.clear()
wic.setup({ cache = true })
vim.cmd.colorscheme("winteriscoming-blue")
local first = vim.api.nvim_get_hl(0, { name = "@function" })
vim.cmd.colorscheme("winteriscoming-blue")
check(vim.deep_equal(first, vim.api.nvim_get_hl(0, { name = "@function" })), "cache round trip")
Util.cache.clear()

-- overrides
wic.setup({
  cache = false,
  on_colors = function(c)
    c.ice = "#ff0000"
  end,
  on_highlights = function(hl, c)
    hl.Comment = { fg = c.ice }
  end,
})
vim.cmd.colorscheme("winteriscoming-blue")
check(vim.api.nvim_get_hl(0, { name = "Comment" }).fg == 0xff0000, "on_colors/on_highlights")

-- invalid options warn once and fall back to their defaults
do
  local notify, warnings = vim.notify, {}
  vim.notify = function(msg)
    warnings[#warnings + 1] = msg
  end
  wic.setup({ cache = false, style = "nope", diagnostics = { underline = "wavy" }, borderless = "yes" })
  vim.notify = notify
  local o = require("winteriscoming.config").options
  check(#warnings == 1, "one warning for invalid options, got " .. #warnings)
  check(
    warnings[1] and warnings[1]:find("style") and warnings[1]:find("diagnostics.underline"),
    "warning names the options"
  )
  check(o.style == "blue" and o.diagnostics.underline == "undercurl" and o.borderless == false, "invalid options reset")
  check(o.diagnostics.virtual_text == "tinted", "valid sibling options kept")
end

local function hl(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end
local function load(opts)
  wic.setup(vim.tbl_extend("force", { cache = false, plugins = { all = true } }, opts or {}))
  vim.cmd.colorscheme("winteriscoming-blue")
end

-- plain options
load()
check(hl("DiagnosticUnderlineError").undercurl and hl("DiagnosticVirtualTextError").bg, "diagnostic defaults")
check(hl("LspInlayHint").bg and not hl("StatusLineNC").underline, "inlay hint and statusline defaults")
check(next(hl("@lsp.mod.static")) == nil, "semantic modifiers unstyled by default")
check(hl("TelescopeBorder").fg ~= hl("TelescopeBorder").bg, "telescope has borders by default")
load({
  diagnostics = { underline = "underline", virtual_text = "plain" },
  inlay_hints = "plain",
  hide_inactive_statusline = true,
  styles = { readonly = { italic = true }, statics = { bold = true }, mutable = { underline = true } },
  borderless = true,
  bright_borders = true,
})
check(hl("DiagnosticUnderlineError").underline and not hl("DiagnosticUnderlineError").undercurl, "underline style")
check(hl("DiagnosticVirtualTextError").bg == nil, "plain virtual text")
check(hl("LspInlayHint").bg == nil, "plain inlay hints")
check(hl("StatusLineNC").underline, "hidden inactive statusline")
check(hl("@lsp.mod.readonly").italic and hl("@lsp.mod.static").bold, "readonly / static modifiers")
check(hl("@lsp.typemod.variable.mutable.rust").underline, "mutable modifier")
check(
  hl("@lsp.typemod.parameter.mutable.rust").fg == hl("@variable.parameter").fg,
  "mutable rust params keep their color"
)
for _, g in ipairs({ "TelescopeBorder", "TelescopePromptBorder", "TelescopePreviewBorder", "FzfLuaBorder" }) do
  check(hl(g).fg == hl(g).bg, "borderless: " .. g .. " is invisible")
end
check(hl("TelescopePromptNormal").bg ~= hl("TelescopePreviewNormal").bg, "borderless: panels differ by shade")
check(hl("SnacksPickerInputBorder").fg == hl("SnacksPickerInput").bg, "borderless: snacks input")
check(string.format("#%06x", hl("FloatBorder").fg) == require("winteriscoming").colors().blue, "bright borders")
load({ diagnostics = { underline = false } })
check(
  not hl("DiagnosticUnderlineError").undercurl and not hl("DiagnosticUnderlineError").underline,
  "underline = false"
)

-- the cache notices option changes
do
  local Util = require("winteriscoming.util")
  Util.cache.clear()
  load({ cache = true })
  load({ cache = true, borderless = true })
  check(hl("TelescopeBorder").fg == hl("TelescopeBorder").bg, "cache: borderless applied")
  load({ cache = true })
  check(hl("TelescopeBorder").fg ~= hl("TelescopeBorder").bg, "cache: borderless removed")
  Util.cache.clear()
end

-- :checkhealth is quiet with stock colors and reports overrides that hurt contrast
do
  local function health(opts)
    load(opts)
    vim.cmd("silent checkhealth winteriscoming")
    local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
    vim.cmd("bwipeout!")
    return text
  end
  for _, style in ipairs({ "blue", "black", "light" }) do
    check(not health({ style = style }):find("WARNING"), "health: no warnings for stock " .. style)
  end
  local text = health({
    on_colors = function(c)
      c.syntax.string = "#203040"
    end,
  })
  check(text:find("below WCAG AA") and text:find("string"), "health: reports a low-contrast override")
end

-- color options ---------------------------------------------------------------
wic.setup({ cache = false })
local Util = require("winteriscoming.util")
local Colors = require("winteriscoming.colors")
local styles = { "blue", "black", "light" }
local function colors(style, opts)
  return Colors.setup(vim.tbl_extend("force", { style = style, cache = false }, opts or {}))
end
local function hex(g, key)
  local v = hl(g)[key or "fg"]
  return v and string.format("#%06x", v)
end

-- Color vision deficiency simulation (Machado, Oliveira & Fernandes 2009,
-- severity 1.0) and OKLab distance x100, to check colors stay apart.
local CVD = {
  protan = { { 0.152286, 1.052583, -0.204868 }, { 0.114503, 0.786281, 0.099216 }, { -0.003882, -0.048116, 1.051998 } },
  deutan = { { 0.367322, 0.860646, -0.227968 }, { 0.280085, 0.672501, 0.047413 }, { -0.011820, 0.042940, 0.968881 } },
  tritan = { { 1.255528, -0.076749, -0.178779 }, { -0.078411, 0.930809, 0.147602 }, { 0.004733, 0.691367, 0.303900 } },
}
local function simulate(color, kind)
  if kind == "normal" then
    return color
  end
  local function lin(v)
    v = v / 255
    return v <= 0.04045 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4
  end
  local function enc(v)
    v = math.min(1, math.max(0, v))
    return math.floor(255 * (v <= 0.0031308 and 12.92 * v or 1.055 * v ^ (1 / 2.4) - 0.055) + 0.5)
  end
  local x = Util.rgb(color)
  x = { lin(x[1]), lin(x[2]), lin(x[3]) }
  local m, o = CVD[kind], {}
  for i = 1, 3 do
    o[i] = enc(m[i][1] * x[1] + m[i][2] * x[2] + m[i][3] * x[3])
  end
  return string.format("#%02x%02x%02x", o[1], o[2], o[3])
end
-- smallest simulated distance between any two colors of `list` under `kinds`
local function separation(list, kinds)
  local worst = math.huge
  for _, kind in ipairs(kinds) do
    for i = 1, #list do
      for j = i + 1, #list do
        worst = math.min(worst, Util.distance(simulate(list[i], kind), simulate(list[j], kind)))
      end
    end
  end
  return worst
end

-- contrast = "high": every syntax role reaches WCAG AA, chrome is lifted
for _, style in ipairs(styles) do
  local c = colors(style, { contrast = "high" })
  for role, color in pairs(c.syntax) do
    check(
      Util.contrast(color, c.bg) >= 4.5,
      ("high contrast %s: syntax.%s %.2f"):format(style, role, Util.contrast(color, c.bg))
    )
  end
  check(Util.contrast(c.comment, c.bg) >= 6, "high contrast " .. style .. ": comments")
  check(Util.contrast(c.fg_muted, c.bg) >= 4.5, "high contrast " .. style .. ": muted text")
  check(colors(style).syntax.string == c.syntax.string or style == "light", "high contrast keeps roles already at AA")
end

-- subtle_comments: fades by contrast, keeps docstrings when asked, never vanishes
do
  local base = colors("blue")
  local half = colors("blue", { subtle_comments = true })
  local full = colors("blue", { subtle_comments = 1 })
  local keep = colors("blue", { subtle_comments = { fade = 0.5, docstrings = false } })
  local r = function(c, role)
    return Util.contrast(c.syntax[role], c.bg)
  end
  check(r(half, "comment") < r(base, "comment") and r(half, "docstring") < r(base, "docstring"), "subtle: fades")
  check(math.abs(r(full, "comment") - Colors.SUBTLE_FLOOR) < 0.1, "subtle: fade 1 stops at the floor")
  check(keep.syntax.docstring == base.syntax.docstring, "subtle: docstrings = false")
  check(keep.comment == base.comment, "subtle: UI uses of c.comment keep their contrast")
  local mine = colors("blue", {
    subtle_comments = true,
    on_colors = function(c)
      c.syntax.comment = "#778899"
    end,
  })
  check(mine.syntax.comment == "#778899", "subtle: a comment color set in on_colors is not faded")
  local both = colors("blue", { subtle_comments = true, contrast = "high" })
  check(r(both, "comment") < 4.5, "subtle: still fades with high contrast")
end

-- colorblind: diff, git and diagnostic colors stay apart under simulated CVD
do
  local modes = {
    ["red-green"] = { kinds = { "normal", "protan", "deutan" } },
    ["blue-yellow"] = { kinds = { "normal", "tritan" } },
  }
  for mode, want in pairs(modes) do
    for _, style in ipairs(styles) do
      local c = colors(style, { colorblind = mode })
      local where = mode .. "/" .. style
      local g = separation({ c.git.add, c.git.change, c.git.delete }, want.kinds)
      check(g >= 10, ("%s git signs %.1f"):format(where, g))
      local d = separation({ c.error, c.warning, c.ok }, want.kinds)
      check(d >= 10, ("%s error/warn/ok %.1f"):format(where, d))
      for _, soft in ipairs({ "info", "hint" }) do
        for _, hard in ipairs({ "error", "warning" }) do
          d = separation({ c[soft], c[hard] }, want.kinds)
          check(d >= 8, ("%s %s vs %s %.1f"):format(where, soft, hard, d))
        end
      end
      local f = separation({ c.diff.add, c.diff.delete }, want.kinds)
      check(f >= 4.5, ("%s diff add/delete %.1f"):format(where, f))
      for _, role in ipairs({ "error", "warning", "info", "hint", "ok" }) do
        check(Util.contrast(c[role], c.bg) >= 4.5, where .. " " .. role .. " contrast")
      end
    end
  end
  load({ colorblind = "red-green" })
  local c = require("winteriscoming").colors()
  check(hex("DiagnosticError") == c.error and c.error == c.ember, "colorblind: diagnostics follow")
  check(hex("DiffAdd", "bg") == c.diff.add and hex("Added") == c.sky, "colorblind: diff and git follow")
  check(hex("@string") == c.syntax.string and c.syntax.string == c.mint, "colorblind: syntax untouched")
  load({
    colorblind = "red-green",
    on_colors = function(cc)
      cc.git.add = cc.teal
    end,
  })
  check(hex("Added") == require("winteriscoming").colors().teal, "colorblind: on_colors wins")
end

-- saturation: greys at 0, contrast kept, status colors keep some hue
for _, style in ipairs(styles) do
  local plain = colors(style)
  local grey = colors(style, { saturation = 0 })
  for _, k in ipairs({ "red", "green", "blue", "cream", "lavender", "bg" }) do
    local _, a, b = Util.to_oklab(grey[k])
    check(math.sqrt(a * a + b * b) < 0.01, style .. ": " .. k .. " is grey at saturation 0")
  end
  for _, amount in ipairs({ 0, 0.4, 0.8 }) do
    local c = colors(style, { saturation = amount })
    for _, k in ipairs({ "comment", "fg", "fg_muted", "ice", "mint", "lavender", "periwinkle", "cream" }) do
      local want, got = Util.contrast(plain[k], plain.bg), Util.contrast(c[k], c.bg)
      check(
        math.abs(got - want) / want < 0.02,
        ("%s %s @%s: contrast %.2f vs %.2f"):format(style, k, amount, got, want)
      )
    end
    local _, a, b = Util.to_oklab(c.error)
    check(math.sqrt(a * a + b * b) > 0.05, ("%s @%s: errors keep their hue"):format(style, amount))
  end
end
check(colors("blue", { saturation = 1 }).blue == colors("blue").blue, "saturation 1 = unchanged")

-- accent: titles, borders, badges and the statusline follow
for _, style in ipairs(styles) do
  for _, accent in ipairs(require("winteriscoming.config").accents) do
    local c = colors(style, { accent = accent })
    check(c.accent == c[accent] and c.modes.normal == c[accent], style .. " accent " .. accent)
    -- the default blue badge on light (3.8:1) is the VS Code status bar
    if accent ~= "blue" then
      local r = Util.contrast(c.on_accent, c.accent)
      check(r >= 4.5, ("%s/%s: badge text %.2f"):format(style, accent, r))
    end
    local seen = {}
    for mode, color in pairs(c.modes) do
      check(
        not seen[color],
        ("%s/%s: modes %s and %s share a color"):format(style, accent, mode, tostring(seen[color]))
      )
      seen[color] = mode
    end
  end
end
load({ accent = "teal" })
check(hex("FloatTitle") == require("winteriscoming").colors().teal, "accent: titles")
check(
  hex("MiniStatuslineModeInsert", "bg") == require("winteriscoming").colors().green,
  "accent: other modes keep theirs"
)
check(
  require("lualine.themes.winteriscoming").normal.a.bg == require("winteriscoming").colors().teal,
  "accent: lualine"
)

-- rainbow: dimmed keeps hue at lower contrast, mono drops hue
for _, style in ipairs(styles) do
  local vivid = colors(style)
  local dimmed = colors(style, { rainbow = "dimmed" })
  local mono = colors(style, { rainbow = "mono" })
  for name, color in pairs(vivid.brackets) do
    local v, d = Util.contrast(color, vivid.bg), Util.contrast(dimmed.brackets[name], vivid.bg)
    -- dimmed stops at 3:1; light's bracket red already sits below that
    check(d <= v + 0.01 and d >= math.min(3, v) - 0.05, ("%s dimmed %s %.2f (vivid %.2f)"):format(style, name, d, v))
  end
  for i, color in ipairs(mono.scopes) do
    check(Util.contrast(color, mono.bg) >= 3, style .. " mono scope " .. i .. " readable")
  end
  check(dimmed.rainbow[1] == vivid.rainbow[1], style .. ": headings keep their colors")
end
load({ rainbow = "mono" })
check(hex("RainbowDelimiterRed") == require("winteriscoming").colors().brackets.red, "rainbow: delimiters follow")

-- rainbow_variables: 12 colors at AA on the cursorline, 6 with colorblind
for _, style in ipairs(styles) do
  for _, mode in ipairs({ false, "red-green", "blue-yellow" }) do
    local c = colors(style, { rainbow_variables = true, colorblind = mode })
    check(#c.variables == (mode and 6 or 12), ("%s/%s: %d variable colors"):format(style, tostring(mode), #c.variables))
    local seen = {}
    for i, color in ipairs(c.variables) do
      local r = Util.contrast(color, c.bg_highlight)
      check(r >= 4.4, ("%s/%s variable %d: %.2f on the cursorline"):format(style, tostring(mode), i, r))
      check(not seen[color], style .. ": variable colors are distinct")
      seen[color] = true
    end
  end
end
check(colors("blue").variables == nil, "rainbow_variables off by default")
load({ rainbow_variables = true })
check(require("winteriscoming.semantic").count == 12 and hex("WinteriscomingVariable1"), "rainbow_variables: groups")
load()
check(require("winteriscoming.semantic").count == 0, "rainbow_variables: off again")

-- plugin detection: vim.pack, lazy.nvim, or everything when neither is in use
do
  wic.setup({ cache = false })
  local Groups = require("winteriscoming.groups")
  local colors = require("winteriscoming.colors").setup({ style = "blue" })
  local function enabled(plugins)
    local _, on = Groups.setup(colors, require("winteriscoming.config").extend({ cache = false, plugins = plugins }))
    return on
  end
  local saved_lazy, saved_pack, saved_get = package.loaded.lazy, package.loaded["vim.pack"], vim.pack and vim.pack.get
  package.loaded.lazy = nil
  package.loaded["vim.pack"] = nil
  check(enabled({ auto = true }).telescope, "no plugin manager: every integration")

  vim.pack = vim.pack or {}
  package.loaded["vim.pack"] = vim.pack
  vim.pack.get = function()
    return { { spec = { name = "hop.nvim" } }, { spec = { name = "mini.nvim" } } }
  end
  local on = enabled({ auto = true })
  check(on.hop and on.mini_files and not on.telescope, "vim.pack: only installed plugins")
  check(enabled({ auto = true, telescope = true }).telescope, "vim.pack: manual override by module")
  check(not enabled({ auto = true, ["hop.nvim"] = false }).hop, "vim.pack: manual override by repo")
  check(enabled({ auto = false }).telescope, "auto = false: every integration")

  package.loaded.lazy, package.loaded["vim.pack"] = saved_lazy, saved_pack
  vim.pack.get = saved_get
end

-- lualine theme loads
for _, s in ipairs({ "", "-blue", "-black", "-light" }) do
  local ok, t = pcall(require, "lualine.themes.winteriscoming" .. s)
  check(ok and t.normal and t.normal.a.bg, "lualine theme winteriscoming" .. s)
end

if fails > 0 then
  io.stderr:write(fails .. " failures\n")
  os.exit(1)
end
print("all smoke tests passed")

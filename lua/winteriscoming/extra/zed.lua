-- Zed theme family (one theme per file). Keys from zed's ThemeColorsContent
-- and StatusColorsContent (crates/settings_content/src/theme.rs); syntax
-- keys are the captures zed's bundled themes style (assets/themes/one).
-- Zed paints these behind text, so solid colors land exactly where Neovim's
-- do; only player selections stay translucent, as zed's own themes do.
local Util = require("winteriscoming.util")

local M = {}

local function str(s)
  return '"' .. s:gsub('[\\"]', "\\%0") .. '"'
end

---@param c winteriscoming.ColorScheme
function M.generate(c)
  local s, g, t = c.syntax, c.git, c.terminal
  local st = c._styles or {}
  local function dim(color)
    return Util.blend_bg(color, 0.7)
  end
  local function soft(color) -- status backgrounds, like Neovim's tinted virtual text
    return Util.blend_bg(color, 0.1)
  end

  local sel = Util.blend_bg(c.blue, c.is_light and 0.2 or 0.3) -- PmenuSel
  -- stylua: ignore
  local colors = {
    { "background", c.bg_dark },
    { "border", c.border },
    { "border.variant", c.border },
    { "border.focused", c.border_highlight },
    { "border.selected", c.accent },
    { "border.transparent", "#00000000" },
    { "border.disabled", c.bg_widget },
    { "elevated_surface.background", c.bg_popup },
    { "surface.background", c.bg_dark },
    { "element.background", c.bg_highlight },
    { "element.hover", c.bg_widget },
    { "element.active", c.bg_visual },
    { "element.selected", sel },
    { "element.disabled", c.bg_highlight },
    { "element.selection_background", c.bg_visual },
    { "drop_target.background", c.bg_visual },
    { "drop_target.border", c.accent },
    { "ghost_element.background", "#00000000" },
    { "ghost_element.hover", c.bg_highlight },
    { "ghost_element.active", c.bg_widget },
    { "ghost_element.selected", sel },
    { "ghost_element.disabled", "#00000000" },
    { "text", c.fg },
    { "text.muted", c.fg_dark },
    { "text.placeholder", c.fg_muted },
    { "text.disabled", c.dark3 },
    { "text.accent", c.accent },
    { "icon", c.fg_dark },
    { "icon.muted", c.fg_muted },
    { "icon.disabled", c.dark3 },
    { "icon.placeholder", c.fg_muted },
    { "icon.accent", c.accent },
    { "debugger.accent", c.error },
    { "status_bar.background", c.bg_statusline },
    { "title_bar.background", c.bg_dark },
    { "title_bar.inactive_background", c.bg_darker },
    { "toolbar.background", c.bg },
    { "tab_bar.background", c.bg_darker },
    { "tab.inactive_background", c.bg_dark },
    { "tab.active_background", c.bg_widget },
    { "search.match_background", c.bg_search },
    { "search.active_match_background", Util.blend_bg(c.bg_cursearch, 0.4) },
    { "panel.background", c.bg_dark },
    { "panel.focused_border", c.accent },
    { "panel.indent_guide", c.fg_gutter },
    { "panel.indent_guide_hover", c.dark3 },
    { "panel.indent_guide_active", c.indent_scope },
    { "pane.focused_border", c.accent },
    { "pane_group.border", c.border },
    { "scrollbar.thumb.background", Util.blend_bg(c.blue, 0.45) },
    { "scrollbar.thumb.hover_background", Util.blend_bg(c.blue, 0.6) },
    { "scrollbar.thumb.active_background", Util.blend_bg(c.blue, 0.6) },
    { "scrollbar.thumb.border", "#00000000" },
    { "scrollbar.track.background", "#00000000" },
    { "scrollbar.track.border", "#00000000" },
    { "editor.foreground", c.fg },
    { "editor.background", c.bg },
    { "editor.gutter.background", c.bg },
    { "editor.subheader.background", c.bg_dark },
    { "editor.active_line.background", c.bg_highlight },
    { "editor.highlighted_line.background", c.bg_highlight },
    { "editor.debugger_active_line.background", Util.blend_bg(c.cream, 0.14) },
    { "editor.line_number", c.line_nr },
    { "editor.active_line_number", c.line_nr_cursor },
    { "editor.hover_line_number", c.fg_dark },
    { "editor.invisible", c.dark3 },
    { "editor.wrap_guide", c.fg_gutter },
    { "editor.active_wrap_guide", c.dark3 },
    { "editor.indent_guide", c.fg_gutter },
    { "editor.indent_guide_active", c.indent_scope },
    { "editor.document_highlight.read_background", c.bg_visual },
    { "editor.document_highlight.write_background", Util.blend_bg(c.blue, 0.3) },
    { "editor.document_highlight.bracket_background", Util.blend_bg(c.blue, 0.3) },
    { "editor.diff_hunk.added.background", c.diff.add },
    { "editor.diff_hunk.deleted.background", c.diff.delete },
    { "terminal.background", c.bg },
    { "terminal.foreground", t.white },
    { "terminal.ansi.background", c.bg },
    { "terminal.bright_foreground", t.white_bright },
    { "terminal.dim_foreground", c.fg_dark },
    { "link_text.hover", s.md_link },
    { "version_control.added", g.add },
    { "version_control.deleted", g.delete },
    { "version_control.modified", g.change },
    { "version_control.renamed", c.sky },
    { "version_control.conflict", g.conflict },
    { "version_control.ignored", g.ignore },
    { "version_control.word_added", Util.blend_bg(g.add, 0.32) },
    { "version_control.word_deleted", Util.blend_bg(g.delete, 0.32) },
    { "version_control.conflict_marker.ours", Util.blend_bg(g.add, 0.17) },
    { "version_control.conflict_marker.theirs", Util.blend_bg(g.conflict, 0.17) },
    { "vim.normal.background", c.modes.normal },
    { "vim.insert.background", c.modes.insert },
    { "vim.replace.background", c.modes.replace },
    { "vim.visual.background", c.modes.visual },
    { "vim.visual_line.background", c.modes.visual },
    { "vim.visual_block.background", c.modes.visual },
    { "vim.helix_normal.background", c.modes.normal },
    { "vim.helix_select.background", c.modes.visual },
    { "vim.normal.foreground", c.on_accent },
    { "vim.insert.foreground", c.on_accent },
    { "vim.replace.foreground", c.on_accent },
    { "vim.visual.foreground", c.on_accent },
    { "vim.visual_line.foreground", c.on_accent },
    { "vim.visual_block.foreground", c.on_accent },
    { "vim.helix_normal.foreground", c.on_accent },
    { "vim.helix_select.foreground", c.on_accent },
    { "vim.helix_jump_label.foreground", c.label },
    { "vim.yank.background", c.bg_search },
  }
  -- stylua: ignore
  for _, name in ipairs({ "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }) do
    colors[#colors + 1] = { "terminal.ansi." .. name, t[name] }
    colors[#colors + 1] = { "terminal.ansi.bright_" .. name, t[name .. "_bright"] }
    colors[#colors + 1] = { "terminal.ansi.dim_" .. name, dim(t[name]) }
  end
  -- stylua: ignore
  local status = {
    { "conflict", g.conflict }, { "created", g.add }, { "deleted", g.delete }, { "modified", g.change },
    { "renamed", c.sky }, { "ignored", g.ignore }, { "hidden", c.fg_muted }, { "unreachable", c.fg_muted },
    { "error", c.error }, { "warning", c.warning }, { "info", c.info }, { "hint", c.hint }, { "success", c.ok },
    { "predictive", c.dark5 },
  }
  for _, kv in ipairs(status) do
    colors[#colors + 1] = kv
    colors[#colors + 1] = { kv[1] .. ".background", soft(kv[2]) }
    colors[#colors + 1] = { kv[1] .. ".border", Util.blend_bg(kv[2], 0.5) }
  end

  local function italic(attrs)
    return attrs and attrs.italic and "italic" or nil
  end
  -- { capture, color, font_style?, font_weight? }
  -- stylua: ignore
  local syntax = {
    { "attribute", s.attribute, italic(st.attributes) },
    { "boolean", s.boolean },
    { "comment", s.comment, italic(st.comments) },
    { "comment.doc", s.docstring },
    { "constant", s.constant },
    { "constructor", s.constructor },
    { "embedded", c.fg },
    { "emphasis", c.fg, "italic" },
    { "emphasis.strong", c.fg, nil, 700 },
    { "enum", s.type },
    { "function", s.func, italic(st.functions) },
    { "hint", c.dark5, italic(st.inlay_hints) },
    { "keyword", s.keyword, italic(st.keywords) },
    { "label", s.label },
    { "link_text", s.md_link_text },
    { "link_uri", s.md_link },
    { "namespace", s.module },
    { "number", s.number },
    { "operator", s.operator },
    { "predictive", c.dark5, "italic" },
    { "preproc", s.storage },
    { "primary", c.fg },
    { "property", s.property, italic(st.properties) },
    { "punctuation", s.punctuation },
    { "punctuation.bracket", s.punctuation },
    { "punctuation.delimiter", s.delimiter },
    { "punctuation.list_marker", s.md_list },
    { "punctuation.markup", c.fg_muted },
    { "punctuation.special", s.template },
    { "selector", s.tag },
    { "selector.pseudo", s.tag_attribute },
    { "string", s.string, italic(st.strings) },
    { "string.escape", s.escape },
    { "string.regex", s.regexp },
    { "string.special", s.escape },
    { "string.special.symbol", s.constant },
    { "tag", s.tag },
    { "text.literal", s.md_code },
    { "title", s.heading, nil, 700 },
    { "type", s.type, italic(st.types) },
    { "variable", s.variable, italic(st.variables) },
    { "variable.parameter", s.param, italic(st.parameters) },
    { "variable.special", s.builtin_var },
    { "variant", s.constant },
    { "diff.plus", g.add },
    { "diff.minus", g.delete },
  }

  local L = {}
  local function add(line)
    L[#L + 1] = line
  end
  add("{")
  add('  "$schema": "https://zed.dev/schema/themes/v0.2.0.json",')
  add(('  "name": %s,'):format(str(c._style_name)))
  add(('  "author": %s,'):format(str(c._upstream_url)))
  add('  "themes": [')
  add("    {")
  add(('      "name": %s,'):format(str(c._style_name)))
  add(('      "appearance": "%s",'):format(c.is_light and "light" or "dark"))
  add('      "style": {')
  for _, kv in ipairs(colors) do
    add(("        %s: %s,"):format(str(kv[1]), str(kv[2])))
  end
  local accents = {}
  for _, color in ipairs(c.rainbow) do
    accents[#accents + 1] = str(color)
  end
  add(('        "accents": [%s],'):format(table.concat(accents, ", ")))
  add('        "players": [')
  local players = { c.accent, c.green, c.purple, c.ember, c.teal, c.pink, c.cream, c.red }
  for i, color in ipairs(players) do
    add(
      ('          { "cursor": %s, "background": %s, "selection": %s }%s'):format(
        str(color),
        str(color),
        str(color .. (c.is_light and "33" or "3d")),
        i < #players and "," or ""
      )
    )
  end
  add("        ],")
  add('        "syntax": {')
  for i, e in ipairs(syntax) do
    local parts = { '"color": ' .. str(e[2]) }
    if e[3] then
      parts[#parts + 1] = '"font_style": ' .. str(e[3])
    end
    if e[4] then
      parts[#parts + 1] = '"font_weight": ' .. e[4]
    end
    add(("          %s: { %s }%s"):format(str(e[1]), table.concat(parts, ", "), i < #syntax and "," or ""))
  end
  add("        }")
  add("      }")
  add("    }")
  add("  ]")
  add("}")
  return table.concat(L, "\n") .. "\n"
end

return M

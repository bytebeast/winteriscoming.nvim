-- Helix theme. Scopes from book/src/themes.md (syntax and interface keys),
-- colored from the same roles and UI colors Neovim uses, so code, diffs,
-- diagnostics and selections look the same in both editors.
local Util = require("winteriscoming.util")

local M = {}

-- TOML inline table for one style: { fg, bg, underline = { color, style }, modifiers }
local function style(s)
  if type(s) == "string" then
    return ('"%s"'):format(s)
  end
  local parts = {}
  for _, k in ipairs({ "fg", "bg" }) do
    if s[k] then
      parts[#parts + 1] = ('%s = "%s"'):format(k, s[k])
    end
  end
  if s.underline then
    parts[#parts + 1] = ('underline = { color = "%s", style = "%s" }'):format(s.underline[1], s.underline[2])
  end
  if s.modifiers and #s.modifiers > 0 then
    parts[#parts + 1] = ('modifiers = ["%s"]'):format(table.concat(s.modifiers, '", "'))
  end
  return "{ " .. table.concat(parts, ", ") .. " }"
end

---@param c winteriscoming.ColorScheme
function M.generate(c)
  local s, g = c.syntax, c.git
  local st = c._styles or {}
  local function with(fg, attrs)
    local mods = {}
    for attr, mod in pairs({ italic = "italic", bold = "bold", underline = "underlined" }) do
      if attrs and attrs[attr] then
        mods[#mods + 1] = mod
      end
    end
    table.sort(mods)
    return #mods > 0 and { fg = fg, modifiers = mods } or fg
  end
  local function inline(color) -- like Neovim's tinted diagnostic virtual text
    return { fg = color, bg = Util.blend_bg(color, 0.1) }
  end
  local function badge(bg)
    return { fg = c.on_accent, bg = bg, modifiers = { "bold" } }
  end
  local sel = Util.blend_bg(c.blue, c.is_light and 0.2 or 0.3) -- PmenuSel

  -- stylua: ignore
  local scopes = {
    { "attribute", with(s.attribute, st.attributes) },
    { "type", with(s.type, st.types) },
    { "type.builtin", s.type_builtin },
    { "type.parameter", s.type },
    { "type.enum.variant", s.constant },
    { "constructor", s.constructor },
    { "constant", s.constant },
    { "constant.builtin", s.constant_builtin },
    { "constant.builtin.boolean", s.boolean },
    { "constant.character", s.string },
    { "constant.character.escape", s.escape },
    { "constant.numeric", s.number },
    { "string", with(s.string, st.strings) },
    { "string.regexp", s.regexp },
    { "string.special", s.escape },
    { "string.special.path", s.md_link },
    { "string.special.url", { fg = s.md_link, modifiers = { "underlined" } } },
    { "string.special.symbol", s.constant },
    { "comment", with(s.comment, st.comments) },
    { "comment.unused", c.fg_muted },
    { "variable", with(s.variable, st.variables) },
    { "variable.builtin", with(s.builtin_var, st.keywords) },
    { "variable.parameter", with(s.param, st.parameters) },
    { "variable.other.member", with(s.property, st.properties) },
    { "label", s.label },
    { "punctuation", s.punctuation },
    { "punctuation.special", s.template },
    { "keyword", with(s.keyword, st.keywords) },
    { "keyword.control.conditional", with(s.keyword, st.keywords) },
    { "keyword.control.repeat", with(s.keyword, st.keywords) },
    { "keyword.control.return", with(s.keyword, st.keywords) },
    { "keyword.control.import", with(s.keyword, st.keywords) },
    { "keyword.control.exception", with(s.keyword, st.keywords) },
    { "keyword.storage", with(s.storage, st.keywords) },
    { "keyword.directive", s.storage },
    { "operator", with(s.operator, st.operators) },
    { "function", with(s.func, st.functions) },
    { "function.method", with(s.method, st.functions) },
    { "function.builtin", s.func_builtin },
    { "function.macro", s.storage },
    { "function.special", s.storage },
    { "tag", s.tag },
    { "namespace", s.module },
    { "special", s.field },
    { "embedded", c.fg },

    { "markup.heading.marker", c.fg_muted },
    { "markup.list", s.md_list },
    { "markup.list.checked", c.ok },
    { "markup.list.unchecked", c.fg_muted },
    { "markup.bold", { fg = s.md_bold, modifiers = { "bold" } } },
    { "markup.italic", { fg = s.md_italic, modifiers = { "italic" } } },
    { "markup.strikethrough", { modifiers = { "crossed_out" } } },
    { "markup.link.url", { fg = s.md_link, modifiers = { "underlined" } } },
    { "markup.link.label", s.md_link_text },
    { "markup.link.text", s.md_link_text },
    { "markup.quote", { fg = s.md_quote, modifiers = { "italic" } } },
    { "markup.raw", s.md_code },
    { "markup.raw.block", s.md_code },

    { "diff.plus", g.add },
    { "diff.minus", g.delete },
    { "diff.delta", g.change },
    { "diff.delta.conflict", g.conflict },

    { "ui.background", { bg = c.bg } },
    { "ui.background.separator", c.border },
    { "ui.cursor", { fg = c.bg, bg = c.fg_muted } },
    { "ui.cursor.primary", { fg = c.bg, bg = c.blue } },
    { "ui.cursor.primary.insert", { fg = c.bg, bg = c.modes.insert } },
    { "ui.cursor.primary.select", { fg = c.bg, bg = c.modes.visual } },
    { "ui.cursor.match", { fg = c.cream, bg = Util.blend_bg(c.blue, 0.3), modifiers = { "bold" } } },
    { "ui.debug.breakpoint", c.error },
    { "ui.debug.active", c.cream },
    { "ui.linenr", c.line_nr },
    { "ui.linenr.selected", { fg = c.line_nr_cursor, modifiers = { "bold" } } },
    { "ui.statusline", { fg = c.fg_sidebar, bg = c.bg_statusline } },
    { "ui.statusline.inactive", { fg = c.fg_muted, bg = c.bg_statusline } },
    { "ui.statusline.normal", badge(c.modes.normal) },
    { "ui.statusline.insert", badge(c.modes.insert) },
    { "ui.statusline.select", badge(c.modes.visual) },
    { "ui.statusline.separator", c.border },
    { "ui.bufferline", { fg = c.fg_muted, bg = c.bg_dark } },
    { "ui.bufferline.active", { fg = c.fg_light, bg = c.bg_widget, modifiers = { "bold" } } },
    { "ui.bufferline.background", { bg = c.bg_darker } },
    { "ui.popup", { fg = c.fg, bg = c.bg_dark } },
    { "ui.popup.info", { fg = c.fg, bg = c.bg_dark } },
    { "ui.picker.header.column.active", { fg = c.accent, modifiers = { "bold" } } },
    { "ui.window", c.border },
    { "ui.help", { fg = c.fg, bg = c.bg_dark } },
    { "ui.text", c.fg },
    { "ui.text.focus", { fg = c.fg_bright, bg = sel, modifiers = { "bold" } } },
    { "ui.text.inactive", c.fg_muted },
    { "ui.text.info", c.fg_dark },
    { "ui.text.directory", c.sky },
    { "ui.text.symlink", c.teal },
    { "ui.virtual.ruler", { bg = c.bg_dark } },
    { "ui.virtual.whitespace", c.fg_gutter },
    { "ui.virtual.indent-guide", c.fg_gutter },
    { "ui.virtual.inlay-hint", { fg = c.dark5, bg = c.bg_inlay } },
    { "ui.virtual.wrap", c.dark3 },
    { "ui.virtual.jump-label", badge(c.label) },
    { "ui.menu", { fg = c.fg_light, bg = c.bg_popup } },
    { "ui.menu.selected", { bg = sel, modifiers = { "bold" } } },
    { "ui.menu.scroll", { fg = Util.blend_bg(c.blue, 0.45), bg = c.bg_widget } },
    { "ui.selection", { bg = c.bg_visual } },
    { "ui.highlight", { bg = c.bg_visual } },
    { "ui.highlight.frameline", { bg = Util.blend_bg(c.cream, 0.14) } },
    { "ui.cursorline.primary", { bg = c.bg_highlight } },
    { "ui.cursorcolumn.primary", { bg = c.bg_highlight } },

    { "error", c.error },
    { "warning", c.warning },
    { "info", c.info },
    { "hint", c.hint },
    { "error.diagnostic.inline", inline(c.error) },
    { "warning.diagnostic.inline", inline(c.warning) },
    { "info.diagnostic.inline", inline(c.info) },
    { "hint.diagnostic.inline", inline(c.hint) },
    { "diagnostic.error", { underline = { c.error, "curl" } } },
    { "diagnostic.warning", { underline = { c.warning, "curl" } } },
    { "diagnostic.info", { underline = { c.info, "curl" } } },
    { "diagnostic.hint", { underline = { c.hint, "curl" } } },
    { "diagnostic.unnecessary", { modifiers = { "dim" } } },
    { "diagnostic.deprecated", { modifiers = { "crossed_out" } } },
    { "tabstop", { bg = Util.blend_bg(c.lavender, 0.15) } },
  }
  for i = 1, 6 do
    table.insert(scopes, { "markup.heading." .. i, { fg = c.rainbow[i], modifiers = { "bold" } } })
  end

  local out = {
    ('# %s for Helix: copy to ~/.config/helix/themes/, then set theme = "%s"'):format(c._style_name, c._name),
    "# upstream: " .. c._upstream_url,
    "",
  }
  for _, kv in ipairs(scopes) do
    out[#out + 1] = ('"%s" = %s'):format(kv[1], style(kv[2]))
  end
  -- rainbow brackets in rainbow-delimiters' nesting order, as in Neovim
  local b = c.brackets
  out[#out + 1] = ('rainbow = ["%s"]'):format(
    table.concat({ b.red, b.yellow, b.blue, b.orange, b.green, b.violet, b.cyan }, '", "')
  )
  return table.concat(out, "\n") .. "\n"
end

return M

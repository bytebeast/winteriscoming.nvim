-- TextMate theme for bat (and delta, which uses bat's themes).
-- Install: copy to "$(bat --config-dir)/themes/" and run `bat cache --build`.
local M = {}

local function esc(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

---@param c winteriscoming.ColorScheme
function M.generate(c)
  local s = c.syntax
  -- scope list, color, font style
  -- stylua: ignore
  local rules = {
    { "Comment",          "comment, punctuation.definition.comment", s.comment, "italic" },
    { "String",           "string", s.string },
    { "Escape",           "constant.character.escape", s.escape },
    { "Regex",            "string.regexp", s.regexp },
    { "Template",         "string.template meta.template.expression, punctuation.definition.template-expression", s.template },
    { "Number",           "constant.numeric", s.number },
    { "Boolean",          "constant.language.boolean", s.boolean },
    { "Built-in const",   "constant.language, support.constant", s.constant_builtin },
    { "Constant",         "constant, variable.other.constant", s.constant },
    { "Keyword",          "keyword, storage.type, storage.modifier, keyword.control", s.keyword },
    { "Operator",         "keyword.operator", s.operator },
    { "This",             "variable.language", s.builtin_var },
    { "Variable",         "variable, variable.other", s.variable },
    { "Parameter",        "variable.parameter", s.param },
    { "Property",         "variable.other.property, variable.other.object.property, meta.property-name", s.property },
    { "Support property", "support.variable.property", s.field },
    { "Function",         "entity.name.function, meta.function-call, support.function.any-method", s.func },
    { "Library function", "support.function", s.func_builtin },
    { "Type",             "entity.name.type, entity.name.class, storage.type.class, entity.name.struct", s.type },
    { "Library type",     "support.type, support.class", s.type_builtin },
    { "Inherited",        "entity.other.inherited-class", s.inherited },
    { "Decorator",        "meta.decorator, punctuation.decorator, entity.name.function.decorator", s.attribute },
    { "Tag",              "entity.name.tag", s.tag },
    { "Attribute",        "entity.other.attribute-name", s.tag_attribute },
    { "Punctuation",      "punctuation, meta.brace", s.punctuation },
    { "Module",           "entity.name.namespace, entity.name.module, variable.other.meta.import", s.module },
    { "JSON key",         "support.type.property-name, meta.mapping.key string", s.json_key },
    { "Heading",          "markup.heading, entity.name.section", s.heading, "bold" },
    { "Bold",             "markup.bold", s.md_bold, "bold" },
    { "Italic",           "markup.italic", s.md_italic, "italic" },
    { "Code",             "markup.raw, markup.inline.raw", s.md_code },
    { "Link",             "markup.underline.link", s.md_link, "underline" },
    { "Quote",            "markup.quote", s.md_quote, "italic" },
    { "List",             "markup.list punctuation.definition.list", s.md_list },
    { "Inserted",         "markup.inserted", s.md_inserted },
    { "Deleted",          "markup.deleted", s.md_deleted },
    { "Changed",          "markup.changed", c.git.change },
    { "Diff header",      "meta.diff.header, meta.diff.range", c.blue },
    { "Invalid",          "invalid", c.error, "underline" },
  }

  local out = {
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">',
    '<plist version="1.0">',
    "<dict>",
    "  <key>name</key><string>" .. esc(c._style_name) .. "</string>",
    "  <key>settings</key>",
    "  <array>",
    "    <dict><key>settings</key><dict>",
    "      <key>background</key><string>" .. c.bg .. "</string>",
    "      <key>foreground</key><string>" .. c.fg .. "</string>",
    "      <key>caret</key><string>" .. c.blue .. "</string>",
    "      <key>selection</key><string>" .. c.bg_visual .. "</string>",
    "      <key>lineHighlight</key><string>" .. c.bg_highlight .. "</string>",
    "      <key>gutterForeground</key><string>" .. c.line_nr .. "</string>",
    "      <key>findHighlight</key><string>" .. c.bg_cursearch .. "</string>",
    "    </dict></dict>",
  }
  for _, r in ipairs(rules) do
    out[#out + 1] = "    <dict>"
    out[#out + 1] = "      <key>name</key><string>" .. esc(r[1]) .. "</string>"
    out[#out + 1] = "      <key>scope</key><string>" .. esc(r[2]) .. "</string>"
    out[#out + 1] = "      <key>settings</key><dict><key>foreground</key><string>"
      .. r[3]
      .. "</string>"
      .. (r[4] and ("<key>fontStyle</key><string>" .. r[4] .. "</string>") or "")
      .. "</dict>"
    out[#out + 1] = "    </dict>"
  end
  out[#out + 1] = "  </array>"
  out[#out + 1] = "</dict>"
  out[#out + 1] = "</plist>"
  return table.concat(out, "\n") .. "\n"
end

return M

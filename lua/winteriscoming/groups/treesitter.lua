local Util = require("winteriscoming.util")

local M = {}

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local s = c.syntax
  local st = opts.styles

  -- stylua: ignore
  local ret = {
    ["@none"]                       = {},

    -- Comments
    ["@comment"]                    = "Comment",
    ["@comment.documentation"]      = { fg = Util.blend(s.comment, 0.85, s.string), style = st.comments },
    ["@comment.error"]              = { fg = c.error, bold = true },
    ["@comment.warning"]            = { fg = c.warning, bold = true },
    ["@comment.todo"]               = { fg = c.todo, bold = true },
    ["@comment.note"]               = { fg = c.hint, bold = true },
    ["@comment.info"]               = { fg = c.info },
    ["@comment.hint"]               = { fg = c.hint },

    -- Literals
    ["@string"]                     = "String",
    ["@string.documentation"]       = { fg = s.docstring, style = st.strings },
    ["@string.regexp"]              = { fg = s.regexp },
    ["@string.escape"]              = { fg = s.escape },
    ["@string.special"]             = { fg = s.escape },
    ["@string.special.symbol"]      = { fg = s.constant },
    ["@string.special.url"]         = { fg = s.md_link, underline = true },
    ["@string.special.path"]        = { fg = s.md_link },
    ["@character"]                  = "Character",
    ["@character.special"]          = "SpecialChar",
    ["@character.printf"]           = "SpecialChar",
    ["@boolean"]                    = "Boolean",
    ["@number"]                     = "Number",
    ["@number.float"]               = "Float",

    -- Identifiers
    ["@variable"]                   = { fg = s.variable, style = st.variables },
    ["@variable.builtin"]           = { fg = s.builtin_var, style = st.keywords }, -- this, self
    ["@variable.parameter"]         = { fg = s.param, style = st.parameters },
    ["@variable.parameter.builtin"] = { fg = s.builtin_var, style = st.parameters },
    ["@variable.member"]            = { fg = s.property, style = st.properties },
    ["@property"]                   = { fg = s.property, style = st.properties },
    ["@constant"]                   = "Constant",
    ["@constant.builtin"]           = { fg = s.constant_builtin },
    ["@constant.macro"]             = { fg = s.storage },
    ["@module"]                     = { fg = s.module },
    ["@module.builtin"]             = { fg = s.type_builtin },
    ["@label"]                      = "Label",

    -- Types
    ["@type"]                       = "Type",
    ["@type.builtin"]               = { fg = s.type_builtin, style = st.types },
    ["@type.definition"]            = { fg = s.type, style = st.types },
    ["@attribute"]                  = { fg = s.attribute, style = st.attributes }, -- decorators
    ["@attribute.builtin"]          = { fg = s.attribute, style = st.attributes },

    -- Functions
    ["@function"]                   = "Function",
    ["@function.builtin"]           = { fg = s.func_builtin },
    ["@function.call"]              = "@function",
    ["@function.macro"]             = { fg = s.storage },
    ["@function.method"]            = { fg = s.method, style = st.functions },
    ["@function.method.call"]       = "@function.method",
    ["@constructor"]                = { fg = s.constructor },
    ["@constructor.lua"]            = { fg = s.punctuation }, -- `{}` table constructors
    ["@operator"]                   = "Operator",

    -- Keywords
    ["@keyword"]                    = "Keyword",
    ["@keyword.coroutine"]          = "@keyword",
    ["@keyword.function"]           = "@keyword",
    ["@keyword.operator"]           = { fg = s.keyword, style = st.keywords }, -- and, or, not, typeof, in
    ["@keyword.import"]             = { fg = s.keyword, style = st.keywords },
    ["@keyword.type"]               = { fg = s.keyword, style = st.keywords },
    ["@keyword.modifier"]           = { fg = s.keyword, style = st.keywords },
    ["@keyword.repeat"]             = "Repeat",
    ["@keyword.return"]             = "@keyword",
    ["@keyword.debug"]              = "Debug",
    ["@keyword.exception"]          = "Exception",
    ["@keyword.conditional"]        = "Conditional",
    ["@keyword.conditional.ternary"]= "@operator",
    ["@keyword.directive"]          = "PreProc",
    ["@keyword.directive.define"]   = "Define",
    ["@keyword.storage"]            = "StorageClass",

    -- Punctuation
    ["@punctuation.delimiter"]      = { fg = s.delimiter }, -- `:` `,` `.` are icy in the original
    ["@punctuation.bracket"]        = { fg = s.punctuation },
    ["@punctuation.special"]        = { fg = s.template }, -- `${}` in template strings

    -- Tags (HTML / JSX)
    ["@tag"]                        = { fg = s.tag },
    ["@tag.builtin"]                = { fg = s.tag },
    ["@tag.attribute"]              = { fg = s.tag_attribute, style = st.attributes },
    ["@tag.delimiter"]              = { fg = s.punctuation },
    ["@tag.tsx"]                    = { fg = s.type }, -- <MyComponent>
    ["@tag.javascript"]             = { fg = s.type },
    ["@tag.builtin.tsx"]            = { fg = s.tag },
    ["@tag.builtin.javascript"]     = { fg = s.tag },

    -- Markup
    ["@markup"]                     = "@none",
    ["@markup.strong"]              = { fg = s.md_bold, bold = true },
    ["@markup.italic"]              = { fg = s.md_italic, italic = true },
    ["@markup.strikethrough"]       = { strikethrough = true },
    ["@markup.underline"]           = { underline = true },
    ["@markup.heading"]             = "Title",
    ["@markup.quote"]               = { fg = s.md_quote, italic = true },
    ["@markup.math"]                = { fg = s.constant },
    ["@markup.environment"]         = "Macro",
    ["@markup.environment.name"]    = "Type",
    ["@markup.link"]                = { fg = s.md_link_text },
    ["@markup.link.label"]          = { fg = s.md_link_text },
    ["@markup.link.label.symbol"]   = "Identifier",
    ["@markup.link.url"]            = { fg = s.md_link, underline = true },
    ["@markup.raw"]                 = { fg = s.md_code },
    ["@markup.raw.block"]           = { fg = s.md_code },
    ["@markup.raw.markdown_inline"] = { fg = s.md_code, bg = c.bg_widget },
    ["@markup.list"]                = { fg = s.md_list },
    ["@markup.list.markdown"]       = { fg = s.md_list, bold = true },
    ["@markup.list.checked"]        = { fg = c.ok },
    ["@markup.list.unchecked"]      = { fg = c.fg_muted },
    ["@punctuation.special.markdown"] = { fg = s.md_list },

    -- Diff
    ["@diff.plus"]                  = { fg = c.git.add },
    ["@diff.minus"]                 = { fg = c.git.delete },
    ["@diff.delta"]                 = { fg = c.git.change },

    -- Language specific touches from the VS Code theme
    ["@property.json"]              = { fg = s.json_key },
    ["@property.jsonc"]             = { fg = s.json_key },
    ["@property.json5"]             = { fg = s.json_key },
    ["@property.yaml"]              = { fg = s.json_key },
    ["@property.toml"]              = { fg = s.json_key },
    ["@type.css"]                   = { fg = s.tag }, -- element selectors
    ["@property.css"]               = { fg = s.field },
    ["@property.scss"]              = { fg = s.field },
    ["@string.css"]                 = { fg = s.string },
    ["@function.builtin.bash"]      = { fg = s.func_builtin },
    ["@variable.builtin.bash"]      = { fg = s.constant_builtin },
    ["@constant.builtin.lua"]       = { fg = s.constant_builtin },
    ["@keyword.dockerfile"]         = { fg = s.keyword, style = st.keywords },
  }

  -- Headings: H1 keeps the original jade, the rest walk the rainbow
  for i, color in ipairs(c.rainbow) do
    ret["@markup.heading." .. i .. ".markdown"] = { fg = color, bold = true }
    ret["@markup.heading." .. i] = { fg = color, bold = true }
  end

  return ret
end

return M

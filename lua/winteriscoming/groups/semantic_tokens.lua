local M = {}

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local s = c.syntax
  -- stylua: ignore
  local ret = {
    ["@lsp.type.boolean"]                      = "@boolean",
    ["@lsp.type.builtinType"]                  = "@type.builtin",
    ["@lsp.type.class"]                        = "@type",
    ["@lsp.type.comment"]                      = "@comment",
    ["@lsp.type.decorator"]                    = "@attribute",
    ["@lsp.type.deriveHelper"]                 = "@attribute",
    ["@lsp.type.enum"]                         = "@type",
    ["@lsp.type.enumMember"]                   = "@constant",
    ["@lsp.type.escapeSequence"]               = "@string.escape",
    ["@lsp.type.formatSpecifier"]              = "@markup.list",
    ["@lsp.type.function"]                     = "@function",
    ["@lsp.type.generic"]                      = "@variable",
    ["@lsp.type.interface"]                    = { fg = s.type, style = opts.styles.types },
    ["@lsp.type.keyword"]                      = "@keyword",
    ["@lsp.type.lifetime"]                     = "@keyword.storage",
    ["@lsp.type.macro"]                        = "@function.macro",
    ["@lsp.type.method"]                       = "@function.method",
    ["@lsp.type.member"]                       = "@function.method", -- older tsserver name for methods
    ["@lsp.type.namespace"]                    = "@module",
    ["@lsp.type.namespace.python"]             = "@variable",
    ["@lsp.type.number"]                       = "@number",
    ["@lsp.type.operator"]                     = "@operator",
    ["@lsp.type.parameter"]                    = "@variable.parameter",
    ["@lsp.type.property"]                     = "@property",
    ["@lsp.type.selfKeyword"]                  = "@variable.builtin",
    ["@lsp.type.selfTypeKeyword"]              = "@variable.builtin",
    ["@lsp.type.string"]                       = "@string",
    ["@lsp.type.struct"]                       = "@type",
    ["@lsp.type.type"]                         = "@type",
    ["@lsp.type.typeAlias"]                    = "@type.definition",
    ["@lsp.type.typeParameter"]                = { fg = s.type, style = opts.styles.types },
    ["@lsp.type.unresolvedReference"]          = { undercurl = true, sp = c.error },
    ["@lsp.type.variable"]                     = {}, -- let treesitter decide
    ["@lsp.mod.deprecated"]                    = { strikethrough = true },
    ["@lsp.mod.readonly"]                      = {},
    ["@lsp.typemod.class.defaultLibrary"]      = "@type.builtin",
    ["@lsp.typemod.enum.defaultLibrary"]       = "@type.builtin",
    ["@lsp.typemod.enumMember.defaultLibrary"] = "@constant.builtin",
    ["@lsp.typemod.function.defaultLibrary"]   = "@function.builtin",
    ["@lsp.typemod.keyword.async"]             = "@keyword.coroutine",
    ["@lsp.typemod.keyword.injected"]          = "@keyword",
    ["@lsp.typemod.macro.defaultLibrary"]      = "@function.builtin",
    ["@lsp.typemod.method.defaultLibrary"]     = "@function.builtin",
    ["@lsp.typemod.operator.injected"]         = "@operator",
    ["@lsp.typemod.string.injected"]           = "@string",
    ["@lsp.typemod.struct.defaultLibrary"]     = "@type.builtin",
    ["@lsp.typemod.type.defaultLibrary"]       = "@type.builtin",
    ["@lsp.typemod.typeAlias.defaultLibrary"]  = "@type.builtin",
    ["@lsp.typemod.variable.callable"]         = "@function",
    -- VS Code tells declarations apart from uses; LSP tokens let us do the same
    ["@lsp.typemod.property.declaration"]      = { fg = s.field_decl, style = opts.styles.properties },
    ["@lsp.typemod.variable.defaultLibrary"]   = "@module.builtin", -- console, window, document: support.class
    ["@lsp.typemod.variable.global"]           = "@constant",
    ["@lsp.typemod.variable.injected"]         = "@variable",
    ["@lsp.typemod.variable.static"]           = "@constant",
  }

  -- Modifiers the language server knows and the parser doesn't. Each is an
  -- attribute-only style that stacks on the token's color.
  local st = opts.styles
  local function mod(groups, style)
    if next(style) then
      for _, group in ipairs(groups) do
        ret[group] = { style = style }
      end
    end
  end
  mod({ "@lsp.mod.mutable", "@lsp.typemod.variable.mutable.rust" }, st.mutable)
  if next(st.mutable) then
    -- Rust parameters keep their color: the mut style just stacks on it
    ret["@lsp.typemod.parameter.mutable.rust"] = { fg = s.param, style = st.mutable }
  end
  mod({ "@lsp.mod.readonly" }, st.readonly)
  mod({ "@lsp.mod.static" }, st.statics)
  mod({ "@lsp.mod.global", "@lsp.mod.globalScope" }, st.globals)

  -- `rainbow_variables`: one group per color (see winteriscoming.semantic)
  for i, color in ipairs(c.variables or {}) do
    ret["WinteriscomingVariable" .. i] = { fg = color }
  end
  return ret
end

return M

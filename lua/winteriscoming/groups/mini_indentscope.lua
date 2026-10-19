local M = {}

M.url = "https://github.com/echasnovski/mini.indentscope"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MiniIndentscopeSymbol = { fg = c.indent_scope, nocombine = true },
    MiniIndentscopePrefix = { nocombine = true }, -- invisible
  }
  return ret
end

return M

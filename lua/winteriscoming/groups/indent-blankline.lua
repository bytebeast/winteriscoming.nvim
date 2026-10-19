local M = {}

M.url = "https://github.com/lukas-reineke/indent-blankline.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    IblIndent                  = { fg = c.fg_gutter, nocombine = true },
    IblWhitespace              = { fg = c.fg_gutter, nocombine = true },
    IblScope                   = { fg = c.indent_scope, nocombine = true },
    IndentBlanklineChar        = { fg = c.fg_gutter, nocombine = true },
    IndentBlanklineContextChar = { fg = c.indent_scope, nocombine = true },
  }
  return ret
end

return M

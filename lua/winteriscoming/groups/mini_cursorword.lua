local M = {}

M.url = "https://github.com/echasnovski/mini.cursorword"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MiniCursorword        = { bg = c.bg_visual },
    MiniCursorwordCurrent = { bg = c.bg_visual },
  }
  return ret
end

return M

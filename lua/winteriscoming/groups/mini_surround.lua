local M = {}

M.url = "https://github.com/echasnovski/mini.surround"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MiniSurround = { fg = c.on_accent, bg = c.bg_cursearch },
  }
  return ret
end

return M

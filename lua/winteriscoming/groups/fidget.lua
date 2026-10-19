local M = {}

M.url = "https://github.com/j-hui/fidget.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    FidgetTitle = { fg = c.blue },
    FidgetTask  = { fg = c.fg_muted },
  }
  return ret
end

return M

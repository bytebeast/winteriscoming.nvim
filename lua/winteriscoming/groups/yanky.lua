local M = {}

M.url = "https://github.com/gbprod/yanky.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    YankyPut    = "Search",
    YankyYanked = "IncSearch",
  }
  return ret
end

return M

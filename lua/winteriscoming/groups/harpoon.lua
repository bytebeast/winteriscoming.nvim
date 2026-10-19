local M = {}

M.url = "https://github.com/ThePrimeagen/harpoon"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    HarpoonWindow = "NormalFloat",
    HarpoonBorder = "FloatBorder",
    HarpoonTitle  = "FloatTitle",
  }
  return ret
end

return M

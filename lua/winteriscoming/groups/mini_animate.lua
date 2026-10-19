local M = {}

M.url = "https://github.com/echasnovski/mini.animate"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MiniAnimateCursor      = { reverse = true, nocombine = true },
    MiniAnimateNormalFloat = "NormalFloat",
  }
  return ret
end

return M

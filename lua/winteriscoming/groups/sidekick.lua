local M = {}

M.url = "https://github.com/folke/sidekick.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    SidekickDiffContext = "DiffChange",
    SidekickDiffAdd     = "DiffAdd",
    SidekickDiffDelete  = "DiffDelete",
    SidekickSignAdd     = { fg = c.git.add },
    SidekickSignChange  = { fg = c.git.change },
    SidekickSignDelete  = { fg = c.git.delete },
  }
  return ret
end

return M

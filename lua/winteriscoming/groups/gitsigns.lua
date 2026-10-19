local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/lewis6991/gitsigns.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    GitSignsAdd              = { fg = c.git.add },
    GitSignsChange           = { fg = c.git.change },
    GitSignsDelete           = { fg = c.git.delete },
    GitSignsUntracked        = { fg = c.git.untracked },
    GitSignsAddInline        = { bg = Util.blend_bg(c.git.add, 0.35) },
    GitSignsChangeInline     = { bg = Util.blend_bg(c.git.change, 0.35) },
    GitSignsDeleteInline     = { bg = Util.blend_bg(c.git.delete, 0.35) },
    GitSignsCurrentLineBlame = { fg = c.dark5 },
  }
  return ret
end

return M

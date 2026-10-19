local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/kevinhwang91/nvim-ufo"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    UfoFoldedEllipsis = { fg = c.fg_muted },
    UfoFoldedFg       = { fg = c.fg_light },
    UfoFoldedBg       = { bg = Util.blend_bg(c.blue, 0.12) },
  }
  return ret
end

return M

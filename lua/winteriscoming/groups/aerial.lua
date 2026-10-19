local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/stevearc/aerial.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    AerialNormal = { fg = c.fg, bg = c.none },
    AerialGuide  = { fg = c.fg_gutter },
    AerialLine   = { bg = Util.blend_bg(c.blue, 0.2) },
  }
  require("winteriscoming.groups.kinds").kinds(ret, "Aerial%sIcon")
  return ret
end

return M

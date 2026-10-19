local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/mfussenegger/nvim-dap"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    DapStoppedLine = { bg = Util.blend_bg(c.warning, 0.12) },
    DapBreakpoint  = { fg = c.red },
    DapStopped     = { fg = c.cream },
    DapLogPoint    = { fg = c.sky },
  }
  return ret
end

return M

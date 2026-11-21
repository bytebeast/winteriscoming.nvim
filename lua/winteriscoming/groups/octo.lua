local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/pwntester/octo.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local function pill(color)
    return { fg = color, bg = Util.blend_bg(color, 0.14), bold = true }
  end
  -- stylua: ignore
  local ret = {
    OctoDetailsLabel          = { fg = c.accent, bold = true },
    OctoDetailsValue          = { fg = c.fg_dark },
    OctoDirty                 = { fg = c.cream, bold = true },
    OctoIssueTitle            = { fg = c.purple, bold = true },
    OctoStateOpen             = pill(c.ok),
    OctoStateClosed           = pill(c.error),
    OctoStateMerged           = pill(c.purple),
    OctoStatePending          = pill(c.warning),
    OctoStateChangesRequested = pill(c.ember),
    OctoStatusColumn          = { fg = c.accent },
  }
  return ret
end

return M

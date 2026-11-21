local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/milanglacier/minuet-ai.nvim"

-- AI suggestions look like every other ghost text (copilot, completion
-- preview); minuet's "duet" edit previews use the diff colors.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MinuetVirtualText      = { fg = c.dark5, italic = true },
    MinuetDuetAdd          = { bg = c.diff.add },
    MinuetDuetDelete       = { fg = Util.blend_bg(c.git.delete, 0.6), bg = c.diff.delete, strikethrough = true },
    MinuetDuetComment      = { fg = c.dark5, italic = true },
    MinuetDuetCursor       = "Cursor",
    CmpItemKindMinuet      = { fg = c.teal },
    BlinkCmpItemKindMinuet = { fg = c.teal },
    BlinkCmpKindMinuet     = { fg = c.teal },
    LspKindMinuet          = { fg = c.teal },
  }
  return ret
end

return M

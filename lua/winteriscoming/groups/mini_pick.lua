local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/echasnovski/mini.pick"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MiniPickBorder        = "FloatBorder",
    MiniPickBorderBusy    = { fg = c.warning, bg = c.bg_float },
    MiniPickBorderText    = { fg = c.prompt, bg = c.bg_float },
    MiniPickIconDirectory = "Directory",
    MiniPickIconFile      = "MiniPickNormal",
    MiniPickHeader        = { fg = c.blue, bg = c.bg_float },
    MiniPickMatchCurrent  = { bg = Util.blend_bg(c.blue, c.is_light and 0.15 or 0.22) },
    MiniPickMatchMarked   = { bg = c.bg_visual },
    MiniPickMatchRanges   = { fg = c.ice, bold = true },
    MiniPickNormal        = "NormalFloat",
    MiniPickPreviewLine   = "CursorLine",
    MiniPickPreviewRegion = "IncSearch",
    MiniPickPrompt        = { fg = c.ice, bg = c.bg_float },
  }
  return ret
end

return M

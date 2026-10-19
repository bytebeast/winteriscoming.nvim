local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/echasnovski/mini.tabline"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MiniTablineCurrent         = { fg = c.fg_light, bg = c.bg_widget, bold = true },
    MiniTablineVisible         = { fg = c.fg_dark, bg = c.bg_dark },
    MiniTablineHidden          = { fg = c.fg_muted, bg = c.bg_dark },
    MiniTablineModifiedCurrent = { fg = c.cream, bg = c.bg_widget, bold = true },
    MiniTablineModifiedVisible = { fg = c.cream, bg = c.bg_dark },
    MiniTablineModifiedHidden  = { fg = Util.blend_bg(c.cream, 0.7), bg = c.bg_dark },
    MiniTablineFill            = { bg = opts.transparent and c.none or c.bg_darker },
    MiniTablineTabpagesection  = { fg = c.on_accent, bg = c.blue, bold = true },
  }
  return ret
end

return M

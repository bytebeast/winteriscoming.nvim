local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/rcarriga/nvim-notify"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local bg = opts.transparent and c.none or c.bg
  -- stylua: ignore
  local ret = {
    NotifyBackground  = { fg = c.fg, bg = c.bg },
    NotifyDEBUGBody   = { fg = c.fg, bg = bg },
    NotifyDEBUGBorder = { fg = Util.blend_bg(c.fg_muted, 0.5), bg = bg },
    NotifyDEBUGIcon   = { fg = c.fg_muted },
    NotifyDEBUGTitle  = { fg = c.fg_muted },
    NotifyERRORBody   = { fg = c.fg, bg = bg },
    NotifyERRORBorder = { fg = Util.blend_bg(c.error, 0.5), bg = bg },
    NotifyERRORIcon   = { fg = c.error },
    NotifyERRORTitle  = { fg = c.error },
    NotifyINFOBody    = { fg = c.fg, bg = bg },
    NotifyINFOBorder  = { fg = Util.blend_bg(c.info, 0.5), bg = bg },
    NotifyINFOIcon    = { fg = c.info },
    NotifyINFOTitle   = { fg = c.info },
    NotifyTRACEBody   = { fg = c.fg, bg = bg },
    NotifyTRACEBorder = { fg = Util.blend_bg(c.purple, 0.5), bg = bg },
    NotifyTRACEIcon   = { fg = c.purple },
    NotifyTRACETitle  = { fg = c.purple },
    NotifyWARNBody    = { fg = c.fg, bg = bg },
    NotifyWARNBorder  = { fg = Util.blend_bg(c.warning, 0.5), bg = bg },
    NotifyWARNIcon    = { fg = c.warning },
    NotifyWARNTitle   = { fg = c.warning },
  }
  return ret
end

return M

local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/romgrk/barbar.nvim"

-- Same tab bar as bufferline: darkest strip, inactive tabs on bg_dark, the
-- current one on the lighter widget shade.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local fill = opts.transparent and c.none or c.bg_darker
  local ret = {}
  local states = {
    Current = { fg = c.fg_light, bg = c.bg_widget },
    Visible = { fg = c.fg_dark, bg = c.bg_dark },
    Inactive = { fg = c.fg_muted, bg = c.bg_dark },
    Alternate = { fg = c.fg_light, bg = c.bg_highlight },
  }
  for state, base in pairs(states) do
    ret["Buffer" .. state] = base
    ret["Buffer" .. state .. "Index"] = { fg = c.accent, bg = base.bg }
    ret["Buffer" .. state .. "Mod"] = { fg = c.cream, bg = base.bg }
    ret["Buffer" .. state .. "Sign"] = { fg = state == "Current" and c.accent or c.border, bg = base.bg }
    ret["Buffer" .. state .. "SignRight"] = ret["Buffer" .. state .. "Sign"]
    ret["Buffer" .. state .. "Number"] = { fg = c.accent, bg = base.bg }
    ret["Buffer" .. state .. "Icon"] = { fg = base.fg, bg = base.bg }
    ret["Buffer" .. state .. "Btn"] = { fg = state == "Current" and c.fg_dark or c.fg_muted, bg = base.bg }
    ret["Buffer" .. state .. "ModBtn"] = { fg = c.cream, bg = base.bg }
    ret["Buffer" .. state .. "Pin"] = { fg = c.pink, bg = base.bg }
    ret["Buffer" .. state .. "PinBtn"] = { fg = c.pink, bg = base.bg }
    ret["Buffer" .. state .. "Target"] = { fg = c.on_accent, bg = c.label, bold = true }
    ret["Buffer" .. state .. "ERROR"] = { fg = c.error, bg = base.bg }
    ret["Buffer" .. state .. "WARN"] = { fg = c.warning, bg = base.bg }
    ret["Buffer" .. state .. "INFO"] = { fg = c.info, bg = base.bg }
    ret["Buffer" .. state .. "HINT"] = { fg = c.hint, bg = base.bg }
    ret["Buffer" .. state .. "ADDED"] = { fg = c.git.add, bg = base.bg }
    ret["Buffer" .. state .. "CHANGED"] = { fg = c.git.change, bg = base.bg }
    ret["Buffer" .. state .. "DELETED"] = { fg = c.git.delete, bg = base.bg }
  end
  ret.BufferTabpageFill = { fg = c.fg_muted, bg = fill }
  ret.BufferTabpages = { fg = c.accent, bg = fill, bold = true }
  ret.BufferTabpagesSep = { fg = c.fg_muted, bg = fill }
  ret.BufferScrollArrow = { fg = c.accent, bg = fill, bold = true }
  ret.BufferOffset = { fg = c.fg_dark, bg = Util.blend(c.bg_dark, 0.5, c.bg_darker) }
  return ret
end

return M

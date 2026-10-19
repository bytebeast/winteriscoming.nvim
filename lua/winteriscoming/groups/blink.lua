local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/saghen/blink.cmp"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    BlinkCmpMenu                = { fg = c.fg_light, bg = c.bg_popup },
    BlinkCmpMenuBorder          = { fg = c.border_highlight, bg = c.bg_popup },
    BlinkCmpMenuSelection       = { bg = Util.blend_bg(c.blue, c.is_light and 0.2 or 0.3), bold = true },
    BlinkCmpScrollBarThumb      = { bg = Util.blend_bg(c.blue, 0.45) },
    BlinkCmpScrollBarGutter     = { bg = c.bg_widget },
    BlinkCmpLabel               = { fg = c.fg_light },
    BlinkCmpLabelDeprecated     = { fg = c.fg_muted, strikethrough = true },
    BlinkCmpLabelMatch          = { fg = c.ice, bold = true },
    BlinkCmpLabelDetail         = { fg = c.fg_muted },
    BlinkCmpLabelDescription    = { fg = c.fg_muted },
    BlinkCmpSource              = { fg = c.fg_muted },
    BlinkCmpGhostText           = { fg = c.dark5 },
    BlinkCmpDoc                 = { fg = c.fg, bg = c.bg_float },
    BlinkCmpDocBorder           = { fg = c.border_highlight, bg = c.bg_float },
    BlinkCmpDocSeparator        = { fg = c.border, bg = c.bg_float },
    BlinkCmpSignatureHelp       = { fg = c.fg, bg = c.bg_float },
    BlinkCmpSignatureHelpBorder = { fg = c.border_highlight, bg = c.bg_float },
    BlinkCmpSignatureHelpActiveParameter = "LspSignatureActiveParameter",
    BlinkCmpKindDefault         = { fg = c.fg_dark },
    BlinkCmpKindCopilot         = { fg = c.teal },
    BlinkCmpKindCodeium         = { fg = c.teal },
    BlinkCmpKindSupermaven      = { fg = c.teal },
    BlinkCmpKindTabNine         = { fg = c.teal },
  }
  require("winteriscoming.groups.kinds").kinds(ret, "BlinkCmpKind%s")
  return ret
end

return M

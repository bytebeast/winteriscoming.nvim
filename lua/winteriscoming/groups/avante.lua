local M = {}

M.url = "https://github.com/yetone/avante.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    AvanteTitle             = { fg = c.on_accent, bg = c.blue, bold = true },
    AvanteReversedTitle     = { fg = c.blue },
    AvanteSubtitle          = { fg = c.on_accent, bg = c.ice },
    AvanteReversedSubtitle  = { fg = c.ice },
    AvanteThirdTitle        = { fg = c.fg_light, bg = c.bg_widget },
    AvanteReversedThirdTitle= { fg = c.bg_widget },
    AvanteConflictCurrent   = { bg = c.diff.delete },
    AvanteConflictIncoming  = { bg = c.diff.add },
    AvantePopupHint         = { fg = c.fg_muted },
    AvanteInlineHint        = { fg = c.dark5 },
  }
  return ret
end

return M

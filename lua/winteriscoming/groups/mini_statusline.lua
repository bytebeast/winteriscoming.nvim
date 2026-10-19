local M = {}

M.url = "https://github.com/echasnovski/mini.statusline"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MiniStatuslineDevinfo     = { fg = c.fg_light, bg = c.bg_widget },
    MiniStatuslineFileinfo    = { fg = c.fg_light, bg = c.bg_widget },
    MiniStatuslineFilename    = { fg = c.fg_dark, bg = c.bg_statusline },
    MiniStatuslineInactive    = { fg = c.fg_muted, bg = c.bg_statusline },
    MiniStatuslineModeNormal  = { fg = c.on_accent, bg = c.blue, bold = true },
    MiniStatuslineModeInsert  = { fg = c.on_accent, bg = c.green, bold = true },
    MiniStatuslineModeVisual  = { fg = c.on_accent, bg = c.lavender, bold = true },
    MiniStatuslineModeReplace = { fg = c.on_accent, bg = c.red, bold = true },
    MiniStatuslineModeCommand = { fg = c.on_accent, bg = c.cream, bold = true },
    MiniStatuslineModeOther   = { fg = c.on_accent, bg = c.teal, bold = true },
  }
  return ret
end

return M

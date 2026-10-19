local M = {}

M.url = "https://github.com/folke/flash.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    FlashBackdrop = { fg = c.fg_muted },
    FlashMatch    = { fg = c.fg_bright, bg = c.bg_search },
    FlashCurrent  = { fg = c.on_accent, bg = c.bg_cursearch },
    FlashLabel    = { fg = c.on_accent, bg = c.label, bold = true },
    FlashPrompt   = { fg = c.fg_light, bg = c.bg_statusline },
  }
  return ret
end

return M

local M = {}

M.url = "https://github.com/folke/trouble.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    TroubleNormal   = { fg = c.fg, bg = c.bg_sidebar },
    TroubleNormalNC = { fg = c.fg, bg = c.bg_sidebar },
    TroubleText     = { fg = c.fg_light },
    TroubleCount    = { fg = c.purple, bg = c.bg_widget },
    TroublePos      = { fg = c.fg_muted },
    TroubleIndent   = { fg = c.fg_gutter },
  }
  return ret
end

return M

local M = {}

M.url = "https://github.com/folke/which-key.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    WhichKey          = { fg = c.ice },
    WhichKeyGroup     = { fg = c.sky },
    WhichKeyDesc      = { fg = c.fg_light },
    WhichKeySeparator = { fg = c.fg_muted },
    WhichKeyNormal    = { bg = c.bg_sidebar },
    WhichKeyBorder    = { fg = c.border_highlight, bg = c.bg_sidebar },
    WhichKeyTitle     = { fg = c.blue, bg = c.bg_sidebar, bold = true },
    WhichKeyValue     = { fg = c.fg_muted },
  }
  return ret
end

return M

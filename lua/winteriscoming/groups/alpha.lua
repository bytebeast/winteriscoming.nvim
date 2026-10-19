local M = {}

M.url = "https://github.com/goolord/alpha-nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    AlphaHeader     = { fg = c.ice },
    AlphaHeaderLabel= { fg = c.cream },
    AlphaButtons    = { fg = c.fg_light },
    AlphaShortcut   = { fg = c.cream },
    AlphaFooter     = { fg = c.jade, italic = true },
  }
  return ret
end

return M

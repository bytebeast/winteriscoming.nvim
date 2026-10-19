local M = {}

M.url = "https://github.com/echasnovski/mini.starter"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local bg = opts.transparent and c.none or c.bg
  -- stylua: ignore
  local ret = {
    MiniStarterCurrent    = { nocombine = true },
    MiniStarterHeader     = { fg = c.ice },
    MiniStarterFooter     = { fg = c.jade, italic = true },
    MiniStarterInactive   = { fg = c.comment, style = opts.styles.comments },
    MiniStarterItem       = { fg = c.fg_light, bg = bg },
    MiniStarterItemBullet = { fg = c.border_highlight },
    MiniStarterItemPrefix = { fg = c.cream },
    MiniStarterQuery      = { fg = c.ice },
    MiniStarterSection    = { fg = c.blue },
  }
  return ret
end

return M

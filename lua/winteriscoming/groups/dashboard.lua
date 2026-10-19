local M = {}

M.url = "https://github.com/nvimdev/dashboard-nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    DashboardHeader           = { fg = c.ice },
    DashboardFooter           = { fg = c.jade, italic = true },
    DashboardDesc             = { fg = c.fg_light },
    DashboardKey              = { fg = c.cream },
    DashboardIcon             = { fg = c.sky },
    DashboardShortCut         = { fg = c.sky },
    DashboardProjectTitle     = { fg = c.blue },
    DashboardProjectTitleIcon = { fg = c.cream },
    DashboardProjectIcon      = { fg = c.cream },
    DashboardMruTitle         = { fg = c.blue },
    DashboardMruIcon          = { fg = c.purple },
    DashboardFiles            = { fg = c.fg_light },
    DashboardShortCutIcon     = { fg = c.lavender },
  }
  return ret
end

return M

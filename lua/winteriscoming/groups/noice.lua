local M = {}

M.url = "https://github.com/folke/noice.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    NoiceCmdlineIcon               = { fg = c.ice },
    NoiceCmdlinePopupBorder        = { fg = c.border_highlight },
    NoiceCmdlinePopupTitle         = { fg = c.blue },
    NoiceCmdlineIconInput          = { fg = c.prompt },
    NoiceCmdlinePopupBorderInput   = { fg = c.prompt },
    NoiceCmdlinePopupTitleInput    = { fg = c.prompt },
    NoiceCmdlineIconLua            = { fg = c.sky },
    NoiceCmdlinePopupBorderLua     = { fg = c.sky },
    NoiceCmdlinePopupTitleLua      = { fg = c.sky },
    NoiceCmdlineIconSearch         = { fg = c.cream },
    NoiceCmdlinePopupBorderSearch  = { fg = c.cream },
    NoiceConfirmBorder             = { fg = c.border_highlight },
    NoiceLspProgressClient         = { fg = c.blue },
    NoiceLspProgressTitle          = { fg = c.fg_dark },
    NoiceLspProgressSpinner        = { fg = c.ice },
    NoiceMini                      = { fg = c.fg_dark, bg = c.bg_statusline },
    NoiceCompletionItemKindDefault = { fg = c.fg_dark, bg = c.none },
  }
  require("winteriscoming.groups.kinds").kinds(ret, "NoiceCompletionItemKind%s")
  return ret
end

return M

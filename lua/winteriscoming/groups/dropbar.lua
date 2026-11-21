local M = {}

M.url = "https://github.com/Bekaboo/dropbar.nvim"

-- Like nvim-navic: muted separators, kind icons from the LSP kinds.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local ret = {
    DropBarIconKindDefault = { fg = c.fg_dark },
    DropBarIconUISeparator = { fg = c.fg_muted },
    DropBarMenuHoverEntry = "PmenuSel",
  }
  require("winteriscoming.groups.kinds").kinds(ret, "DropBarIconKind%s")
  return ret
end

return M

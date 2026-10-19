local M = {}

M.url = "https://github.com/SmiteshP/nvim-navic"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    NavicSeparator = { fg = c.fg_muted, bg = c.none },
    NavicText      = { fg = c.fg_dark, bg = c.none },
  }
  require("winteriscoming.groups.kinds").kinds(ret, "NavicIcons%s")
  return ret
end

return M

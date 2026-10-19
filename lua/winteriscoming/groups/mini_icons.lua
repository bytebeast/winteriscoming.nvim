local M = {}

M.url = "https://github.com/echasnovski/mini.icons"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MiniIconsAzure  = { fg = c.blue },
    MiniIconsBlue   = { fg = c.azure },
    MiniIconsCyan   = { fg = c.teal },
    MiniIconsGreen  = { fg = c.green },
    MiniIconsGrey   = { fg = c.fg_light },
    MiniIconsOrange = { fg = c.ember },
    MiniIconsPurple = { fg = c.lavender },
    MiniIconsRed    = { fg = c.red },
    MiniIconsYellow = { fg = c.cream },
  }
  return ret
end

return M

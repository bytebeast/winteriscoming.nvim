local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/echasnovski/mini.files"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MiniFilesBorder         = "FloatBorder",
    MiniFilesBorderModified = { fg = c.warning, bg = c.bg_float },
    MiniFilesCursorLine     = { bg = Util.blend_bg(c.blue, c.is_light and 0.15 or 0.22) },
    MiniFilesDirectory      = "Directory",
    MiniFilesFile           = { fg = c.fg_float },
    MiniFilesNormal         = "NormalFloat",
    MiniFilesTitle          = { fg = c.fg_muted, bg = c.bg_float },
    MiniFilesTitleFocused   = { fg = c.blue, bg = c.bg_float, bold = true },
  }
  return ret
end

return M

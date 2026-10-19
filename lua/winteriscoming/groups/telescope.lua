local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/nvim-telescope/telescope.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    TelescopeNormal         = { fg = c.fg, bg = c.bg_float },
    TelescopeBorder         = { fg = c.border_highlight, bg = c.bg_float },
    TelescopeTitle          = { fg = c.blue, bg = c.bg_float, bold = true },
    TelescopePromptNormal   = { fg = c.fg_light, bg = c.bg_float },
    TelescopePromptBorder   = { fg = c.prompt, bg = c.bg_float },
    TelescopePromptTitle    = { fg = c.prompt, bg = c.bg_float },
    TelescopePromptPrefix   = { fg = c.ice, bg = c.bg_float },
    TelescopeSelection      = { bg = Util.blend_bg(c.blue, c.is_light and 0.15 or 0.22) },
    TelescopeSelectionCaret = { fg = c.ice },
    TelescopeMultiSelection = { fg = c.cream },
    TelescopeMatching       = { fg = c.ice, bold = true },
    TelescopeResultsComment = { fg = c.fg_muted },
  }
  return ret
end

return M

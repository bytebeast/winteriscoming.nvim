local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/nvim-neo-tree/neo-tree.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    NeoTreeNormal               = { fg = c.fg_sidebar, bg = c.bg_sidebar },
    NeoTreeNormalNC             = { fg = c.fg_sidebar, bg = c.bg_sidebar },
    NeoTreeWinSeparator         = { fg = c.border, bg = c.bg_sidebar },
    NeoTreeDimText              = { fg = c.fg_muted },
    NeoTreeFileName             = { fg = c.fg_sidebar },
    NeoTreeFileNameOpened       = { fg = c.fg_light, bold = true },
    NeoTreeDirectoryName        = { fg = c.fg_sidebar },
    NeoTreeDirectoryIcon        = { fg = c.sky },
    NeoTreeRootName             = { fg = c.blue, bold = true },
    NeoTreeIndentMarker         = { fg = c.fg_gutter },
    NeoTreeExpander             = { fg = c.fg_muted },
    NeoTreeCursorLine           = { bg = Util.blend_bg(c.blue, c.is_light and 0.15 or 0.2) },
    NeoTreeGitAdded             = { fg = c.git.add },
    NeoTreeGitModified          = { fg = c.git.change },
    NeoTreeGitDeleted           = { fg = c.git.delete },
    NeoTreeGitStaged            = { fg = c.jade },
    NeoTreeGitUntracked         = { fg = c.git.untracked },
    NeoTreeGitConflict          = { fg = c.red, bold = true },
    NeoTreeGitIgnored           = { fg = c.git.ignore },
    NeoTreeModified             = { fg = c.cream },
    NeoTreeFloatBorder          = { fg = c.border_highlight, bg = c.bg_float },
    NeoTreeFloatTitle           = { fg = c.blue, bg = c.bg_float },
    NeoTreeTitleBar             = { fg = c.on_accent, bg = c.blue },
    NeoTreeTabActive            = { fg = c.fg_light, bg = c.bg_widget, bold = true },
    NeoTreeTabInactive          = { fg = c.fg_muted, bg = c.bg_darker },
    NeoTreeTabSeparatorActive   = { fg = c.blue, bg = c.bg_widget },
    NeoTreeTabSeparatorInactive = { fg = c.bg_darker, bg = c.bg_darker },
  }
  return ret
end

return M

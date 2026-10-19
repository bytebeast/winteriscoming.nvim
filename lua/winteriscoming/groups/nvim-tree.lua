local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/nvim-tree/nvim-tree.lua"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    NvimTreeNormal           = { fg = c.fg_sidebar, bg = c.bg_sidebar },
    NvimTreeNormalNC         = { fg = c.fg_sidebar, bg = c.bg_sidebar },
    NvimTreeWinSeparator     = { fg = c.border, bg = c.bg_sidebar },
    NvimTreeRootFolder       = { fg = c.blue, bold = true },
    NvimTreeFolderIcon       = { fg = c.sky },
    NvimTreeFolderName       = { fg = c.fg_sidebar },
    NvimTreeOpenedFolderName = { fg = c.fg_light },
    NvimTreeOpenedFile       = { fg = c.fg_light, bold = true },
    NvimTreeIndentMarker     = { fg = c.fg_gutter },
    NvimTreeSpecialFile      = { fg = c.purple, underline = true },
    NvimTreeImageFile        = { fg = c.fg_sidebar },
    NvimTreeSymlink          = { fg = c.sky },
    NvimTreeGitDirty         = { fg = c.git.change },
    NvimTreeGitNew           = { fg = c.git.untracked },
    NvimTreeGitDeleted       = { fg = c.git.delete },
    NvimTreeGitStaged        = { fg = c.jade },
    NvimTreeGitIgnored       = { fg = c.git.ignore },
    NvimTreeCursorLine       = { bg = Util.blend_bg(c.blue, c.is_light and 0.15 or 0.2) },
  }
  return ret
end

return M

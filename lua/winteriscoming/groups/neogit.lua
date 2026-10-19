local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/NeogitOrg/neogit"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    NeogitBranch               = { fg = c.cream, bold = true },
    NeogitRemote               = { fg = c.green, bold = true },
    NeogitHunkHeader           = { fg = c.fg_dark, bg = c.bg_widget },
    NeogitHunkHeaderHighlight  = { fg = c.blue, bg = Util.blend_bg(c.blue, 0.2), bold = true },
    NeogitDiffContext          = { bg = c.bg },
    NeogitDiffContextHighlight = { bg = c.bg_highlight },
    NeogitDiffAdd              = { fg = c.git.add, bg = c.diff.add },
    NeogitDiffAddHighlight     = { fg = c.git.add, bg = c.diff.add },
    NeogitDiffDelete           = { fg = c.git.delete, bg = c.diff.delete },
    NeogitDiffDeleteHighlight  = { fg = c.git.delete, bg = c.diff.delete },
    NeogitDiffHeader           = { fg = c.blue, bold = true },
    NeogitDiffHeaderHighlight  = { fg = c.cream, bold = true },
    NeogitSectionHeader        = { fg = c.lavender, bold = true },
    NeogitChangeModified       = { fg = c.git.change, bold = true },
    NeogitChangeAdded          = { fg = c.git.add, bold = true },
    NeogitChangeDeleted        = { fg = c.git.delete, bold = true },
    NeogitChangeRenamed        = { fg = c.purple, bold = true },
    NeogitChangeNewFile        = { fg = c.git.untracked, bold = true },
    NeogitObjectId             = { fg = c.fg_muted },
    NeogitStash                = { fg = c.fg_muted },
    NeogitFilePath             = { fg = c.sky, italic = true },
    NeogitTagName              = { fg = c.cream },
    NeogitGraphAuthor          = { fg = c.teal },
  }
  return ret
end

return M

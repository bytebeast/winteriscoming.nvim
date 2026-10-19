local M = {}

M.url = "https://github.com/sindrets/diffview.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    DiffviewNormal              = { fg = c.fg_sidebar, bg = c.bg_sidebar },
    DiffviewWinSeparator        = { fg = c.border, bg = c.bg_sidebar },
    DiffviewFilePanelTitle      = { fg = c.blue, bold = true },
    DiffviewFilePanelCounter    = { fg = c.fg_light },
    DiffviewFilePanelRootPath   = { fg = c.lavender, bold = true },
    DiffviewFilePanelFileName   = { fg = c.fg_light },
    DiffviewFilePanelSelected   = { fg = c.cream },
    DiffviewFilePanelPath       = { fg = c.fg_muted },
    DiffviewFilePanelInsertions = { fg = c.git.add },
    DiffviewFilePanelDeletions  = { fg = c.git.delete },
    DiffviewFolderName          = { fg = c.sky, bold = true },
    DiffviewFolderSign          = { fg = c.sky },
    DiffviewHash                = { fg = c.jade },
    DiffviewStatusAdded         = { fg = c.git.add },
    DiffviewStatusUntracked     = { fg = c.git.untracked },
    DiffviewStatusModified      = { fg = c.git.change },
    DiffviewStatusRenamed       = { fg = c.purple },
    DiffviewStatusDeleted       = { fg = c.git.delete },
    DiffviewStatusIgnored       = { fg = c.git.ignore },
    DiffviewDiffDeleteDim       = { fg = c.dark3 },
  }
  return ret
end

return M

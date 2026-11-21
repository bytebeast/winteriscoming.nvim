local M = {}

M.url = "https://github.com/esmuellert/codediff.nvim"

-- codediff derives its line and character diff colors from DiffAdd/DiffDelete
-- on every :colorscheme; these are the groups it leaves to the colorscheme.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local g = c.git
  -- stylua: ignore
  local ret = {
    CodeDiffGutterInsert           = { fg = g.add, bg = c.diff.add },
    CodeDiffGutterDelete           = { fg = g.delete, bg = c.diff.delete },
    CodeDiffGutterInsertNumber     = { fg = g.add },
    CodeDiffGutterDeleteNumber     = { fg = g.delete },
    CodeDiffMoveFrom               = { fg = c.purple },
    CodeDiffMoveTo                 = { fg = c.purple },
    CodeDiffFiller                 = { fg = c.dark3 },
    CodeDiffExplorerSelected       = "PmenuSel",
    CodeDiffExplorerTreeGroup      = { fg = c.sky },
    CodeDiffStatusAdded            = { fg = g.add },
    CodeDiffStatusModified         = { fg = g.change },
    CodeDiffStatusDeleted          = { fg = g.delete },
    CodeDiffStatusRenamed          = { fg = g.change },
    CodeDiffStatusUntracked        = { fg = g.untracked },
    CodeDiffStatusConflict         = { fg = g.conflict },
    CodeDiffExplorerStatFiles      = { fg = c.cream },
    CodeDiffExplorerStatInsertions = { fg = g.add },
    CodeDiffExplorerStatDeletions  = { fg = g.delete },
    CodeDiffExplorerStatBinary     = { fg = c.fg_muted },
    CodeDiffConflictSign           = { fg = g.conflict },
    CodeDiffConflictSignResolved   = { fg = c.fg_muted },
    CodeDiffConflictSignAccepted   = { fg = g.add },
    CodeDiffConflictSignRejected   = { fg = g.delete },
    CodeDiffHistoryTitle           = { fg = c.accent, bold = true },
    CodeDiffHelpHeader             = { fg = c.accent, bold = true },
    CodeDiffHelpSection            = { fg = c.purple, bold = true },
    CodeDiffHelpKey                = { fg = c.cream },
    CodeDiffHelpSep                = { fg = c.fg_muted },
    CodeDiffHelpDesc               = { fg = c.fg },
    CodeDiffWelcomeLogo            = { fg = c.accent },
    CodeDiffWelcomeKey             = { fg = c.cream },
    ExplorerDirectorySmall         = { fg = c.fg_muted },
  }
  return ret
end

return M

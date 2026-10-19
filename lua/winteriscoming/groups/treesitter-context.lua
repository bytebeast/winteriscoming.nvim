local M = {}

M.url = "https://github.com/nvim-treesitter/nvim-treesitter-context"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    -- a pinned header: one step darker than the editor, with a thin rule
    -- below, so several context lines don't read as a selection
    TreesitterContext           = { bg = c.bg_dark },
    TreesitterContextLineNumber = { fg = c.line_nr, bg = c.bg_dark },
    TreesitterContextBottom     = { underline = true, sp = c.border_highlight },
    TreesitterContextLineNumberBottom = { fg = c.line_nr, underline = true, sp = c.border_highlight },
  }
  return ret
end

return M

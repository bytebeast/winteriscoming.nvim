local M = {}

M.url = "https://github.com/nvim-neotest/neotest"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    NeotestAdapterName  = { fg = c.purple, bold = true },
    NeotestBorder       = { fg = c.border_highlight },
    NeotestDir          = { fg = c.sky },
    NeotestExpandMarker = { fg = c.fg_muted },
    NeotestFailed       = { fg = c.red },
    NeotestFile         = { fg = c.teal },
    NeotestFocused      = { fg = c.cream, bold = true },
    NeotestIndent       = { fg = c.fg_gutter },
    NeotestMarked       = { fg = c.ice },
    NeotestNamespace    = { fg = c.lavender },
    NeotestPassed       = { fg = c.green },
    NeotestRunning      = { fg = c.cream },
    NeotestSkipped      = { fg = c.fg_muted },
    NeotestTarget       = { fg = c.ice },
    NeotestTest         = { fg = c.fg_sidebar },
    NeotestWinSelect    = { fg = c.ice },
  }
  return ret
end

return M

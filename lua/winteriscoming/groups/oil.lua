local M = {}

M.url = "https://github.com/stevearc/oil.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    OilDir       = "Directory",
    OilDirIcon   = "Directory",
    OilLink      = { fg = c.teal },
    OilLinkTarget= { fg = c.fg_muted },
    OilCreate    = { fg = c.git.add, bold = true },
    OilDelete    = { fg = c.git.delete, bold = true },
    OilMove      = { fg = c.cream, bold = true },
    OilCopy      = { fg = c.sky, bold = true },
    OilChange    = { fg = c.git.change, bold = true },
  }
  return ret
end

return M

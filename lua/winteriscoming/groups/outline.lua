local M = {}

M.url = "https://github.com/hedyhli/outline.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    OutlineCurrent    = { fg = c.cream, bold = true },
    OutlineGuides     = { fg = c.fg_gutter },
    OutlineFoldMarker = { fg = c.fg_muted },
    OutlineDetails    = { fg = c.fg_muted },
    OutlineLineno     = { fg = c.line_nr },
  }
  return ret
end

return M

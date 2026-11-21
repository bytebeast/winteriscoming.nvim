local M = {}

M.url = "https://github.com/lewis6991/hover.nvim"

-- The hover float matches every other float; the source tabs along its top
-- look like the tabline.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    HoverWindow         = { fg = c.fg_float, bg = c.bg_float },
    HoverBorder         = { fg = c.border_highlight, bg = c.bg_float },
    HoverSourceLine     = { fg = c.fg_muted, bg = c.bg_dark },
    HoverActiveSource   = { fg = c.on_accent, bg = c.accent, bold = true },
    HoverInactiveSource = { fg = c.fg_muted, bg = c.bg_dark },
    HoverFloatingError  = "DiagnosticFloatingError",
    HoverFloatingWarn   = "DiagnosticFloatingWarn",
    HoverFloatingInfo   = "DiagnosticFloatingInfo",
    HoverFloatingHint   = "DiagnosticFloatingHint",
  }
  return ret
end

return M

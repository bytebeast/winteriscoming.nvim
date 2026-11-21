local M = {}

M.url = "https://github.com/smoka7/hop.nvim"

-- Jump labels match flash and leap.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    HopNextKey   = { fg = c.on_accent, bg = c.label, bold = true },
    HopNextKey1  = { fg = c.label, bold = true },
    HopNextKey2  = { fg = c.sky },
    HopUnmatched = { fg = c.fg_muted },
  }
  return ret
end

return M

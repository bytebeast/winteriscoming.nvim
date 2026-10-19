local M = {}

M.url = "https://github.com/ggandor/leap.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    LeapMatch    = { fg = c.cream, bold = true, nocombine = true },
    LeapLabel    = { fg = c.on_accent, bg = c.label, bold = true, nocombine = true },
    LeapBackdrop = { fg = c.fg_muted },
  }
  return ret
end

return M

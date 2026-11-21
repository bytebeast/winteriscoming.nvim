local M = {}

M.url = "https://github.com/petertriho/nvim-scrollbar"

-- nvim-scrollbar rewrites these itself unless `set_highlights = false` (its
-- default derives them from the diagnostic and git groups, which also looks
-- right); with it off, these exact colors are used.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local ret = {
    ScrollbarHandle = { bg = c.bg_widget },
    ScrollbarCursor = { fg = c.fg_dark },
    ScrollbarCursorHandle = { fg = c.fg_dark, bg = c.bg_widget },
  }
  for name, color in pairs({
    Error = c.error,
    Warn = c.warning,
    Info = c.info,
    Hint = c.hint,
    Search = c.cream,
    Misc = c.purple,
    GitAdd = c.git.add,
    GitChange = c.git.change,
    GitDelete = c.git.delete,
  }) do
    ret["Scrollbar" .. name] = { fg = color }
    ret["Scrollbar" .. name .. "Handle"] = { fg = color, bg = c.bg_widget }
  end
  return ret
end

return M

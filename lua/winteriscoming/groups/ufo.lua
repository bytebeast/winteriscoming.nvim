local M = {}

M.url = "https://github.com/kevinhwang91/nvim-ufo"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    UfoFoldedEllipsis = { fg = c.fg_muted },
    UfoFoldedFg       = { fg = c.fg_light },
    UfoFoldedBg       = { bg = c.bg_fold },
  }
  return ret
end

return M

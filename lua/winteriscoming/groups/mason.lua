local M = {}

M.url = "https://github.com/mason-org/mason.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MasonNormal                      = { fg = c.fg, bg = c.bg_float },
    MasonHeader                      = { fg = c.on_accent, bg = c.blue, bold = true },
    MasonHeaderSecondary             = { fg = c.on_accent, bg = c.ice, bold = true },
    MasonHeading                     = { fg = c.blue, bold = true },
    MasonHighlight                   = { fg = c.ice },
    MasonHighlightBlock              = { fg = c.on_accent, bg = c.ice },
    MasonHighlightBlockBold          = { fg = c.on_accent, bg = c.blue, bold = true },
    MasonHighlightSecondary          = { fg = c.cream },
    MasonHighlightBlockSecondary     = { fg = c.on_accent, bg = c.cream },
    MasonHighlightBlockBoldSecondary = { fg = c.on_accent, bg = c.cream, bold = true },
    MasonLink                        = { fg = c.sky, underline = true },
    MasonMuted                       = { fg = c.fg_muted },
    MasonMutedBlock                  = { fg = c.fg_light, bg = c.bg_widget },
    MasonMutedBlockBold              = { fg = c.fg_light, bg = c.bg_widget, bold = true },
    MasonError                       = { fg = c.error },
    MasonWarning                     = { fg = c.warning },
  }
  return ret
end

return M

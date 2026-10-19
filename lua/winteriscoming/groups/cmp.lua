local M = {}

M.url = "https://github.com/hrsh7th/nvim-cmp"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    CmpDocumentation       = { fg = c.fg, bg = c.bg_float },
    CmpDocumentationBorder = { fg = c.border_highlight, bg = c.bg_float },
    CmpGhostText           = { fg = c.dark5 },
    CmpItemAbbr            = { fg = c.fg_light, bg = c.none },
    CmpItemAbbrDeprecated  = { fg = c.fg_muted, bg = c.none, strikethrough = true },
    CmpItemAbbrMatch       = { fg = c.ice, bg = c.none, bold = true },
    CmpItemAbbrMatchFuzzy  = { fg = c.ice, bg = c.none },
    CmpItemMenu            = { fg = c.fg_muted, bg = c.none },
    CmpItemKindDefault     = { fg = c.fg_dark, bg = c.none },
    CmpItemKindCopilot     = { fg = c.teal, bg = c.none },
    CmpItemKindCodeium     = { fg = c.teal, bg = c.none },
    CmpItemKindSupermaven  = { fg = c.teal, bg = c.none },
    CmpItemKindTabNine     = { fg = c.teal, bg = c.none },
  }
  require("winteriscoming.groups.kinds").kinds(ret, "CmpItemKind%s")
  return ret
end

return M

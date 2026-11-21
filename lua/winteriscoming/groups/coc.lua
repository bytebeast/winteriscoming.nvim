local M = {}

M.url = "https://github.com/neoclide/coc.nvim"

-- coc hardcodes gruvbox-like hex for these (its ghost text, #504945, is near
-- invisible on navy). Diagnostics, semantic tokens and symbols already link
-- to groups this theme sets.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    CocVirtualText          = { fg = c.dark5 },
    CocInlineVirtualText    = { fg = c.dark5, italic = true },
    CocCodeLens             = "LspCodeLens",
    CocInlayHint            = "LspInlayHint",
    CocSearch               = { fg = c.ice, bold = true },
    CocSelectedText         = { fg = c.red },
    CocDisabled             = { fg = c.fg_muted },
    CocUnderline            = { underline = true },
    CocMarkdownLink         = "@markup.link.url",
    CocLink                 = { underline = true, sp = c.sky },
    CocNotificationProgress = { fg = c.accent },
    CocNextEditInsert       = { fg = c.git.add, bg = c.diff.add },
    CocNextEditDelete       = { fg = c.git.delete, bg = c.diff.delete },
    CocHighlightText        = "LspReferenceText",
    CocHighlightRead        = "LspReferenceRead",
    CocHighlightWrite       = "LspReferenceWrite",
    CocUnusedHighlight      = "DiagnosticUnnecessary",
    CocDeprecatedHighlight  = "DiagnosticDeprecated",
    -- coc derives these from Normal by shifting lightness when it thinks
    -- floats look too much like the editor
    CocFloating             = "NormalFloat",
    CocPumMenu              = "Pmenu",
    CocMenuSel              = "PmenuSel",
    CocFloatThumb           = "PmenuThumb",
    CocFloatSbar            = "PmenuSbar",
    CocListLine             = "CursorLine",
  }
  return ret
end

return M

local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/OXY2DEV/markview.nvim"

-- Same look as render-markdown. markview derives headings and code icons
-- from `MarkviewPalette<n>` and only creates groups that don't exist yet, so
-- these win. Its callouts and checkboxes reuse heading slots for meaning
-- (1 = error, 4 = ok); here they get the diagnostic colors instead.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MarkviewCode              = { bg = c.bg_dark },
    MarkviewCodeInfo          = { fg = c.fg_muted, bg = c.bg_dark },
    MarkviewInlineCode        = "@markup.raw.markdown_inline",
    MarkviewTableBorder       = { fg = c.fg_muted },

    MarkviewBlockQuoteDefault = { fg = c.syntax.md_quote },
    MarkviewBlockQuoteNote    = { fg = c.info },
    MarkviewBlockQuoteOk      = { fg = c.ok },
    MarkviewBlockQuoteWarn    = { fg = c.warning },
    MarkviewBlockQuoteError   = { fg = c.error },
    MarkviewBlockQuoteSpecial = { fg = c.purple },

    MarkviewCheckboxChecked   = { fg = c.ok },
    MarkviewCheckboxUnchecked = { fg = c.fg_muted },
    MarkviewCheckboxPending   = { fg = c.warning },
    MarkviewCheckboxProgress  = { fg = c.info },
    MarkviewCheckboxCancelled = { fg = c.fg_muted },
    MarkviewCheckboxStriked   = { fg = c.fg_muted, strikethrough = true },
  }
  local function palette(n, color, bg)
    ret["MarkviewPalette" .. n] = { fg = color, bg = bg }
    ret["MarkviewPalette" .. n .. "Fg"] = { fg = color }
    ret["MarkviewPalette" .. n .. "Bg"] = { bg = bg }
    ret["MarkviewPalette" .. n .. "Sign"] = { fg = color }
  end
  palette(0, c.fg_muted, c.bg_highlight)
  for i = 1, 6 do
    palette(i, c.rainbow[i], Util.blend_bg(c.rainbow[i], 0.12))
  end
  return ret
end

return M

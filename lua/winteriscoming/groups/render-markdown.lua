local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/MeanderingProgrammer/render-markdown.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    RenderMarkdownCode       = { bg = c.bg_dark },
    RenderMarkdownCodeInline = "@markup.raw.markdown_inline",
    RenderMarkdownBullet     = { fg = c.syntax.md_list },
    RenderMarkdownDash       = { fg = c.fg_muted },
    RenderMarkdownQuote      = { fg = c.syntax.md_quote },
    RenderMarkdownTableHead  = { fg = c.blue, bold = true },
    RenderMarkdownTableRow   = { fg = c.fg_muted },
    RenderMarkdownLink       = { fg = c.syntax.md_link },
    RenderMarkdownChecked    = { fg = c.ok },
    RenderMarkdownUnchecked  = { fg = c.fg_muted },
    RenderMarkdownTodo       = { fg = c.cream },
    RenderMarkdownSuccess    = { fg = c.ok },
    RenderMarkdownInfo       = { fg = c.info },
    RenderMarkdownHint       = { fg = c.hint },
    RenderMarkdownWarn       = { fg = c.warning },
    RenderMarkdownError      = { fg = c.error },
  }
  for i, color in ipairs(c.rainbow) do
    ret["RenderMarkdownH" .. i .. "Bg"] = { bg = Util.blend_bg(color, 0.12) }
    ret["RenderMarkdownH" .. i .. "Fg"] = { fg = color, bold = true }
  end
  return ret
end

return M

local Util = require("winteriscoming.util")

local M = {}

M.url = "https://github.com/lukas-reineke/headlines.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    CodeBlock = { bg = c.bg_dark },
    Headline  = "Headline1",
    Dash      = { fg = c.fg_muted, bold = true },
    Quote     = { fg = c.syntax.md_quote },
  }
  for i, color in ipairs(c.rainbow) do
    ret["Headline" .. i] = { bg = Util.blend_bg(color, 0.08) }
  end
  return ret
end

return M

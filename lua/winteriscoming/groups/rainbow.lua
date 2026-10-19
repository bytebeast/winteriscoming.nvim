local M = {}

M.url = "https://github.com/HiPhish/rainbow-delimiters.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    RainbowDelimiterRed    = { fg = c.red_light },
    RainbowDelimiterOrange = { fg = c.ember },
    RainbowDelimiterYellow = { fg = c.cream },
    RainbowDelimiterGreen  = { fg = c.green },
    RainbowDelimiterBlue   = { fg = c.ice },
    RainbowDelimiterViolet = { fg = c.lavender },
    RainbowDelimiterCyan   = { fg = c.teal },
  }
  return ret
end

return M

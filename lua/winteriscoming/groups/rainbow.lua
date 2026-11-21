local M = {}

M.url = "https://github.com/HiPhish/rainbow-delimiters.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local b = c.brackets
  -- stylua: ignore
  local ret = {
    RainbowDelimiterRed    = { fg = b.red },
    RainbowDelimiterOrange = { fg = b.orange },
    RainbowDelimiterYellow = { fg = b.yellow },
    RainbowDelimiterGreen  = { fg = b.green },
    RainbowDelimiterBlue   = { fg = b.blue },
    RainbowDelimiterViolet = { fg = b.violet },
    RainbowDelimiterCyan   = { fg = b.cyan },
  }
  return ret
end

return M

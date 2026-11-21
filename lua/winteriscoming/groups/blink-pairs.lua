local M = {}

M.url = "https://github.com/saghen/blink.pairs"

-- Rainbow pairs share colors with rainbow-delimiters. blink.pairs uses three
-- groups by default; the other four are here for a longer `highlights.groups`.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local b = c.brackets
  -- stylua: ignore
  local ret = {
    BlinkPairs           = { fg = c.syntax.punctuation },
    BlinkPairsOrange     = { fg = b.orange },
    BlinkPairsPurple     = { fg = b.violet },
    BlinkPairsBlue       = { fg = b.blue },
    BlinkPairsRed        = { fg = b.red },
    BlinkPairsYellow     = { fg = b.yellow },
    BlinkPairsGreen      = { fg = b.green },
    BlinkPairsCyan       = { fg = b.cyan },
    BlinkPairsUnmatched  = { fg = c.error, undercurl = true, sp = c.error },
    BlinkPairsMatchParen = "MatchParen",
  }
  return ret
end

return M

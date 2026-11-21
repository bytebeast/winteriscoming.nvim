local M = {}

M.url = "https://github.com/airblade/vim-gitgutter"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local g = c.git
  -- stylua: ignore
  local ret = {
    GitGutterAdd          = { fg = g.add },
    GitGutterChange       = { fg = g.change },
    GitGutterDelete       = { fg = g.delete },
    GitGutterAddLineNr    = { fg = g.add },
    GitGutterChangeLineNr = { fg = g.change },
    GitGutterDeleteLineNr = { fg = g.delete },
  }
  return ret
end

return M

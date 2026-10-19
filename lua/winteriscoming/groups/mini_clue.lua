local M = {}

M.url = "https://github.com/echasnovski/mini.clue"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MiniClueBorder              = "FloatBorder",
    MiniClueDescGroup           = { fg = c.sky, bg = c.bg_float },
    MiniClueDescSingle          = "NormalFloat",
    MiniClueNextKey             = { fg = c.ice, bg = c.bg_float },
    MiniClueNextKeyWithPostkeys = { fg = c.red, bg = c.bg_float },
    MiniClueSeparator           = { fg = c.fg_muted, bg = c.bg_float },
    MiniClueTitle               = "FloatTitle",
  }
  return ret
end

return M

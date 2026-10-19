local M = {}

M.url = "https://github.com/echasnovski/mini.hipatterns"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MiniHipatternsFixme = { fg = c.on_accent, bg = c.error, bold = true },
    MiniHipatternsHack  = { fg = c.on_accent, bg = c.warning, bold = true },
    MiniHipatternsNote  = { fg = c.on_accent, bg = c.hint, bold = true },
    MiniHipatternsTodo  = { fg = c.on_accent, bg = c.info, bold = true },
  }
  return ret
end

return M

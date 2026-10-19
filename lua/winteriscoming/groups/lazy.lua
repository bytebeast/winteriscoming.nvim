local M = {}

M.url = "https://github.com/folke/lazy.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    LazyNormal          = { fg = c.fg, bg = c.bg_float },
    LazyButton          = { fg = c.fg_light, bg = c.bg_widget },
    LazyButtonActive    = { fg = c.on_accent, bg = c.blue, bold = true },
    LazyH1              = { fg = c.on_accent, bg = c.blue, bold = true },
    LazyH2              = { fg = c.blue, bold = true },
    LazySpecial         = { fg = c.ice },
    LazyReasonPlugin    = { fg = c.purple },
    LazyReasonEvent     = { fg = c.cream },
    LazyReasonKeys      = { fg = c.teal },
    LazyReasonCmd       = { fg = c.sky },
    LazyReasonFt        = { fg = c.lavender },
    LazyReasonStart     = { fg = c.green },
    LazyReasonSource    = { fg = c.azure },
    LazyReasonRuntime   = { fg = c.steel },
    LazyCommit          = { fg = c.jade },
    LazyCommitType      = { fg = c.lavender },
    LazyDir             = { fg = c.fg_muted },
    LazyUrl             = { fg = c.sky },
    LazyProp            = { fg = c.fg_muted },
    LazyValue           = { fg = c.syntax.string },
    LazyProgressDone    = { fg = c.ice, bold = true },
    LazyProgressTodo    = { fg = c.fg_gutter, bold = true },
  }
  return ret
end

return M

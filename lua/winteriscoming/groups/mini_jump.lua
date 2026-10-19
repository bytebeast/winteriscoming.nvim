local M = {}

M.url = "https://github.com/echasnovski/mini.jump"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    MiniJump        = { fg = c.on_accent, bg = c.label },
    MiniJump2dSpot  = { fg = c.label, bold = true, nocombine = true },
    MiniJump2dSpotAhead  = { fg = c.teal, nocombine = true },
    MiniJump2dSpotUnique = { fg = c.cream, bold = true, nocombine = true },
    MiniJump2dDim   = { fg = c.fg_muted },
  }
  return ret
end

return M

local M = {}

M.url = "https://github.com/rcarriga/nvim-dap-ui"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    DapUIScope                   = { fg = c.blue, bold = true },
    DapUIType                    = { fg = c.syntax.type },
    DapUIValue                   = { fg = c.fg },
    DapUIVariable                = { fg = c.syntax.variable },
    DapUIModifiedValue           = { fg = c.cream, bold = true },
    DapUIDecoration              = { fg = c.blue },
    DapUIThread                  = { fg = c.green },
    DapUIStoppedThread           = { fg = c.ice },
    DapUISource                  = { fg = c.lavender },
    DapUILineNumber              = { fg = c.blue },
    DapUIFloatBorder             = "FloatBorder",
    DapUIWatchesEmpty            = { fg = c.red_light },
    DapUIWatchesValue            = { fg = c.green },
    DapUIWatchesError            = { fg = c.red },
    DapUIBreakpointsPath         = { fg = c.blue },
    DapUIBreakpointsInfo         = { fg = c.green },
    DapUIBreakpointsCurrentLine  = { fg = c.green, bold = true },
    DapUIBreakpointsDisabledLine = { fg = c.fg_muted },
    DapUIStepOver                = { fg = c.sky },
    DapUIStepInto                = { fg = c.sky },
    DapUIStepBack                = { fg = c.sky },
    DapUIStepOut                 = { fg = c.sky },
    DapUIStop                    = { fg = c.red },
    DapUIPlayPause               = { fg = c.green },
    DapUIRestart                 = { fg = c.green },
    DapUIUnavailable             = { fg = c.fg_muted },
    DapUIWinSelect               = { fg = c.cream, bold = true },
  }
  for _, k in ipairs({ "StepOver", "StepInto", "StepBack", "StepOut", "Stop", "PlayPause", "Restart", "Unavailable" }) do
    ret["DapUI" .. k .. "NC"] = "DapUI" .. k
  end
  return ret
end

return M

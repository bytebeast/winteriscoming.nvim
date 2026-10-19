local M = {}

M.url = "https://github.com/MagicDuck/grug-far.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    GrugFarHelpHeader             = { fg = c.fg_muted },
    GrugFarHelpHeaderKey          = { fg = c.ice },
    GrugFarInputLabel             = { fg = c.blue },
    GrugFarInputPlaceholder       = { fg = c.fg_muted },
    GrugFarResultsChangeIndicator = { fg = c.git.change },
    GrugFarResultsHeader          = { fg = c.cream },
    GrugFarResultsLineColumn      = { fg = c.fg_muted },
    GrugFarResultsLineNo          = { fg = c.line_nr },
    GrugFarResultsMatch           = { fg = c.on_accent, bg = c.bg_cursearch },
    GrugFarResultsStats           = { fg = c.sky },
    GrugFarResultsPath            = { fg = c.sky },
  }
  return ret
end

return M

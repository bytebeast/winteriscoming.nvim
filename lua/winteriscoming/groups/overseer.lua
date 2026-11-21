local M = {}

M.url = "https://github.com/stevearc/overseer.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    OverseerPENDING    = { fg = c.fg_muted },
    OverseerRUNNING    = { fg = c.warning },
    OverseerSUCCESS    = { fg = c.ok },
    OverseerCANCELED   = { fg = c.fg_muted },
    OverseerFAILURE    = { fg = c.error },
    OverseerTask       = { fg = c.accent },
    OverseerTaskBorder = { fg = c.border_highlight },
    OverseerOutput     = { fg = c.fg },
    OverseerComponent  = { fg = c.cream },
    OverseerField      = { fg = c.teal },
  }
  return ret
end

return M

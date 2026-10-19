local M = {}

M.url = "https://github.com/olimorris/codecompanion.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    CodeCompanionChatHeader   = { fg = c.blue, bold = true },
    CodeCompanionChatSeparator= { fg = c.border },
    CodeCompanionChatTool     = { fg = c.on_accent, bg = c.teal },
    CodeCompanionChatVariable = { fg = c.on_accent, bg = c.lavender },
    CodeCompanionVirtualText  = { fg = c.dark5 },
  }
  return ret
end

return M

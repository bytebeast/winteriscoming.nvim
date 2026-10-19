local M = {}

M.url = "https://github.com/zbirenbaum/copilot.lua"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    CopilotAnnotation = { fg = c.dark5 },
    CopilotSuggestion = { fg = c.dark5 },
  }
  return ret
end

return M

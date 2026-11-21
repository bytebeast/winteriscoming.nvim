local M = {}

M.url = "https://github.com/nvim-orgmode/orgmode"

-- orgmode copies these from Error/WarningMsg/diffAdded and lightens them,
-- which costs contrast on the light style. Everything else links to
-- treesitter groups.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    ["@org.agenda.deadline"]          = { fg = c.error },
    ["@org.agenda.deadline.upcoming"] = { fg = c.warning },
    ["@org.agenda.scheduled"]         = { fg = c.ok },
    ["@org.agenda.scheduled_past"]    = { fg = c.warning },
    ["@org.agenda.time_grid"]         = { fg = c.warning },
    ["@org.keyword.todo"]             = { fg = c.error, bold = true },
    ["@org.keyword.done"]             = { fg = c.ok, bold = true },
  }
  return ret
end

return M

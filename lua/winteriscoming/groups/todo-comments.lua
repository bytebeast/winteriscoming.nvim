local M = {}

M.url = "https://github.com/folke/todo-comments.nvim"

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    TodoBgFIX  = { fg = c.on_accent, bg = c.error, bold = true },
    TodoFgFIX  = { fg = c.error },
    TodoSignFIX= { fg = c.error },
    TodoBgTODO = { fg = c.on_accent, bg = c.info, bold = true },
    TodoFgTODO = { fg = c.info },
    TodoSignTODO = { fg = c.info },
    TodoBgHACK = { fg = c.on_accent, bg = c.warning, bold = true },
    TodoFgHACK = { fg = c.warning },
    TodoSignHACK = { fg = c.warning },
    TodoBgWARN = { fg = c.on_accent, bg = c.warning, bold = true },
    TodoFgWARN = { fg = c.warning },
    TodoSignWARN = { fg = c.warning },
    TodoBgPERF = { fg = c.on_accent, bg = c.purple, bold = true },
    TodoFgPERF = { fg = c.purple },
    TodoSignPERF = { fg = c.purple },
    TodoBgNOTE = { fg = c.on_accent, bg = c.hint, bold = true },
    TodoFgNOTE = { fg = c.hint },
    TodoSignNOTE = { fg = c.hint },
    TodoBgTEST = { fg = c.on_accent, bg = c.lavender, bold = true },
    TodoFgTEST = { fg = c.lavender },
    TodoSignTEST = { fg = c.lavender },
  }
  return ret
end

return M

local M = {}

-- VS Code's status bar is solid winter blue with #03648a items. Normal mode
-- reproduces that; the other modes swap in a color from the palette.
---@param style? string
function M.get(style)
  local c, config = require("winteriscoming.colors").setup({ style = style })

  local function mode(color)
    return {
      a = { bg = color, fg = c.on_accent },
      b = { bg = c.bg_widget, fg = color },
    }
  end

  local hl = {}
  hl.normal = {
    a = { bg = c.blue, fg = c.on_accent },
    b = { bg = c.is_light and c.bg_widget or c.bg_select, fg = c.is_light and c.blue_deep or c.fg_bright },
    c = { bg = c.bg_statusline, fg = c.fg_sidebar },
  }
  hl.insert = mode(c.green)
  hl.visual = mode(c.lavender)
  hl.replace = mode(c.red)
  hl.command = mode(c.cream)
  hl.terminal = mode(c.teal)
  hl.inactive = {
    a = { bg = c.bg_statusline, fg = c.fg_muted },
    b = { bg = c.bg_statusline, fg = c.fg_muted, gui = "bold" },
    c = { bg = c.bg_statusline, fg = c.fg_muted },
  }

  if config.lualine_bold then
    for _, m in pairs(hl) do
      m.a.gui = "bold"
    end
  end
  return hl
end

return M

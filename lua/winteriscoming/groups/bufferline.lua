local M = {}

M.url = "https://github.com/akinsho/bufferline.nvim"

-- VS Code tab bar: the strip is the darkest surface, inactive tabs are
-- #010e1a, the active tab is the lighter #0b2942 with a winter-blue accent
-- (a top border in VS Code, the left indicator `▎` here).

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
---@return table<string, vim.api.keyset.highlight> keyed by bufferline's own names
function M.theme(c, opts)
  local fill = opts.transparent and c.none or c.bg_darker
  local inactive = opts.transparent and c.none or c.bg_dark
  local visible = c.bg_dark
  local selected = c.bg_widget

  -- stylua: ignore
  local ret = {
    fill                   = { bg = fill },
    background             = { fg = c.fg_muted, bg = inactive },
    buffer                 = { fg = c.fg_muted, bg = inactive },
    buffer_visible         = { fg = c.fg_dark, bg = visible },
    buffer_selected        = { fg = c.fg_light, bg = selected, bold = true },
    tab                    = { fg = c.fg_muted, bg = inactive },
    tab_selected           = { fg = c.on_accent, bg = c.blue, bold = true },
    tab_close              = { fg = c.red, bg = fill },
    tab_separator          = { fg = fill, bg = inactive },
    tab_separator_selected = { fg = fill, bg = c.blue },
    close_button           = { fg = c.fg_muted, bg = inactive },
    close_button_visible   = { fg = c.fg_muted, bg = visible },
    close_button_selected  = { fg = c.fg_dark, bg = selected },
    numbers                = { fg = c.fg_muted, bg = inactive },
    numbers_visible        = { fg = c.fg_muted, bg = visible },
    numbers_selected       = { fg = c.blue, bg = selected, bold = true },
    modified               = { fg = c.cream, bg = inactive },
    modified_visible       = { fg = c.cream, bg = visible },
    modified_selected      = { fg = c.cream, bg = selected },
    duplicate              = { fg = c.dark5, bg = inactive },
    duplicate_visible      = { fg = c.dark5, bg = visible },
    duplicate_selected     = { fg = c.dark5, bg = selected },
    separator              = { fg = fill, bg = inactive },
    separator_visible      = { fg = fill, bg = visible },
    separator_selected     = { fg = fill, bg = selected },
    offset_separator       = { fg = c.border, bg = c.bg_sidebar },
    indicator_selected     = { fg = c.blue, bg = selected }, -- tab.activeBorderTop
    indicator_visible      = { fg = visible, bg = visible },
    pick                   = { fg = c.on_accent, bg = c.label, bold = true },
    pick_visible           = { fg = c.on_accent, bg = c.label, bold = true },
    pick_selected          = { fg = c.on_accent, bg = c.label, bold = true },
    trunc_marker           = { fg = c.fg_muted, bg = fill },
    group_separator        = { fg = c.fg_muted, bg = fill },
    group_label            = { fg = c.on_accent, bg = c.fg_muted },
  }

  -- diagnostics: the file name keeps its normal color in every state and
  -- only the count (● 3 ▲ 1) carries the severity color
  local levels = { error = c.error, warning = c.warning, info = c.info, hint = c.hint }
  local states = { [""] = ret.buffer, _visible = ret.buffer_visible, _selected = ret.buffer_selected }
  for level, color in pairs(levels) do
    for suffix, name in pairs(states) do
      ret[level .. suffix] = vim.deepcopy(name)
      ret[level .. "_diagnostic" .. suffix] = { fg = color, bg = name.bg, bold = name.bold }
    end
  end
  for suffix, name in pairs(states) do
    ret["diagnostic" .. suffix] = { fg = c.fg_muted, bg = name.bg }
  end
  return ret
end

--- Highlights in bufferline's format for its `highlights` option. Only needed
--- if you set bufferline's `themable = false`; otherwise the colorscheme
--- groups below are picked up automatically.
---@param opts? winteriscoming.Config
function M.highlights(opts)
  local c, o = require("winteriscoming.colors").setup(opts)
  return M.theme(c, o)
end

-- Bufferline creates its groups with `default = true` (its `themable`
-- option), so groups defined by the colorscheme take precedence.
---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local ret = {}
  for name, hl in pairs(M.theme(c, opts)) do
    local group = "BufferLine" .. name:gsub("^%l", string.upper):gsub("_(%l)", string.upper)
    ret[group] = hl
  end
  return ret
end

return M

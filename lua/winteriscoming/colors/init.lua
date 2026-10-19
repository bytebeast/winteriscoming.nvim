local Util = require("winteriscoming.util")

local M = {}

M.styles = setmetatable({}, {
  __index = function(_, style)
    return vim.deepcopy(Util.mod("winteriscoming.colors." .. style))
  end,
})

-- Semantic aliases that point at a palette color by name. They are resolved
-- after `on_colors`, so overriding `ice` also recolors keywords, jump labels…
M.aliases = {
  "indent_scope",
  "label",
  "prompt",
  "error",
  "warning",
  "info",
  "hint",
  "ok",
  "todo",
}

---@param c table
---@param value string
local function ref(c, value)
  if type(value) == "string" and value:sub(1, 1) ~= "#" and value ~= "NONE" and type(c[value]) == "string" then
    return c[value]
  end
  return value
end

---@param opts? winteriscoming.Config
---@return winteriscoming.ColorScheme, winteriscoming.Config
function M.setup(opts)
  opts = require("winteriscoming.config").extend(opts)

  local palette = M.styles[opts.style]
  if type(palette) == "function" then
    palette = palette(opts)
  end

  ---@type winteriscoming.ColorScheme
  local c = palette
  local light = opts.style == "light"

  Util.bg = c.bg
  Util.fg = c.fg

  c.none = "NONE"
  c.style = opts.style
  c.is_light = light

  -- Text drawn on top of a saturated accent (badges, statusline mode, labels)
  c.on_accent = light and "#ffffff" or c.bg_darker
  c.black = light and c.fg_bright or Util.blend(c.bg, 0.6, "#000000")

  c.diff = {
    add = Util.blend_bg(c.git.add, light and 0.22 or 0.16),
    delete = Util.blend_bg(c.red, 0.18),
    change = Util.blend_bg(c.blue, light and 0.12 or 0.14),
    text = Util.blend_bg(c.blue, light and 0.32 or 0.38),
  }
  c.git.ignore = c.fg_muted

  c.border_highlight = light and c.blue or Util.blend_bg(c.blue, 0.75)
  c.line_nr = opts.bright_line_numbers and c.blue or Util.blend_bg(c.blue, light and 0.8 or 0.6)
  c.line_nr_cursor = light and c.blue_deep or c.blue

  -- Popups & statusline always sit a step darker than the editor
  c.bg_popup = c.bg_dark
  c.bg_statusline = c.bg_dark

  c.bg_sidebar = opts.styles.sidebars == "transparent" and c.none
    or opts.styles.sidebars == "dark" and c.bg_dark
    or c.bg
  c.bg_float = opts.styles.floats == "transparent" and c.none or opts.styles.floats == "dark" and c.bg_dark or c.bg
  c.fg_sidebar = c.fg_dark
  c.fg_float = c.fg

  -- Search: VS Code peeks use a translucent indigo; the current match uses
  -- the "warning" cream so it is impossible to miss.
  c.bg_search = Util.blend_bg(c.indigo, light and 0.3 or 0.5)
  c.bg_cursearch = light and c.amber or c.cream

  -- editorIndentGuide.activeBackground: purple in the dark themes, blue in light
  c.indent_scope = light and "blue" or "purple"
  c.label = "ice" -- jump labels, picker selection
  c.prompt = "cream" -- picker prompts & inputs: peekView.border

  c.error = "red"
  c.warning = "amber"
  c.info = "blue"
  c.hint = "teal"
  c.ok = "green"
  c.todo = "blue"

  -- `faithful`: undo this port's adjustments and use the exact VS Code values
  if opts.faithful and c.vscode then
    for k, v in pairs(c.vscode.syntax or {}) do
      c.syntax[k] = v
    end
    for k, v in pairs(c.vscode.ui or {}) do
      c[k] = v
    end
    c.comment = c.syntax.comment == "comment_vscode" and c.comment_vscode or c.comment
  end

  opts.on_colors(c)

  for _, key in ipairs(M.aliases) do
    c[key] = ref(c, c[key])
  end
  for role, value in pairs(c.syntax) do
    c.syntax[role] = ref(c, value)
  end

  -- headings & rainbow guides; H1 keeps the original markdown heading color
  c.rainbow = c.rainbow
    or {
      c.syntax.heading,
      c.azure,
      c.lavender,
      c.cream,
      c.green,
      c.pink,
      c.ember,
      c.ice,
    }

  return c, opts
end

return M

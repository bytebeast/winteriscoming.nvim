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
  "accent",
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

--- `colorblind`: palette names for the colors that carry meaning on their
--- own. Chosen by simulating each color vision deficiency (Machado et al.
--- 2009, full severity) and maximizing the smallest OKLab distance between
--- colors that must be told apart, within GitHub's colorblind conventions:
--- added and ok are blue, deleted and errors warm, warnings yellow. The light
--- style's deeper inks need their own set.
M.colorblind = {
  ["red-green"] = {
    dark = {
      git = { add = "sky", change = "cream", delete = "ember", conflict = "purple" },
      diag = { error = "ember", warning = "cream", ok = "sky", info = "lavender", hint = "violet" },
    },
    light = {
      git = { add = "azure", change = "mint", delete = "coral", conflict = "purple" },
      diag = { error = "rose", warning = "amber", ok = "azure", info = "periwinkle", hint = "lavender" },
    },
  },
  ["blue-yellow"] = {
    dark = {
      git = { add = "blue", change = "cream", delete = "coral", conflict = "purple" },
      diag = { error = "coral", warning = "cream", ok = "blue", info = "aqua", hint = "lavender" },
    },
    light = {
      git = { add = "sky", change = "lavender", delete = "coral", conflict = "purple" },
      diag = { error = "coral", warning = "amber", ok = "sky", info = "green", hint = "purple" },
    },
  },
}

--- Diff backgrounds mix in more color in colorblind mode, so added and
--- deleted lines stay as far apart as they are for normal color vision.
M.COLORBLIND_DIFF_BOOST = 1.35

--- The least color status roles (git, diff, diagnostics) keep under
--- `saturation`: below this their hues start to merge for everyone.
M.STATUS_SATURATION = 0.7

--- Faintest contrast `subtle_comments` fades to (fade = 1).
M.SUBTLE_FLOOR = 1.6

--- Fade `color` toward `bg` by `fade` (0..1), measured in contrast: 0 keeps
--- the current contrast, 1 reaches `M.SUBTLE_FLOOR`.
function M.fade(color, bg, fade)
  local from = Util.contrast(color, bg)
  if from <= M.SUBTLE_FLOOR then
    return color
  end
  return Util.reduce_contrast(color, bg, from - fade * (from - M.SUBTLE_FLOOR))
end

--- `saturation`: scale every palette color's chroma in OKLab, then restore
--- its original contrast against the (new) background, so the contrast
--- hierarchy stays exactly as tuned.
function M.desaturate(p, amount)
  local bg = p.bg
  local new_bg = Util.desaturate(bg, amount)
  local function walk(t)
    for k, v in pairs(t) do
      if type(v) == "table" then
        walk(v)
      elseif Util.is_hex(v) then
        t[k] = (t == p and k == "bg") and new_bg
          or Util.match_contrast(Util.desaturate(v, amount), new_bg, Util.contrast(v, bg))
      end
    end
  end
  walk(p)
end

--- `rainbow = "dimmed" | "mono"` for rainbow delimiters and indent scopes.
---   dimmed: each color keeps its hue at 70% of its contrast (never below 3:1)
---   mono:   no hue; a ladder from `fg_light` (outermost) down to `fg_dark`
function M.rainbow_mode(c, mode)
  local function dim(color)
    return Util.reduce_contrast(color, c.bg, math.max(3, Util.contrast(color, c.bg) * 0.7))
  end
  local function shade(i, n)
    return Util.blend(c.fg_dark, (i - 1) / math.max(1, n - 1), c.fg_light)
  end
  local order = { "red", "yellow", "blue", "orange", "green", "violet", "cyan" } -- rainbow-delimiters' nesting order
  for i, name in ipairs(order) do
    c.brackets[name] = mode == "mono" and shade(i, #order) or dim(c.brackets[name])
  end
  for i, color in ipairs(c.scopes) do
    c.scopes[i] = mode == "mono" and shade(i, #c.scopes) or dim(color)
  end
end

--- `rainbow_variables`: how many colors variables cycle through, and the
--- palette colors whose typical chroma and contrast they are tuned to.
M.VARIABLE_COLORS = 12
M.VARIABLE_ACCENTS =
  { "red", "rose", "ember", "gold", "green", "teal", "cyan", "sky", "blue", "lavender", "purple", "pink" }
M.VARIABLE_HUE_START = 25
M.VARIABLE_TIER = 0.6
--- OKLab hues each color vision deficiency keeps apart.
M.VARIABLE_CVD_HUES = { ["red-green"] = { 260, 85 }, ["blue-yellow"] = { 25, 195 } }

local function median(list)
  table.sort(list)
  local n = #list
  return n % 2 == 1 and list[(n + 1) / 2] or (list[n / 2] + list[n / 2 + 1]) / 2
end

--- Evenly spaced hues around the OKLab circle at the palette's typical
--- chroma and contrast, so per-variable colors weigh as much as the theme's
--- own colors. Two lightness tiers alternate, so hue neighbours also differ
--- in lightness. With `colorblind`, hue alone can't carry 12 colors: the set
--- uses the two hues that type still tells apart, in three lightness steps.
---@param c table needs `bg`, `fg` and every name in `M.VARIABLE_ACCENTS`
---@param colorblind? false|"red-green"|"blue-yellow"
---@param floor? number lowest contrast against `bg`
---@return string[]
function M.variable_colors(c, colorblind, floor)
  floor = floor or 4.5
  local chromas, ratios = {}, {}
  for _, key in ipairs(M.VARIABLE_ACCENTS) do
    local _, a, b = Util.to_oklab(c[key])
    chromas[#chromas + 1] = math.sqrt(a * a + b * b)
    ratios[#ratios + 1] = Util.contrast(c[key], c.bg)
  end
  local chroma, ratio = median(chromas), math.max(floor, median(ratios))
  local fg_ratio = Util.contrast(c.fg, c.bg)
  -- the second tier goes toward the background where there's room, otherwise
  -- it stops at the floor or goes away from the background, whichever leaves
  -- the wider gap
  local function tier(k)
    if k == 0 then
      return ratio
    end
    local down = ratio * M.VARIABLE_TIER ^ k
    if down >= floor then
      return down
    end
    local up = math.min(ratio / M.VARIABLE_TIER ^ k, fg_ratio * 0.95)
    return ratio / floor >= up / ratio and floor or up
  end
  local L = Util.to_oklab(c.fg)
  local function color(hue, target)
    local h = math.rad(hue)
    return Util.match_contrast(Util.from_oklab(L, chroma * math.cos(h), chroma * math.sin(h)), c.bg, target)
  end
  local out = {}
  local axis = M.VARIABLE_CVD_HUES[colorblind or ""]
  if axis then
    local lo, hi = floor + 0.1, fg_ratio * 0.95
    for _, target in ipairs({ lo, math.sqrt(lo * hi), hi }) do
      for _, hue in ipairs(axis) do
        out[#out + 1] = color(hue, target)
      end
    end
    return out
  end
  for i = 0, M.VARIABLE_COLORS - 1 do
    out[i + 1] = color(M.VARIABLE_HUE_START + i * 360 / M.VARIABLE_COLORS, tier(i % 2))
  end
  return out
end

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

  -- status colors (git, diff, diagnostics) carry meaning by hue, so they keep
  -- more color than `saturation` asks for: at least STATUS_SATURATION, and
  -- all of it with `colorblind`
  local s = c -- palette the status colors read from
  if opts.saturation < 1 then
    s = vim.deepcopy(c)
    M.desaturate(c, opts.saturation)
    local status = opts.colorblind and 1 or math.max(opts.saturation, M.STATUS_SATURATION)
    if status < 1 then
      M.desaturate(s, status)
    end
    -- match the status colors to the background actually on screen
    local function walk(t)
      for k, v in pairs(t) do
        if type(v) == "table" then
          walk(v)
        elseif Util.is_hex(v) and not (t == s and k == "bg") then
          t[k] = Util.match_contrast(v, c.bg, Util.contrast(v, s.bg))
        end
      end
    end
    walk(s)
    c.git = vim.deepcopy(s.git)
  end
  local cb = opts.colorblind and M.colorblind[opts.colorblind][light and "light" or "dark"]
  if cb then
    for role, name in pairs(cb.git) do
      c.git[role] = s[name]
    end
  end

  -- `contrast = "high"`: lift the low-contrast chrome. Syntax roles follow
  -- once they are resolved, below.
  if opts.contrast == "high" then
    c.comment = Util.ensure_contrast(c.comment, c.bg, 6.0, c.fg)
    c.fg_muted = Util.ensure_contrast(c.fg_muted, c.bg, 4.5, c.fg)
    c.fg_dark = Util.ensure_contrast(c.fg_dark, c.bg, light and 7.0 or 8.0, c.fg)
    c.dark5 = Util.ensure_contrast(c.dark5, c.bg, 4.5, c.fg)
    c.dark3 = Util.ensure_contrast(c.dark3, c.bg, 2.0, c.fg)
  end

  Util.bg = c.bg
  Util.fg = c.fg

  c.none = "NONE"
  c.style = opts.style
  c.is_light = light

  -- Text drawn on top of a saturated accent (badges, statusline mode, labels)
  c.on_accent = light and "#ffffff" or c.bg_darker
  c.black = light and c.fg_bright or Util.blend(c.bg, 0.6, "#000000")

  local hue = { add = c.git.add, delete = s.red, change = s.blue }
  local boost = 1
  if cb then
    hue = { add = c.git.add, delete = c.git.delete, change = c.git.change }
    boost = M.COLORBLIND_DIFF_BOOST
  end
  c.diff = {
    add = Util.blend_bg(hue.add, (light and 0.22 or 0.16) * boost),
    delete = Util.blend_bg(hue.delete, 0.18 * boost),
    change = Util.blend_bg(hue.change, (light and 0.12 or 0.14) * boost),
    text = Util.blend_bg(hue.change, (light and 0.32 or 0.38) * boost),
  }
  c.git.ignore = c.fg_muted
  c.git.conflict = c.git.conflict or c.ember

  c.accent = opts.accent -- titles, the selected tab, badges

  local accent = c[opts.accent]
  c.border_highlight = (light or opts.bright_borders) and accent or Util.blend_bg(accent, 0.75)
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

  -- `borderless`: picker panels told apart by shade instead of lines. The
  -- prompt takes VS Code's input background, the list the float shade and
  -- the preview the deepest one. Always solid, even with `transparent`.
  c.picker = {
    prompt = c.bg_input,
    list = c.bg_dark,
    preview = c.bg_darker,
    sel = Util.blend(c.blue, light and 0.15 or 0.22, c.bg_dark),
  }

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
  if cb then
    for role, name in pairs(cb.diag) do
      c[role] = name
    end
  end

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

  local stock = { comment = c.syntax.comment, docstring = c.syntax.docstring }

  opts.on_colors(c)

  local subtle = require("winteriscoming.config").subtle_comments(opts)
  -- a role you set in on_colors is left alone
  local fade = {
    comment = subtle and subtle.fade > 0 and stock.comment == c.syntax.comment,
    docstring = subtle and subtle.fade > 0 and subtle.docstrings and stock.docstring == c.syntax.docstring,
  }

  local status = { error = true, warning = true, info = true, hint = true, ok = true }
  for _, key in ipairs(M.aliases) do
    -- with `saturation`, status names resolve to the less desaturated colors
    c[key] = ref(status[key] and s ~= c and s or c, c[key])
    c[key] = ref(c, c[key])
  end
  for role, value in pairs(c.syntax) do
    c.syntax[role] = ref(c, value)
  end

  -- Statusline mode colors (lualine, mini.statusline). Normal mode is the
  -- accent; a mode that would share its color takes blue instead, so no two
  -- modes ever look the same.
  c.modes = { normal = c.accent }
  for mode, name in pairs({
    insert = "green",
    visual = "lavender",
    replace = "red",
    command = "cream",
    terminal = "teal",
  }) do
    c.modes[mode] = c[name == opts.accent and "blue" or name]
  end

  for role, color in pairs(c.syntax) do
    if opts.contrast == "high" and not fade[role] then
      -- 4.55 so hex rounding can't land below 4.5
      c.syntax[role] = Util.contrast(color, c.bg) < 4.5 and Util.match_contrast(color, c.bg, 4.55) or color
    end
    if fade[role] then
      c.syntax[role] = M.fade(color, c.bg, subtle.fade)
    end
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

  -- rainbow-delimiters' groups by its color names, and rainbow indent
  -- scopes; both follow `rainbow`, headings keep `c.rainbow`
  c.brackets = c.brackets
    or {
      red = c.red_light,
      orange = c.ember,
      yellow = c.cream,
      green = c.green,
      blue = c.ice,
      violet = c.lavender,
      cyan = c.teal,
    }
  c.scopes = c.scopes or vim.list_extend({}, c.rainbow)
  if opts.rainbow ~= "vivid" then
    M.rainbow_mode(c, opts.rainbow)
  end

  -- `rainbow_variables`: like status colors, these carry meaning, so they
  -- read from the status palette. None goes below AA on the cursorline.
  if opts.rainbow_variables then
    local base = { bg = c.bg, fg = c.fg }
    for _, key in ipairs(M.VARIABLE_ACCENTS) do
      base[key] = s[key]
    end
    local floor = math.max(4.5, 4.5 * Util.contrast(c.bg_highlight, c.bg))
    c.variables = M.variable_colors(base, opts.colorblind, floor)
  end

  return c, opts
end

return M

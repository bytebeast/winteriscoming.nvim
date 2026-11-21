local M = {}

M.version = "1.2.1"

M.styles = { "blue", "black", "light" }

--- `accent` choices: blue (the default) plus every palette color that keeps
--- badge text (`on_accent`) at 4.5:1 in all three styles.
M.accents = {
  "blue",
  "sky",
  "azure",
  "periwinkle",
  "teal",
  "aqua",
  "green",
  "lime",
  "cream",
  "amber",
  "coral",
  "rose",
  "pink",
  "lavender",
  "purple",
}

---@type winteriscoming.Config
M.defaults = {
  style = "blue", -- "blue" (Dark Blue), "black" (Dark Black) or "light"
  light_style = "light", -- style used when `vim.o.background` is "light"
  transparent = false, -- don't set the editor background
  terminal_colors = true, -- set `vim.g.terminal_color_*` for :terminal
  -- Inactive statuslines become a thin line in the window separator color.
  -- No effect with a global statusline (laststatus=3, LazyVim's default).
  hide_inactive_statusline = false,

  -- Master switch: false drops every italic, whatever `styles` says.
  italics = true,
  bold = true, -- set to false to drop all bold attributes

  -- Per-category styles. Any attr-list accepted by `nvim_set_hl` works.
  -- Comments and keywords are italic by default. The VS Code theme also
  -- italicizes functions, variables, properties and decorators; to get that
  -- look back set those categories to `{ italic = true }`.
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    properties = {},
    attributes = {}, -- decorators and tag attributes
    parameters = {},
    types = {},
    strings = {},
    operators = {},
    virtual_text = {}, -- diagnostic virtual text, e.g. { italic = true }
    inlay_hints = {},
    -- LSP semantic modifiers; these stack on the token's color
    mutable = {}, -- `mut` bindings (rust-analyzer), e.g. { underline = true }
    readonly = {}, -- const / readonly / final, e.g. { italic = true }
    statics = {}, -- static members, e.g. { bold = true }
    globals = {}, -- global scope (clangd, LuaLS), e.g. { underdotted = true }
    -- Background styles: "dark", "transparent" or "normal"
    sidebars = "dark", -- neo-tree, trouble, help, quickfix, ...
    floats = "dark", -- floating windows
  },

  -- VS Code shows every line number in bright winter blue. That is faithful
  -- but loud in a terminal, so by default only the current line is bright.
  bright_line_numbers = false,
  -- This port nudges a few colors for legibility in a terminal: functions,
  -- variables, constants, the comment grey (and the Dark Black selection).
  -- Set to true for the exact VS Code values instead.
  faithful = false,
  dim_inactive = false, -- darken inactive windows

  -- "normal" keeps the tuned palette. "high" lifts comments, line numbers,
  -- muted UI text and every syntax color below WCAG AA (4.5:1) to stronger
  -- contrast (bright rooms, projectors, low vision).
  contrast = "normal",
  -- Fade comments toward the background so they recede behind code:
  -- false, true (= 0.5), a fade from 0 to 1, or { fade = 0.7, docstrings = false }.
  -- Measured in contrast, and 1 stops at 1.6:1 so comments never vanish.
  subtle_comments = false,
  -- Color vision support: remaps git, diff and diagnostic colors to sets that
  -- stay distinct. false, "red-green" (protan/deutan) or "blue-yellow" (tritan).
  colorblind = false,
  -- Color intensity from 0 (greys) to 1 (full color). Contrast is kept.
  saturation = 1,
  -- UI accent for titles, badges, the selected tab, float borders and the
  -- normal-mode statusline. One of `require("winteriscoming.config").accents`.
  accent = "blue",
  -- Rainbow delimiters and indent scopes: "vivid", "dimmed" (quieter than
  -- code) or "mono" (shades of grey by nesting depth).
  rainbow = "vivid",
  -- A color per local variable and parameter, as in JetBrains IDEs. Needs an
  -- LSP with semantic tokens.
  rainbow_variables = false,

  diagnostics = {
    underline = "undercurl", -- how problems are marked in code: "undercurl", "underline" or false
    virtual_text = "tinted", -- "tinted" (colored background) or "plain"
  },
  inlay_hints = "tinted", -- "tinted" (VS Code's inlay hint background) or "plain"

  -- Pickers (Telescope, snacks, fzf-lua) without border lines: prompt, list
  -- and preview are told apart by background shade and title badges.
  borderless = false,
  bright_borders = false, -- float borders in the full accent color
  lualine_bold = false, -- bold section "a" in the lualine theme

  --- Change any color before highlights are generated.
  ---@param colors winteriscoming.ColorScheme
  on_colors = function(colors) end,

  --- Change any highlight group after it is generated.
  ---@param highlights winteriscoming.Highlights
  ---@param colors winteriscoming.ColorScheme
  on_highlights = function(highlights, colors) end,

  cache = true, -- cache the generated highlights for faster startup

  ---@type table<string, boolean|{enabled:boolean}>
  plugins = {
    -- true: every integration. nil: every integration only when neither
    -- lazy.nvim nor vim.pack is in use
    all = nil,
    -- with lazy.nvim or vim.pack, only load integrations for installed plugins
    auto = true,
    -- force a specific integration on or off, e.g.
    -- telescope = true,
  },
}

---@type winteriscoming.Config
M.options = nil

local function one_of(list)
  return function(v)
    return vim.tbl_contains(list, v)
  end
end

local function is_type(t)
  return function(v)
    return type(v) == t
  end
end

local backgrounds = one_of({ "dark", "normal", "transparent" })

--- Every option check: { dotted path, test, what's expected }. An invalid
--- value is reported once and replaced by its default, so a typo never
--- leaves you with a broken editor. Parents come before their children.
-- stylua: ignore
local rules = {
  { "style", one_of(M.styles), "one of " .. table.concat(M.styles, ", ") },
  { "light_style", one_of(M.styles), "one of " .. table.concat(M.styles, ", ") },
  { "contrast", one_of({ "normal", "high" }), '"normal" or "high"' },
  { "subtle_comments", function(v) return v == false or M.subtle_comments({ subtle_comments = v }) ~= nil end, "false, true, a number from 0 to 1, or { fade = 0..1, docstrings = boolean }" },
  { "colorblind", function(v) return v == false or v == "red-green" or v == "blue-yellow" end, 'false, "red-green" or "blue-yellow"' },
  { "saturation", function(v) return type(v) == "number" and v >= 0 and v <= 1 end, "a number from 0 to 1" },
  { "accent", one_of(M.accents), "one of " .. table.concat(M.accents, ", ") },
  { "rainbow", one_of({ "vivid", "dimmed", "mono" }), '"vivid", "dimmed" or "mono"' },
  { "diagnostics", is_type("table"), "table" },
  { "diagnostics.underline", function(v) return v == false or v == "undercurl" or v == "underline" end, '"undercurl", "underline" or false' },
  { "diagnostics.virtual_text", one_of({ "tinted", "plain" }), '"tinted" or "plain"' },
  { "inlay_hints", one_of({ "tinted", "plain" }), '"tinted" or "plain"' },
  { "styles", is_type("table"), "table" },
  { "styles.sidebars", backgrounds, '"dark", "normal" or "transparent"' },
  { "styles.floats", backgrounds, '"dark", "normal" or "transparent"' },
  { "plugins", is_type("table"), "table" },
}
for _, k in ipairs({
  "transparent",
  "terminal_colors",
  "hide_inactive_statusline",
  "italics",
  "bold",
  "bright_line_numbers",
  "faithful",
  "dim_inactive",
  "lualine_bold",
  "borderless",
  "bright_borders",
  "rainbow_variables",
  "cache",
}) do
  rules[#rules + 1] = { k, is_type("boolean"), "boolean" }
end
for _, k in ipairs({
  "comments",
  "keywords",
  "functions",
  "variables",
  "properties",
  "attributes",
  "parameters",
  "types",
  "strings",
  "operators",
  "virtual_text",
  "inlay_hints",
  "mutable",
  "readonly",
  "statics",
  "globals",
}) do
  rules[#rules + 1] = { "styles." .. k, is_type("table"), "table of highlight attributes" }
end
for _, k in ipairs({ "on_colors", "on_highlights" }) do
  rules[#rules + 1] = { k, is_type("function"), "function" }
end

local function fade_ok(v)
  return type(v) == "number" and v >= 0 and v <= 1
end

--- `subtle_comments` as `{ fade, docstrings }`, or nil when off or invalid.
---@param opts winteriscoming.Config
---@return {fade: number, docstrings: boolean}?
function M.subtle_comments(opts)
  local v = opts.subtle_comments
  if v == true then
    return { fade = 0.5, docstrings = true }
  elseif fade_ok(v) then
    return { fade = v, docstrings = true }
  elseif type(v) == "table" then
    local fade = v.fade == nil and 0.5 or v.fade
    local docstrings = v.docstrings == nil or v.docstrings
    if fade_ok(fade) and type(docstrings) == "boolean" then
      return { fade = fade, docstrings = docstrings }
    end
  end
  return nil
end

local function get(t, path)
  for key in path:gmatch("[^.]+") do
    if type(t) ~= "table" then
      return nil
    end
    t = t[key]
  end
  return t
end

local function set(t, path, value)
  local keys = vim.split(path, ".", { plain = true })
  for i = 1, #keys - 1 do
    if type(t[keys[i]]) ~= "table" then
      t[keys[i]] = {}
    end
    t = t[keys[i]]
  end
  t[keys[#keys]] = vim.deepcopy(value)
end

--- Report invalid options once and replace them with their defaults.
---@param opts winteriscoming.Config
function M.validate(opts)
  local errors = {}
  for _, rule in ipairs(rules) do
    -- a non-table parent (e.g. `diagnostics = "x"`) is reported once, by its own rule
    local parent = rule[1]:match("^(.+)%.[^.]+$")
    if (not parent or type(get(opts, parent)) == "table") and not rule[2](get(opts, rule[1])) then
      errors[#errors + 1] = ("%s: expected %s"):format(rule[1], rule[3])
    end
  end
  if #errors > 0 then
    vim.notify(
      "invalid configuration (using defaults for these):\n  " .. table.concat(errors, "\n  "),
      vim.log.levels.WARN,
      { title = "winteriscoming.nvim" }
    )
    for _, rule in ipairs(rules) do
      if not rule[2](get(opts, rule[1])) then
        set(opts, rule[1], get(M.defaults, rule[1]))
      end
    end
  end
  return opts
end

---@param options? winteriscoming.Config
function M.setup(options)
  M.options = M.validate(vim.tbl_deep_extend("force", {}, M.defaults, options or {}))
end

---@param opts? winteriscoming.Config
function M.extend(opts)
  return opts and M.validate(vim.tbl_deep_extend("force", {}, M.options, opts)) or M.options
end

setmetatable(M, {
  __index = function(_, k)
    if k == "options" then
      return M.defaults
    end
  end,
})

return M

local M = {}

M.version = "1.0.0"

---@type winteriscoming.Config
M.defaults = {
  style = "blue", -- "blue" (Dark Blue), "black" (Dark Black) or "light"
  light_style = "light", -- style used when `vim.o.background` is "light"
  transparent = false, -- don't set the editor background
  terminal_colors = true, -- set `vim.g.terminal_color_*` for :terminal

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
    -- enable every plugin integration when not using lazy.nvim
    all = package.loaded.lazy == nil,
    -- with lazy.nvim, only load integrations for plugins you have installed
    auto = true,
    -- force a specific integration on or off, e.g.
    -- telescope = true,
  },
}

---@type winteriscoming.Config
M.options = nil

---@param options? winteriscoming.Config
function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})
end

---@param opts? winteriscoming.Config
function M.extend(opts)
  return opts and vim.tbl_deep_extend("force", {}, M.options, opts) or M.options
end

setmetatable(M, {
  __index = function(_, k)
    if k == "options" then
      return M.defaults
    end
  end,
})

return M

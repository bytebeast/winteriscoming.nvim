local config = require("winteriscoming.config")

local M = {}

---@type {light?: string, dark?: string}
M.styles = {}

---@param opts? winteriscoming.Config
function M.load(opts)
  opts = require("winteriscoming.config").extend(opts)
  local bg = vim.o.background
  local style_bg = opts.style == "light" and "light" or "dark"

  if bg ~= style_bg then
    if vim.g.colors_name == "winteriscoming-" .. opts.style then
      -- `:set background=...` after the theme loaded: switch variants
      opts.style = bg == "light" and (M.styles.light or opts.light_style or "light") or (M.styles.dark or "blue")
    else
      vim.o.background = style_bg
    end
  end
  M.styles[vim.o.background] = opts.style
  return require("winteriscoming.theme").setup(opts)
end

M.setup = config.setup

--- Colors for the current (or given) style, e.g. for statusline components.
---@param opts? winteriscoming.Config
function M.colors(opts)
  return require("winteriscoming.colors").setup(opts)
end

return M

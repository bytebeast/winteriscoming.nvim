local M = {}

---@param opts? winteriscoming.Config
function M.setup(opts)
  opts = require("winteriscoming.config").extend(opts)

  local colors = require("winteriscoming.colors").setup(opts)
  local groups = require("winteriscoming.groups").setup(colors, opts)

  -- only needed to clear when not the default colorscheme
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "winteriscoming-" .. opts.style

  for group, hl in pairs(groups) do
    hl = type(hl) == "string" and { link = hl } or hl
    vim.api.nvim_set_hl(0, group, hl)
  end

  if opts.terminal_colors then
    M.terminal(colors)
  end

  return colors, groups, opts
end

---@param c winteriscoming.ColorScheme
function M.terminal(c)
  local t = c.terminal
  local order = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }
  for i, name in ipairs(order) do
    vim.g["terminal_color_" .. (i - 1)] = t[name]
    vim.g["terminal_color_" .. (i + 7)] = t[name .. "_bright"]
  end
end

return M

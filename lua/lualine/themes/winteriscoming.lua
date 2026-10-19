local style = vim.g.colors_name and vim.g.colors_name:match("^winteriscoming%-(%w+)$")
if not style then
  local opts = require("winteriscoming.config").options
  style = vim.o.background == "light" and (opts.light_style or "light") or opts.style
end
return require("lualine.themes._winteriscoming").get(style)

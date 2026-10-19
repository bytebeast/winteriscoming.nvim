-- `:colorscheme winteriscoming` follows 'background': your `style` when it is
-- dark, `light_style` when it is light. Use winteriscoming-blue / -black /
-- -light to pick a variant explicitly.
local opts = require("winteriscoming.config").options
local style = opts.style
if vim.o.background == "light" and style ~= "light" then
  style = opts.light_style or "light"
end
require("winteriscoming").load({ style = style })

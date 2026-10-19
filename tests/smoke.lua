-- Run: nvim --headless --clean -u NONE --cmd "set rtp^=." -l tests/smoke.lua
local fails = 0
local function check(cond, msg)
  if not cond then
    fails = fails + 1
    io.stderr:write("FAIL: " .. msg .. "\n")
  end
end

local wic = require("winteriscoming")
wic.setup({ cache = false, plugins = { all = true } })

for _, style in ipairs({ "blue", "black", "light" }) do
  vim.cmd.colorscheme("winteriscoming-" .. style)
  check(vim.g.colors_name == "winteriscoming-" .. style, "colors_name for " .. style)
  check(vim.o.background == (style == "light" and "light" or "dark"), "background for " .. style)

  local _, groups = require("winteriscoming.theme").setup({ style = style, cache = false, plugins = { all = true } })
  for name, hl in pairs(groups) do
    if type(hl) == "string" then
      check(groups[hl] ~= nil or vim.fn.hlexists(hl) == 1, style .. ": " .. name .. " links to missing " .. hl)
    else
      for _, key in ipairs({ "fg", "bg", "sp" }) do
        local v = hl[key]
        check(
          v == nil or v == "NONE" or (type(v) == "string" and v:match("^#%x%x%x%x%x%x$")),
          style .. ": bad " .. key .. " in " .. name .. ": " .. tostring(v)
        )
      end
      check(hl.style == nil, style .. ": unresolved style in " .. name)
    end
  end
end

-- defaults: comments and keywords italic, other code not
wic.setup({ cache = false, plugins = { all = true } })
vim.cmd.colorscheme("winteriscoming-blue")
check(vim.api.nvim_get_hl(0, { name = "Comment", link = false }).italic == true, "comments italic by default")
for _, g in ipairs({ "@keyword", "@keyword.return", "@keyword.import", "@keyword.conditional", "Statement" }) do
  check(vim.api.nvim_get_hl(0, { name = g, link = false }).italic == true, g .. " should be italic by default")
end
for _, g in ipairs({
  "@variable",
  "@function",
  "@function.method",
  "@property",
  "@variable.member",
  "@attribute",
  "@tag.attribute",
  "@operator",
  "@string",
  "@variable.parameter",
  "@type",
}) do
  check(not vim.api.nvim_get_hl(0, { name = g, link = false }).italic, g .. " should not be italic by default")
end

-- faithful restores the exact VS Code values
local hex = function(g)
  return string.format("#%06x", vim.api.nvim_get_hl(0, { name = g, link = false }).fg or 0)
end
check(hex("@function") == "#8fa2f8" and hex("Comment") == "#8a9db3", "adjusted defaults")
check(hex("@string.documentation") == "#a3c7ba", "docstring color")
wic.setup({ cache = false, faithful = true })
vim.cmd.colorscheme("winteriscoming-blue")
check(hex("@function") == "#87aff4", "faithful function color, got " .. hex("@function"))
check(hex("@variable") == "#a4ceee", "faithful variable color")
check(hex("@constant") == "#82aaff", "faithful constant color")
check(hex("@string.documentation") == "#bcf0c0", "faithful docstrings are strings")
check(hex("Comment") == "#999999", "faithful comment color, got " .. hex("Comment"))
vim.cmd.colorscheme("winteriscoming-black")
check(string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Visual" }).bg) == "#103362", "faithful black selection")
wic.setup({ cache = false, plugins = { all = true } })
vim.cmd.colorscheme("winteriscoming-blue")
check(hex("@lsp.typemod.property.declaration") == "#d6deeb", "declared fields use VS Code field color")
check(hex("BufferLineBufferSelected") ~= "#000000", "bufferline groups defined")
check(hex("BufferLineErrorSelected") == hex("BufferLineBufferSelected"), "tab name keeps its color with errors")
check(hex("BufferLineErrorDiagnosticSelected") == "#ef5350", "error count is red")

-- background switching keeps the family
vim.cmd.colorscheme("winteriscoming-black")
vim.o.background = "light"
check(vim.g.colors_name == "winteriscoming-light", "bg=light switches to light, got " .. tostring(vim.g.colors_name))
vim.o.background = "dark"
check(vim.g.colors_name == "winteriscoming-black", "bg=dark returns to black, got " .. tostring(vim.g.colors_name))

-- plain :colorscheme follows background
vim.cmd("hi clear")
vim.g.colors_name = nil
vim.o.background = "light"
vim.cmd.colorscheme("winteriscoming")
check(vim.g.colors_name == "winteriscoming-light", "plain colorscheme on light bg")
vim.o.background = "dark"
vim.cmd.colorscheme("winteriscoming")
check(vim.g.colors_name == "winteriscoming-blue", "plain colorscheme on dark bg -> " .. tostring(vim.g.colors_name))

-- italics = false removes every italic the theme sets. Only the theme's own
-- groups are checked: Neovim adds built-in groups over time (BoldItalic came
-- in 0.12), and plugins define their own, so a scan of every group breaks
-- whenever Neovim changes.
wic.setup({ cache = false, plugins = { all = true }, italics = false })
vim.cmd.colorscheme("winteriscoming-blue")
local _, owned = require("winteriscoming.theme").setup({ style = "blue" })
local italic = {}
for name in pairs(owned) do
  if vim.api.nvim_get_hl(0, { name = name, link = false }).italic then
    italic[#italic + 1] = name
  end
end
table.sort(italic)
check(#italic == 0, "italics=false left italics: " .. table.concat(italic, ", "))
check(not vim.api.nvim_get_hl(0, { name = "Comment", link = false }).italic, "italics=false: comments upright")
check(not vim.api.nvim_get_hl(0, { name = "@keyword", link = false }).italic, "italics=false: keywords upright")

-- transparent
wic.setup({ cache = false, transparent = true })
vim.cmd.colorscheme("winteriscoming-blue")
check(vim.api.nvim_get_hl(0, { name = "Normal" }).bg == nil, "transparent Normal has no bg")

-- cache round trip
local Util = require("winteriscoming.util")
Util.cache.clear()
wic.setup({ cache = true })
vim.cmd.colorscheme("winteriscoming-blue")
local first = vim.api.nvim_get_hl(0, { name = "@function" })
vim.cmd.colorscheme("winteriscoming-blue")
check(vim.deep_equal(first, vim.api.nvim_get_hl(0, { name = "@function" })), "cache round trip")
Util.cache.clear()

-- overrides
wic.setup({
  cache = false,
  on_colors = function(c)
    c.ice = "#ff0000"
  end,
  on_highlights = function(hl, c)
    hl.Comment = { fg = c.ice }
  end,
})
vim.cmd.colorscheme("winteriscoming-blue")
check(vim.api.nvim_get_hl(0, { name = "Comment" }).fg == 0xff0000, "on_colors/on_highlights")

-- lualine theme loads
for _, s in ipairs({ "", "-blue", "-black", "-light" }) do
  local ok, t = pcall(require, "lualine.themes.winteriscoming" .. s)
  check(ok and t.normal and t.normal.a.bg, "lualine theme winteriscoming" .. s)
end

if fails > 0 then
  io.stderr:write(fails .. " failures\n")
  os.exit(1)
end
print("all smoke tests passed")

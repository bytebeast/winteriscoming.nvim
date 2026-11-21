-- Generates terminal / tool themes into ./extras from the same palette.
-- Run from the repo root:
--   nvim --headless --clean -u NONE --cmd "set rtp^=." -l lua/winteriscoming/extra/init.lua
local Util = require("winteriscoming.util")

local M = {}

-- name -> {
--   ext       file extension ("" for none)
--   variants  optional { [suffix] = variant }: one extra file per style and
--             variant, named winteriscoming_<style><suffix>.<ext>
--   per_style false when the extra only writes the files from its `static()`
--             (yazi flavor folders, vim colorschemes)
-- }
-- stylua: ignore
M.extras = {
  alacritty  = { ext = "toml" },
  bat        = { ext = "tmTheme" },
  btop       = { ext = "theme" },
  delta      = { ext = "gitconfig" },
  eza        = { ext = "yml" },
  fish       = { ext = "theme" },
  foot       = { ext = "ini" },
  fzf        = { ext = "sh" },
  ghostty    = { ext = "" },
  helix      = { ext = "toml" },
  iterm      = { ext = "itermcolors" },
  k9s        = { ext = "yaml", variants = { [""] = "default", ["_transparent"] = "transparent" } },
  kitty      = { ext = "conf" },
  lazygit    = { ext = "yml" },
  st         = { ext = "txt" },
  termux     = { ext = "properties" },
  tmux       = { ext = "tmux" },
  vim        = { ext = "vim", per_style = false },
  wezterm    = { ext = "toml" },
  windows_terminal = { ext = "json" },
  xresources = { ext = "Xresources" },
  yazi       = { ext = "toml", per_style = false },
  zathura    = { ext = "zathurarc" },
  zed        = { ext = "json" },
  zellij     = { ext = "kdl" },
  zettlr     = { ext = "css" },
}

M.styles = { blue = "Dark Blue", black = "Dark Black", light = "Light" }

M.root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:h:h:h")

--- Colors for one style, with the metadata generators print in headers.
---@param style winteriscoming.Style
---@return winteriscoming.ColorScheme
function M.colors(style)
  local colors, opts = require("winteriscoming.colors").setup({ style = style, cache = false })
  colors._name = "winteriscoming_" .. style
  colors._style_name = "Winter is Coming " .. M.styles[style]
  colors._upstream_url = "https://github.com/johnpapa/vscode-winteriscoming"
  colors._styles = opts.styles -- italic/bold choices, for extras that support them
  return colors
end

--- The 16 terminal colors in ANSI order (0-7 normal, 8-15 bright).
---@param c winteriscoming.ColorScheme
---@return string[]
function M.ansi(c)
  local t = c.terminal
  -- stylua: ignore
  return {
    t.black, t.red, t.green, t.yellow, t.blue, t.magenta, t.cyan, t.white,
    t.black_bright, t.red_bright, t.green_bright, t.yellow_bright,
    t.blue_bright, t.magenta_bright, t.cyan_bright, t.white_bright,
  }
end

---@param name string
---@param style winteriscoming.Style
---@param variant? string one of the extra's variants (default: "default")
---@return string
function M.render(name, style, variant)
  return require("winteriscoming.extra." .. name).generate(M.colors(style), variant or "default")
end

--- Every file an extra writes, relative to the repo root -> content.
---@param name string
---@return table<string, string>
function M.files(name)
  local info = M.extras[name]
  local gen = require("winteriscoming.extra." .. name)
  local out = {}
  if info.per_style ~= false then
    for style in pairs(M.styles) do
      for suffix, variant in pairs(info.variants or { [""] = "default" }) do
        local file = "winteriscoming_" .. style .. suffix .. (info.ext ~= "" and ("." .. info.ext) or "")
        out["extras/" .. name .. "/" .. file] = gen.generate(M.colors(style), variant)
      end
    end
  end
  for path, content in pairs(gen.static and gen.static() or {}) do
    out["extras/" .. name .. "/" .. path] = content
  end
  return out
end

function M.setup()
  for name in pairs(M.extras) do
    for path, content in pairs(M.files(name)) do
      Util.write(M.root .. "/" .. path, content)
      print("wrote " .. path)
    end
  end
end

-- only when run as a script, so tests can require this module
if arg and arg[0] and arg[0]:find("extra/init%.lua$") and not package.loaded["winteriscoming.extra"] then
  package.loaded["winteriscoming.extra"] = M -- generators require this module
  M.setup()
end

return M

-- Generates terminal / tool themes into ./extras from the same palette.
-- Run from the repo root:
--   nvim --headless --clean -u NONE --cmd "set rtp^=." -l lua/winteriscoming/extra/init.lua
local Util = require("winteriscoming.util")

local M = {}

-- stylua: ignore
M.extras = {
  kitty     = { ext = "conf" },
  ghostty   = { ext = "" },
  alacritty = { ext = "toml" },
  wezterm   = { ext = "toml" },
  fzf       = { ext = "sh" },
  tmux      = { ext = "tmux" },
  lazygit   = { ext = "yml" },
  bat       = { ext = "tmTheme" },
  delta     = { ext = "gitconfig" },
  windows_terminal = { ext = "json" },
  iterm     = { ext = "itermcolors" },
}

M.styles = { blue = "Dark Blue", black = "Dark Black", light = "Light" }

function M.setup()
  local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:h:h:h")
  for extra, info in pairs(M.extras) do
    local plugin = require("winteriscoming.extra." .. extra)
    for style, style_name in pairs(M.styles) do
      local colors = require("winteriscoming.colors").setup({ style = style, cache = false })
      colors._name = "winteriscoming_" .. style
      colors._style_name = "Winter is Coming " .. style_name
      colors._upstream_url = "https://github.com/johnpapa/vscode-winteriscoming"
      local fname = colors._name .. (info.ext ~= "" and ("." .. info.ext) or "")
      local out = root .. "/extras/" .. extra .. "/" .. fname
      Util.write(out, plugin.generate(colors))
      print("wrote " .. out:sub(#root + 2))
    end
  end
end

M.setup()

return M

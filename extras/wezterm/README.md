# winteriscoming for WezTerm

[winteriscoming.nvim](../../README.md) theme for [WezTerm](https://wezterm.org), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

WezTerm loads color schemes from the `colors` folder next to its config:

```sh
mkdir -p ~/.config/wezterm/colors
curl -fsSL -o ~/.config/wezterm/colors/winteriscoming_blue.toml \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/wezterm/winteriscoming_blue.toml
```

Then in `wezterm.lua`:

```lua
config.color_scheme = "Winter is Coming Dark Blue"
```

To follow your system's light and dark mode, download `winteriscoming_light.toml` too:

```lua
local function scheme(appearance)
  return appearance:find("Dark") and "Winter is Coming Dark Blue" or "Winter is Coming Light"
end
config.color_scheme = scheme(wezterm.gui and wezterm.gui.get_appearance() or "Dark")
```

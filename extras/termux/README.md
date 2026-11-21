# winteriscoming for Termux

[winteriscoming.nvim](../../README.md) theme for [Termux](https://termux.dev), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.termux
curl -fsSL -o ~/.termux/colors.properties \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/termux/winteriscoming_blue.properties
termux-reload-settings
```

This replaces any colors you set before, including ones chosen with Termux:Styling.

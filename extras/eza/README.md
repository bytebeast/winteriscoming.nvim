# winteriscoming for eza

[winteriscoming.nvim](../../README.md) theme for [eza](https://eza.rocks), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

eza reads a single `theme.yml` from its config directory:

```sh
# Linux; on macOS use "$HOME/Library/Application Support/eza" instead
mkdir -p ~/.config/eza
curl -fsSL -o ~/.config/eza/theme.yml \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/eza/winteriscoming_blue.yml
```

To keep it somewhere else, set `EZA_CONFIG_DIR` to the folder that holds `theme.yml`. `LS_COLORS` and `EZA_COLORS` take priority over `theme.yml`, so if your shell sets `LS_COLORS` (via `dircolors` or `vivid`, say), run eza without it: `alias ls='LS_COLORS= eza'`.

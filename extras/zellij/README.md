# winteriscoming for Zellij

[winteriscoming.nvim](../../README.md) theme for [Zellij](https://zellij.dev), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Needs Zellij 0.42 or newer (the files use its named-style theme format).

```sh
mkdir -p ~/.config/zellij/themes
curl -fsSL -o ~/.config/zellij/themes/winteriscoming_blue.kdl \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/zellij/winteriscoming_blue.kdl
```

Then in `~/.config/zellij/config.kdl`:

```kdl
theme "winteriscoming_blue"
```

Zellij 0.44.2+ can follow your terminal's light and dark mode: download `winteriscoming_light.kdl` too and set both:

```kdl
theme_dark "winteriscoming_blue"
theme_light "winteriscoming_light"
```

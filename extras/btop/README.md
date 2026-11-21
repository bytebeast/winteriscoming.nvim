# winteriscoming for btop

[winteriscoming.nvim](../../README.md) theme for [btop](https://github.com/aristocratos/btop), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

btop looks for user themes in `$XDG_CONFIG_HOME/btop/themes`, which is usually `~/.config/btop/themes`:

```sh
mkdir -p ~/.config/btop/themes
curl -fsSL -o ~/.config/btop/themes/winteriscoming_blue.theme \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/btop/winteriscoming_blue.theme
```

Then in `~/.config/btop/btop.conf`:

```sh
color_theme = "winteriscoming_blue"
```

Or pick it from the options menu (`o` or `F2`) under color theme.

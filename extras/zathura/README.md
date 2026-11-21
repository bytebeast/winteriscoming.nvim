# winteriscoming for zathura

[winteriscoming.nvim](../../README.md) theme for [zathura](https://pwmt.org/projects/zathura/), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.config/zathura
curl -fsSL -o ~/.config/zathura/winteriscoming_blue.zathurarc \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/zathura/winteriscoming_blue.zathurarc
```

Then in `~/.config/zathura/zathurarc` (relative paths resolve from that file):

```sh
include winteriscoming_blue.zathurarc
```

The theme colors zathura's interface. To render pages in the theme's colors too, press `Ctrl+r` or add `set recolor true`.

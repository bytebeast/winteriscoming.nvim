# winteriscoming for foot

[winteriscoming.nvim](../../README.md) theme for [foot](https://codeberg.org/dnkl/foot), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Needs foot 1.26 or newer (the files use its `[colors-dark]` and `[colors-light]` sections).

```sh
mkdir -p ~/.config/foot
curl -fsSL -o ~/.config/foot/winteriscoming_blue.ini \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/foot/winteriscoming_blue.ini
```

Then at the top of `~/.config/foot/foot.ini`, before any section header:

```ini
include=~/.config/foot/winteriscoming_blue.ini
```

`light` fills `[colors-light]`. To use it, add `initial-color-theme=light` under `[main]`. Include a dark style and `light` together to switch between them with foot's `color-theme-toggle` key binding.

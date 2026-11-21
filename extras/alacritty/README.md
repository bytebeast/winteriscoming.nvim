# winteriscoming for Alacritty

[winteriscoming.nvim](../../README.md) theme for [Alacritty](https://alacritty.org), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.config/alacritty
curl -fsSL -o ~/.config/alacritty/winteriscoming_blue.toml \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/alacritty/winteriscoming_blue.toml
```

Then in `alacritty.toml`:

```toml
[general]
import = ["~/.config/alacritty/winteriscoming_blue.toml"]
```

Alacritty before 0.14 reads `import` at the top level instead of under `[general]`.

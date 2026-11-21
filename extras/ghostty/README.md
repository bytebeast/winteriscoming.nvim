# winteriscoming for Ghostty

[winteriscoming.nvim](../../README.md) theme for [Ghostty](https://ghostty.org), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.config/ghostty/themes
curl -fsSL -o ~/.config/ghostty/themes/winteriscoming_blue \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/ghostty/winteriscoming_blue
```

Then in Ghostty's config:

```ini
theme = winteriscoming_blue
```

To follow your system's light and dark mode, download `winteriscoming_light` too and use:

```ini
theme = light:winteriscoming_light,dark:winteriscoming_blue
```

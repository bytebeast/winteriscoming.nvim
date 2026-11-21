# winteriscoming for bat

[winteriscoming.nvim](../../README.md) theme for [bat](https://github.com/sharkdp/bat), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

The theme is built from the same syntax roles as the Neovim theme, so code in `bat` is colored the way it is in your editor. bat names a theme after its file.

```sh
mkdir -p "$(bat --config-dir)/themes"
curl -fsSL -o "$(bat --config-dir)/themes/winteriscoming_blue.tmTheme" \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/bat/winteriscoming_blue.tmTheme
bat cache --build
bat --list-themes | grep winteriscoming
```

Then in bat's config file (`bat --config-file` prints where it is):

```sh
--theme="winteriscoming_blue"
--italic-text=always   # bat turns italics off by default; winteriscoming italicizes comments and keywords
```

bat 0.25+ can switch with your terminal's light/dark mode instead: download `winteriscoming_light.tmTheme` too, then use `--theme-light="winteriscoming_light"` and `--theme-dark="winteriscoming_blue"` in place of `--theme`.

## Sublime Text

The same `.tmTheme` files are Sublime Text color schemes. Copy one into Sublime's `Packages/User` folder (**Preferences → Browse Packages…** opens it), then pick it with **UI: Select Color Scheme** in the command palette.

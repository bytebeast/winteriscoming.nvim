# winteriscoming for kitty

[winteriscoming.nvim](../../README.md) theme for [kitty](https://sw.kovidgoyal.net/kitty/), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Put the file in kitty's `themes` folder so the theme kitten lists it:

```sh
mkdir -p ~/.config/kitty/themes
curl -fsSL -o ~/.config/kitty/themes/winteriscoming_blue.conf \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/kitty/winteriscoming_blue.conf
```

Then run `kitten themes` and pick **Winter is Coming Dark Blue**. kitty 0.38+ asks at the end whether to save it for dark, light or no-preference mode, so you can pair `blue` (or `black`) with `light` and follow your OS.

Or skip the kitten and include the file from `kitty.conf`:

```sh
include themes/winteriscoming_blue.conf
```

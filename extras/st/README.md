# winteriscoming for st

[winteriscoming.nvim](../../README.md) theme for [st](https://st.suckless.org), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

st is configured at compile time. Each file holds st's `colorname[]` array and the four `default*` lines that pick the foreground, background and cursor colors.

```sh
curl -fsSL -o winteriscoming_blue.txt \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/st/winteriscoming_blue.txt
```

In st's `config.h`, replace `colorname[]` and the `defaultfg`, `defaultbg`, `defaultcs` and `defaultrcs` lines with the file's contents (or `#include "winteriscoming_blue.txt"` in their place), then rebuild:

```sh
sudo make clean install
```

Patches that change `colorname[]` (alpha, xresources) may need these values moved into their own format.

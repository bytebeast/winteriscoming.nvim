# winteriscoming for Xresources

[winteriscoming.nvim](../../README.md) theme for X terminals that read X resources (xterm, URxvt and others), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.config/xresources
curl -fsSL -o ~/.config/xresources/winteriscoming_blue.Xresources \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/xresources/winteriscoming_blue.Xresources
xrdb -merge ~/.config/xresources/winteriscoming_blue.Xresources
```

To load it at every login, include it from `~/.Xresources` (xrdb runs it through the C preprocessor, so `#include` works):

```c
#include ".config/xresources/winteriscoming_blue.Xresources"
```

Terminals pick up the colors when they start, so open a new window.

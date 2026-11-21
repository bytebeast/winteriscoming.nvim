# winteriscoming for tmux

[winteriscoming.nvim](../../README.md) theme for [tmux](https://github.com/tmux/tmux), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

The theme styles panes, messages, copy mode and the status line, including `status-left` and `status-right`. Remove other status line themes first, or source this file after them.

```sh
mkdir -p ~/.config/tmux
curl -fsSL -o ~/.config/tmux/winteriscoming_blue.tmux \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/tmux/winteriscoming_blue.tmux
```

Then in `~/.tmux.conf` (or `~/.config/tmux/tmux.conf`):

```sh
source-file ~/.config/tmux/winteriscoming_blue.tmux
# colored undercurls and underlines in Neovim (tmux 3.2+)
set -as terminal-features ",*:usstyle"
```

Reload with `tmux source-file ~/.tmux.conf`.

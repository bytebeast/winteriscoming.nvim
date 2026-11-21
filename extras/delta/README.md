# winteriscoming for delta

[winteriscoming.nvim](../../README.md) theme for [delta](https://github.com/dandavison/delta), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Each file defines a delta feature named after its style (`winteriscoming_blue` here). delta takes its syntax colors from the [bat theme](../bat/README.md), so install that first.

```sh
mkdir -p ~/.config/delta
curl -fsSL -o ~/.config/delta/winteriscoming_blue.gitconfig \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/delta/winteriscoming_blue.gitconfig
```

Then in `~/.gitconfig`:

```gitconfig
[include]
  path = ~/.config/delta/winteriscoming_blue.gitconfig
[core]
  pager = delta
[delta]
  features = winteriscoming_blue
```

To switch styles quickly, include several files and change only `features`.

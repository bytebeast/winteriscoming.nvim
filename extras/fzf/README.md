# winteriscoming for fzf

[winteriscoming.nvim](../../README.md) theme for [fzf](https://github.com/junegunn/fzf), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Needs fzf 0.52 or newer (the files use `--highlight-line`). Each file appends to `FZF_DEFAULT_OPTS`, for bash and zsh.

```sh
mkdir -p ~/.config/fzf
curl -fsSL -o ~/.config/fzf/winteriscoming_blue.sh \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/fzf/winteriscoming_blue.sh
```

Then in `~/.bashrc` or `~/.zshrc`, after anything else that sets `FZF_DEFAULT_OPTS`:

```sh
source ~/.config/fzf/winteriscoming_blue.sh
```

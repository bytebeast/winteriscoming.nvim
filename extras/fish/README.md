# winteriscoming for fish

[winteriscoming.nvim](../../README.md) theme for [fish](https://fishshell.com), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Needs fish 3.4 or newer.

```sh
mkdir -p ~/.config/fish/themes
curl -fsSL -o ~/.config/fish/themes/winteriscoming_blue.theme \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/fish/winteriscoming_blue.theme
```

Try it in the current shell:

```fish
fish_config theme choose winteriscoming_blue
```

To keep it, put that line in `~/.config/fish/config.fish`. `fish_config theme save winteriscoming_blue` also works, but stores the colors as universal variables instead.

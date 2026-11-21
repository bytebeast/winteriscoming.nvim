# winteriscoming for Vim

[winteriscoming.nvim](../../README.md) theme for classic [Vim](https://www.vim.org), generated from the same palettes as the Neovim colorscheme.

There's a colorscheme for each of the three styles, named like the Neovim ones: `winteriscoming-blue`, `winteriscoming-black` and `winteriscoming-light`. The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Needs Vim 8.2+ with `termguicolors` (or gVim): the colorschemes set GUI colors only. They cover Vim's built-in and syntax groups and `:terminal`; Neovim keeps using the Lua colorscheme.

With [vim-plug](https://github.com/junegunn/vim-plug), load `extras/vim` as the plugin's runtime path:

```vim
Plug 'bytebeast/winteriscoming.nvim', { 'rtp': 'extras/vim' }
```

Or copy a colorscheme into your colors folder:

```sh
mkdir -p ~/.vim/colors   # Windows: ~/vimfiles/colors
curl -fsSL -o ~/.vim/colors/winteriscoming-blue.vim \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/vim/colors/winteriscoming-blue.vim
```

Then in your `vimrc`:

```vim
set termguicolors
colorscheme winteriscoming-blue
```

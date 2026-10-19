# Changelog

## 1.0.0 (2026-10-19)

First release.

- Three styles from the VS Code theme: `winteriscoming-blue` (Dark Blue),
  `winteriscoming-black` (Dark Black) and `winteriscoming-light`, plus
  `winteriscoming`, which follows `'background'`.
- Treesitter and LSP semantic token highlights, including VS Code's split
  between declared fields and accessed properties.
- 55+ plugin integrations, enabled automatically for the plugins lazy.nvim has
  installed; bufferline with the VS Code tab look.
- Comments and keywords italic by default; per-category `styles` plus `italics`
  / `bold` master switches.
- Colors tuned for terminals (functions, variables, constants, comments,
  docstrings); `faithful = true` restores the exact VS Code values.
- Lualine theme and extras for alacritty, bat, delta, fzf, ghostty, iTerm2,
  kitty, lazygit, tmux, Windows Terminal and wezterm.
- `:h winteriscoming`, lua-language-server types, CI on Neovim stable and
  nightly.

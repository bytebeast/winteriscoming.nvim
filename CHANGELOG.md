# Changelog

## v1.2.1 (2026-11-21)

### Bug Fixes

- **folds**: keep folded lines apart from changed lines in diffs

## v1.2.0 (2026-11-21)

### Features

- **diff**: underline changed and added text inside changed lines

### Documentation

- stock LazyVim example, font guide and per-extra setup guides

## v1.1.0 (2026-11-21)

### Features

- **initial**: initial commit (AH-2026101959530)
- **preview**: initial add of social-preview (AH-2026101961075)
- **italic**: fix italic (AH-2026101965921)
- port kissaten options, integrations and extras

### Bug Fixes

- **tests**: update smoke.lua (AH-2026101970264)
- **theme**: background switch, bufferline icons, grug-far groups

### Documentation

- **readme**: add palette sheet, style and plugin screenshots
- add Pages site and document the new options

<!-- also in this release: ci, test -->

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

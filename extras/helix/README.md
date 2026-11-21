# winteriscoming for Helix

[winteriscoming.nvim](../../README.md) theme for [Helix](https://helix-editor.com), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.config/helix/themes   # Windows: %AppData%\helix\themes
curl -fsSL -o ~/.config/helix/themes/winteriscoming_blue.toml \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/helix/winteriscoming_blue.toml
```

Try it with `:theme winteriscoming_blue`, then set it at the top of `~/.config/helix/config.toml`:

```toml
theme = "winteriscoming_blue"
```

To follow your terminal's light and dark mode, download `winteriscoming_light.toml` too and use a `[theme]` table instead:

```toml
[theme]
dark = "winteriscoming_blue"
light = "winteriscoming_light"
```

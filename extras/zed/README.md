# winteriscoming for Zed

[winteriscoming.nvim](../../README.md) theme for [Zed](https://zed.dev), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.config/zed/themes   # Windows: %USERPROFILE%\AppData\Roaming\Zed\themes
curl -fsSL -o ~/.config/zed/themes/winteriscoming_blue.json \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/zed/winteriscoming_blue.json
```

Pick **Winter is Coming Dark Blue** in the theme selector (`cmd-k cmd-t`, or `ctrl-k ctrl-t` on Linux and Windows). To follow your system's light and dark mode, download `winteriscoming_light.json` too and set it in `settings.json`:

```json
"theme": {
  "mode": "system",
  "light": "Winter is Coming Light",
  "dark": "Winter is Coming Dark Blue"
}
```

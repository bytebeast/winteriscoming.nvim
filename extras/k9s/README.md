# winteriscoming for k9s

[winteriscoming.nvim](../../README.md) theme for [k9s](https://k9scli.io), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Each style also comes as a `_transparent` skin that keeps your terminal's background.

```sh
# Linux; on macOS use "$HOME/Library/Application Support/k9s/skins". `k9s info` prints the right path.
OUT="${XDG_CONFIG_HOME:-$HOME/.config}/k9s/skins"
mkdir -p "$OUT"
curl -fsSL -o "$OUT/winteriscoming_blue.yaml" \
  https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/k9s/winteriscoming_blue.yaml
```

Then in k9s's `config.yaml`:

```yaml
k9s:
  ui:
    skin: winteriscoming_blue   # or winteriscoming_blue_transparent
```

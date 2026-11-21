# winteriscoming for Yazi

[winteriscoming.nvim](../../README.md) theme for [Yazi](https://yazi-rs.github.io), generated from the same palettes as the Neovim colorscheme.

Each style is a Yazi flavor folder: `winteriscoming-blue.yazi`, `winteriscoming-black.yazi` and `winteriscoming-light.yazi`. The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Needs Yazi 0.4 or newer. Each flavor has a `flavor.toml` and a `tmtheme.xml` (the [bat theme](../bat/README.md), so previews color code like Neovim does).

```sh
dir=~/.config/yazi/flavors/winteriscoming-blue.yazi
mkdir -p "$dir"
for f in flavor.toml tmtheme.xml; do
  curl -fsSL -o "$dir/$f" https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/yazi/winteriscoming-blue.yazi/$f
done
```

Then in `~/.config/yazi/theme.toml`. Yazi picks `light` or `dark` from your terminal's background, so set both (download `winteriscoming-light.yazi` the same way):

```toml
[flavor]
dark = "winteriscoming-blue"
light = "winteriscoming-light"
```

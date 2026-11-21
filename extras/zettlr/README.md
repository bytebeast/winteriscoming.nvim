# winteriscoming for Zettlr

[winteriscoming.nvim](../../README.md) theme for [Zettlr](https://www.zettlr.com), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Zettlr takes a single Custom CSS. Each file applies in one Zettlr mode only (`light` in light mode, the others in dark mode), so paste a light and a dark file together to follow Zettlr's dark-mode switch:

```sh
base=https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/zettlr
curl -fsSL "$base/winteriscoming_light.css" "$base/winteriscoming_blue.css" | pbcopy   # Linux: | xclip -selection clipboard
```

Open **Zettlr → Assets Manager** (macOS) or **File → Preferences → Assets Manager** (Windows/Linux), choose **Custom CSS**, paste and save. It themes the editor, code blocks, file manager, toolbar, tabs and status bar, and sets Zettlr's accent color to winter blue (the CSS marks the two lines to delete if you'd rather keep your OS accent).


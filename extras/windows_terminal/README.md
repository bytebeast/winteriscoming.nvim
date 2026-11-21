# winteriscoming for Windows Terminal

[winteriscoming.nvim](../../README.md) theme for [Windows Terminal](https://github.com/microsoft/terminal), generated from the same palettes as the Neovim colorscheme.

Every file comes in all three styles (`winteriscoming_blue`, `winteriscoming_black`, `winteriscoming_light`). The examples use `blue`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Each file is one color scheme object.

1. Open **Settings**, then **Open JSON file** at the bottom left.
2. Paste the contents of [`winteriscoming_blue.json`](https://raw.githubusercontent.com/bytebeast/winteriscoming.nvim/main/extras/windows_terminal/winteriscoming_blue.json) into the `"schemes"` array (add a comma after the previous scheme).
3. Use it for every profile:

```json
"profiles": {
  "defaults": {
    "colorScheme": "Winter is Coming Dark Blue"
  }
}
```

Or pick **Winter is Coming Dark Blue** under a profile's **Appearance → Color scheme**.

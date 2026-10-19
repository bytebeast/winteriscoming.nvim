-- Winter is Coming (Dark Black)
-- Same syntax palette as Dark Blue, on the charcoal background of the VS Code
-- "Dark Black" variant. VS Code kept navy tabs and widgets on top of the
-- charcoal; here the chrome is derived from the charcoal instead so the UI
-- reads as one surface, while selections keep the navy accent.

local p = vim.deepcopy(require("winteriscoming.colors.blue"))

p.bg = "#282822" -- editor.background
p.bg_dark = "#1f1f1a" -- [ext]
p.bg_darker = "#171713" -- [ext]
p.bg_widget = "#33332c" -- [ext]
p.bg_input = "#2e2e2a" -- editorInlayHint.background
p.bg_inlay = "#2e2e2a" -- editorInlayHint.background
p.bg_select = "#4f4f4f" -- statusBarItem.activeBackground
p.fg_gutter = "#3b3a32" -- editorWhitespace.foreground
p.dark3 = "#4f4e44" -- [ext]
p.border = "#3a3a32" -- [ext]
-- VS Code kept the navy #103362 selection, which turns muddy on charcoal.
-- These keep the winter-blue tint but sit in the charcoal's value range.
p.bg_visual = "#2a4258" -- [ext]
p.bg_highlight = "#303331" -- [ext]
p.vscode.ui = { bg_visual = "#103362" }

p.violet = "#ad80d4" -- [ext] constants: lifted to stay readable on charcoal

p.terminal.black = "#282822"

return p

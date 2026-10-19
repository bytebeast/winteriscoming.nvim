-- Winter is Coming (Light)
-- The VS Code light variant is not an inverted dark theme: strings turn plum,
-- functions magenta and comments green. This palette follows those choices.
-- A few original colors were darkened slightly (`[adj]`) so they reach a
-- readable contrast on white; `[ext]` marks colors added for Neovim.

---@type winteriscoming.Palette
local p = {
  bg = "#ffffff", -- editor.background
  bg_dark = "#f3f3f3", -- sideBar.background
  bg_darker = "#e8e8e8", -- [ext]
  bg_highlight = "#eff2ef", -- editor.lineHighlightBackground
  bg_widget = "#e3e3e3", -- peekViewEditor.background
  bg_input = "#eeeeee", -- input.background
  bg_visual = "#cee1f0", -- editor.selectionBackground
  bg_inlay = "#ddeef7", -- editorInlayHint.background
  bg_select = "#cccccc", -- list.focusBackground

  fg = "#002339", -- default token foreground
  fg_light = "#3e3e3e", -- punctuation
  fg_bright = "#011627", -- notifications.foreground
  fg_dark = "#37567c", -- sideBarSectionHeader.foreground
  fg_muted = "#5f7e97", -- input.placeholderForeground
  fg_gutter = "#dde3e7", -- [ext] indent guides (#eff2ef is invisible next to the cursorline)
  comment = "#357b42", -- comment
  comment_vscode = "#357b42",
  dark3 = "#b4b6c0", -- [adj] editorWhitespace.foreground
  dark5 = "#7a9eb8", -- editorInlayHint.foreground
  border = "#d4d4d4", -- [ext]

  blue = "#2f86d2", -- statusBar.background / line numbers / focusBorder
  blue_deep = "#1857a4", -- gitDecoration.modifiedResourceForeground
  ice = "#0784a6", -- [adj] keywords (#0991b6)
  sky = "#207bb8", -- lists, links
  azure = "#2970c7", -- built-in constants
  frost = "#236ebf", -- editor.foreground
  periwinkle = "#236ebf",
  steel = "#4a668f", -- method declarations
  glacier = "#2f86d2",
  mist = "#6b6b6b",
  slate = "#4a668f",
  cyan = "#0097a7", -- terminal cyan
  bold_blue = "#4e76b5", -- markdown bold

  lavender = "#7c2cbd", -- TypeScript classes
  purple = "#7b30d0", -- operators
  violet = "#87429a", -- markdown links
  indigo = "#7e57c2",
  magenta = "#b1108e", -- functions
  pink = "#c42fa4", -- [adj] library types (#dc3eb7)
  rose = "#ae408b", -- JSON null
  plum = "#a44185", -- strings

  cream = "#b05f0a", -- [adj] properties (#fa841d)
  gold = "#a8861c", -- [adj] terminal yellow (#c5a332)
  amber = "#9a6a00", -- [ext] warnings
  ember = "#da5221", -- storage

  mint = "#a44185", -- strings are plum in the light theme
  green = "#07805e", -- [adj] terminal green (#08916a)
  green_bright = "#22863a", -- markup.inserted
  lime = "#497803", -- JSON constants
  moss = "#296d31", -- module imports & exports
  teal = "#2f7d70", -- [adj] support.variable.property (#358a7b)
  aqua = "#00808d", -- [adj] terminal bright cyan
  jade = "#2f8574", -- [adj] JSON property names (#3a9685)
  seafoam = "#3a9685",
  pale = "#296d31",

  red = "#de3d3b", -- terminal red
  red_light = "#f76c6c",
  coral = "#b31d28", -- markup.deleted

  git = {
    add = "#22863a",
    change = "#1857a4",
    delete = "#b31d28",
    untracked = "#189b2c",
  },

  terminal = {
    black = "#011627",
    red = "#de3d3b",
    green = "#08916a",
    yellow = "#c5a332",
    blue = "#236ebf",
    magenta = "#7c4dff",
    cyan = "#0097a7",
    white = "#7e8993",
    black_bright = "#403f53",
    red_bright = "#f76c6c",
    green_bright = "#49d0b0",
    yellow_bright = "#e7c244",
    blue_bright = "#4e8cdf",
    magenta_bright = "#b15a91",
    cyan_bright = "#00bcd4",
    white_bright = "#403f53",
  },
}

p.syntax = {
  comment = "comment",
  keyword = "ice",
  operator = "purple",
  storage = "ember",
  builtin_var = "ice",
  func = "magenta",
  method = "magenta",
  func_builtin = "#08134a",
  constructor = "lavender",
  param = "#6b6b6b", -- parameters render grey like variables in the original
  variable = "#6b6b6b", -- [adj] variable.other.readwrite (#828282)
  property = "cream",
  field_decl = "#6b6b6b", -- declared class fields
  field = "teal",
  type = "#0444ac",
  type_builtin = "pink",
  inherited = "#b02767",
  string = "plum",
  docstring = "#885678", -- [ext] plum toward grey
  escape = "#b8418f", -- [adj] string quotes (#d86db6)
  regexp = "#00866f", -- [adj] (#00ac8f)
  template = "#a828b5", -- [adj] (#c63ed3)
  number = "#174781",
  boolean = "#174781",
  constant = "azure",
  constant_builtin = "azure",
  attribute = "#a85f08", -- [adj] (#df8618)
  tag = "#0444ac",
  tag_attribute = "#a85f08",
  punctuation = "fg_light",
  delimiter = "purple",
  module = "moss",
  label = "#b02767",
  json_key = "jade",
  heading = "#034c7c",
  md_bold = "bold_blue",
  md_italic = "purple",
  md_code = "#0460b1",
  md_link = "#924205",
  md_link_text = "violet",
  md_quote = "#003494",
  md_list = "sky",
  md_inserted = "green_bright",
  md_deleted = "coral",
}

p.vscode = { syntax = { variable = "#828282", param = "#828282", docstring = "plum" } }

return p

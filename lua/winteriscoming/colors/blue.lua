-- Winter is Coming (Dark Blue)
-- The signature variant. Every color below is taken from the VS Code theme by
-- John Papa (https://github.com/johnpapa/vscode-winteriscoming) unless it is
-- marked `[ext]`, which means it was added to cover what Neovim needs and the
-- original never defined (an orange, extra UI shades, etc.).

---@type winteriscoming.Palette
local p = {
  -- Backgrounds ---------------------------------------------------------------
  bg = "#011627", -- editor.background
  bg_dark = "#010e1a", -- tab.inactiveBackground: sidebars, floats, statusline
  bg_darker = "#000a11", -- titleBar.inactiveBackground
  bg_highlight = "#042444", -- editor.lineHighlightBackground (#0c499444 over bg)
  bg_widget = "#0b2942", -- editorWidget.background / tab.activeBackground
  bg_input = "#0b253a", -- input.background
  bg_visual = "#103362", -- editor.selectionBackground
  bg_inlay = "#0d2137", -- editorInlayHint.background
  bg_select = "#03648a", -- list.focusBackground / statusBarItem.activeBackground

  -- Foregrounds ---------------------------------------------------------------
  fg = "#bce7ff", -- default token foreground
  fg_light = "#d6deeb", -- terminal.foreground / suggest widget text
  fg_bright = "#eeefff", -- titleBar.activeForeground
  fg_dark = "#7799bb", -- sideBar.foreground
  fg_muted = "#5f7e97", -- tab.inactiveForeground / input.placeholderForeground
  fg_gutter = "#0e2c45", -- editorIndentGuide.background
  comment = "#8a9db3", -- [ext] cool grey-blue at the contrast of the original #999999
  comment_vscode = "#999999", -- the original comment grey (see `faithful`)
  dark3 = "#2e4a62", -- [ext] non-text, whitespace (VS Code used a warm grey that clashes with navy)
  dark5 = "#4d8aa0", -- editorInlayHint.foreground
  border = "#122d42", -- contrastBorder

  -- Blues ---------------------------------------------------------------------
  blue = "#219fd5", -- statusBar / cursor / line numbers / focusBorder
  blue_deep = "#03648a", -- button.background
  ice = "#00bff9", -- keywords & operators
  sky = "#6dbdfa", -- storage, tags, lists, links
  azure = "#82aaff", -- user constants, markdown quotes
  frost = "#87aff4", -- function names in VS Code
  periwinkle = "#8fa2f8", -- [ext] function names: frost nudged away from the constant blue
  steel = "#92b6f4", -- built-in constants (null, undefined)
  glacier = "#a4ceee", -- variables in VS Code
  mist = "#b3c8d9", -- [ext] variables: glacier nudged greyer, away from keywords
  slate = "#a1bde6", -- method declarations
  cyan = "#4fb4d8", -- inherited classes, headings
  bold_blue = "#57cdff", -- markdown bold

  -- Purples & pinks -----------------------------------------------------------
  lavender = "#d29ffc", -- types & classes
  purple = "#c792ea", -- storage / italic markdown / active indent guide
  violet = "#a170c6", -- constants
  indigo = "#7e57c2", -- overview ruler / peek match highlight
  magenta = "#c63ed3", -- template expressions
  pink = "#ec9cd2", -- library constants
  rose = "#f3b8c2", -- markdown metadata
  plum = "#b15a91", -- statusBar.debuggingBackground

  -- Yellows & oranges ---------------------------------------------------------
  cream = "#f7ecb5", -- properties, attributes, decorators, library functions
  gold = "#ffcb6b", -- terminal bright yellow
  amber = "#ffca28", -- editorWarning.foreground
  ember = "#f78c6c", -- [ext] orange from the Night Owl lineage of this theme

  -- Greens & teals ------------------------------------------------------------
  mint = "#bcf0c0", -- strings
  green = "#8dec95", -- numbers & booleans
  green_bright = "#22da6e", -- terminal green
  lime = "#addb67", -- markup.inserted / JSON constants
  moss = "#78bd65", -- markdown link text
  teal = "#7fdbca", -- library types, instance variables
  aqua = "#80cbc4", -- terminal cyan / notification links
  jade = "#5abeb0", -- untracked files / markdown headings
  seafoam = "#91dacd", -- JSON property names
  pale = "#d3eed6", -- module imports & exports

  -- Reds ----------------------------------------------------------------------
  red = "#ef5350", -- editorError.foreground
  red_light = "#ef9a9a", -- terminal bright red
  coral = "#f97583", -- markup.deleted

  git = {
    add = "#addb67",
    change = "#219fd5", -- gitDecoration.modifiedResourceForeground
    delete = "#ef5350",
    untracked = "#5abeb0", -- gitDecoration.untrackedResourceForeground
  },

  -- terminal.ansi* from the VS Code theme
  terminal = {
    black = "#011627",
    red = "#ef5350",
    green = "#22da6e",
    yellow = "#f7ecb5",
    blue = "#219fd5",
    magenta = "#c792ea",
    cyan = "#80cbc4",
    white = "#d6deeb",
    black_bright = "#5f7e97",
    red_bright = "#ef9a9a",
    green_bright = "#addb67",
    yellow_bright = "#ffcb6b",
    blue_bright = "#82aaff",
    magenta_bright = "#c792ea",
    cyan_bright = "#7fdbca",
    white_bright = "#ffffff",
  },
}

-- Semantic syntax roles. The light variant maps these very differently, so
-- every highlight group refers to a role rather than to a hue directly.
p.syntax = {
  comment = "comment",
  keyword = "ice",
  operator = "ice",
  storage = "purple", -- modifiers, import/export, preprocessor
  builtin_var = "ice", -- this, self
  func = "periwinkle",
  method = "periwinkle",
  func_builtin = "cream",
  constructor = "lavender",
  param = "#d7dbe0",
  variable = "mist",
  property = "cream",
  field_decl = "fg_light", -- declared class fields (VS Code: #d6deeb)
  field = "teal", -- support.variable.property
  type = "lavender",
  type_builtin = "teal",
  inherited = "cyan",
  string = "mint",
  docstring = "#a3c7ba", -- [ext] mint toward the comment grey: prose, not data
  escape = "pink",
  regexp = "aqua",
  template = "magenta",
  number = "green",
  boolean = "green",
  constant = "violet", -- VS Code `constant`; azure sat right on top of functions
  constant_builtin = "steel",
  attribute = "cream",
  tag = "sky",
  tag_attribute = "cream",
  punctuation = "fg_light",
  delimiter = "ice",
  module = "pale",
  label = "cyan",
  json_key = "seafoam",
  -- markup
  heading = "jade",
  md_bold = "bold_blue",
  md_italic = "purple",
  md_code = "cream",
  md_link = "sky",
  md_link_text = "moss",
  md_quote = "azure",
  md_list = "sky",
  md_inserted = "lime",
  md_deleted = "coral",
}

-- Exact VS Code values for the roles this port adjusts (`faithful = true`)
p.vscode = {
  syntax = {
    func = "frost",
    method = "frost",
    variable = "glacier",
    constant = "azure",
    comment = "comment_vscode",
    docstring = "mint",
  },
}

return p

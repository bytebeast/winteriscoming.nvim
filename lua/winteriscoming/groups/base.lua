local Util = require("winteriscoming.util")

local M = {}

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  local s = c.syntax
  local bg = opts.transparent and c.none or c.bg

  -- stylua: ignore
  return {
    -- Editor UI ---------------------------------------------------------------
    Normal                      = { fg = c.fg, bg = bg },
    NormalNC                    = { fg = c.fg, bg = opts.transparent and c.none or opts.dim_inactive and c.bg_dark or c.bg },
    NormalSB                    = { fg = c.fg_sidebar, bg = c.bg_sidebar },
    NormalFloat                 = { fg = c.fg_float, bg = c.bg_float },
    FloatBorder                 = { fg = c.border_highlight, bg = c.bg_float },
    FloatTitle                  = { fg = c.blue, bg = c.bg_float, bold = true },
    FloatFooter                 = { fg = c.fg_muted, bg = c.bg_float },
    FloatShadow                 = { bg = c.black, blend = 80 },
    FloatShadowThrough          = { bg = c.black, blend = 100 },

    Cursor                      = { fg = c.bg, bg = c.blue },
    lCursor                     = { fg = c.bg, bg = c.blue },
    CursorIM                    = { fg = c.bg, bg = c.blue },
    TermCursor                  = { fg = c.bg, bg = c.blue },
    TermCursorNC                = { fg = c.bg, bg = c.fg_muted },
    CursorLine                  = { bg = c.bg_highlight },
    CursorColumn                = { bg = c.bg_highlight },
    ColorColumn                 = { bg = c.bg_dark },
    CursorLineNr                = { fg = c.line_nr_cursor, bold = true },
    LineNr                      = { fg = c.line_nr },
    LineNrAbove                 = { fg = c.line_nr },
    LineNrBelow                 = { fg = c.line_nr },
    SignColumn                  = { fg = c.fg_gutter, bg = bg },
    SignColumnSB                = { fg = c.fg_gutter, bg = c.bg_sidebar },
    FoldColumn                  = { fg = c.fg_muted, bg = bg },
    Folded                      = { fg = c.sky, bg = Util.blend_bg(c.blue, 0.12) },
    CursorLineFold              = { fg = c.blue },
    CursorLineSign              = {},

    Conceal                     = { fg = c.fg_muted },
    Directory                   = { fg = c.sky },
    EndOfBuffer                 = { fg = c.bg },
    NonText                     = { fg = c.dark3 },
    SpecialKey                  = { fg = c.dark3 },
    Whitespace                  = { fg = c.fg_gutter },

    VertSplit                   = { fg = c.border },
    WinSeparator                = { fg = c.border, bold = true },

    MatchParen                  = { fg = c.cream, bg = Util.blend_bg(c.blue, 0.3), bold = true }, -- editorBracketMatch
    Visual                      = { bg = c.bg_visual },
    VisualNOS                   = { bg = c.bg_visual },
    Search                      = { fg = c.fg_bright, bg = c.bg_search },
    IncSearch                   = { fg = c.on_accent, bg = c.bg_cursearch },
    CurSearch                   = "IncSearch",
    Substitute                  = { fg = c.on_accent, bg = c.red },
    QuickFixLine                = { bg = c.bg_visual, bold = true },

    ModeMsg                     = { fg = c.fg_dark, bold = true },
    MsgArea                     = { fg = c.fg_light },
    MsgSeparator                = "WinSeparator",
    MoreMsg                     = { fg = c.blue },
    Question                    = { fg = c.blue },
    ErrorMsg                    = { fg = c.error },
    WarningMsg                  = { fg = c.warning },
    OkMsg                       = { fg = c.ok },
    Title                       = { fg = c.blue, bold = true },

    Pmenu                       = { fg = c.fg_light, bg = c.bg_popup },
    PmenuSel                    = { bg = Util.blend_bg(c.blue, c.is_light and 0.2 or 0.3), bold = true },
    PmenuKind                   = { fg = c.sky, bg = c.bg_popup },
    PmenuKindSel                = { fg = c.sky, bg = Util.blend_bg(c.blue, c.is_light and 0.2 or 0.3) },
    PmenuExtra                  = { fg = c.fg_muted, bg = c.bg_popup },
    PmenuExtraSel               = { fg = c.fg_muted, bg = Util.blend_bg(c.blue, c.is_light and 0.2 or 0.3) },
    PmenuMatch                  = { fg = c.ice, bg = c.bg_popup, bold = true },
    PmenuMatchSel               = { fg = c.ice, bg = Util.blend_bg(c.blue, c.is_light and 0.2 or 0.3), bold = true },
    PmenuSbar                   = { bg = c.bg_widget },
    PmenuThumb                  = { bg = Util.blend_bg(c.blue, 0.45) }, -- scrollbarSlider
    PmenuBorder                 = { fg = c.border_highlight, bg = c.bg_popup },
    ComplHint                   = { fg = c.dark5 },
    ComplHintMore               = "Question",
    WildMenu                    = { bg = c.bg_visual },

    -- VS Code's status bar is solid winter blue; in Neovim that's lualine's
    -- job, so the built-in statusline stays quiet and readable.
    StatusLine                  = { fg = c.fg_sidebar, bg = c.bg_statusline },
    StatusLineNC                = { fg = c.fg_muted, bg = c.bg_statusline },
    StatusLineTerm              = "StatusLine",
    StatusLineTermNC            = "StatusLineNC",
    TabLine                     = { fg = c.fg_muted, bg = c.bg_dark }, -- tab.inactive
    TabLineFill                 = { bg = opts.transparent and c.none or c.bg_darker },
    TabLineSel                  = { fg = c.fg_light, bg = c.bg_widget, bold = true }, -- tab.active
    WinBar                      = { fg = c.fg_dark, bg = bg },
    WinBarNC                    = { fg = c.fg_muted, bg = bg },

    SpellBad                    = { sp = c.error, undercurl = true },
    SpellCap                    = { sp = c.warning, undercurl = true },
    SpellLocal                  = { sp = c.info, undercurl = true },
    SpellRare                   = { sp = c.hint, undercurl = true },

    -- Diff ----------------------------------------------------------------------
    DiffAdd                     = { bg = c.diff.add },
    DiffChange                  = { bg = c.diff.change },
    -- fg colors the `╱` filler LazyVim draws for deleted lines; keep it faint
    DiffDelete                  = { fg = Util.blend_bg(c.red, 0.38), bg = c.diff.delete },
    DiffText                    = { bg = c.diff.text },
    Added                       = { fg = c.git.add },
    Changed                     = { fg = c.git.change },
    Removed                     = { fg = c.git.delete },
    diffAdded                   = { fg = c.git.add, bg = c.diff.add },
    diffRemoved                 = { fg = c.git.delete, bg = c.diff.delete },
    diffChanged                 = { fg = c.git.change, bg = c.diff.change },
    diffOldFile                 = { fg = c.red_light },
    diffNewFile                 = { fg = c.lime },
    diffFile                    = { fg = c.sky },
    diffLine                    = { fg = c.comment },
    diffIndexLine               = { fg = c.purple },

    -- Syntax (legacy groups; treesitter links into these) --------------------
    Comment                     = { fg = s.comment, style = opts.styles.comments },
    Constant                    = { fg = s.constant },
    String                      = { fg = s.string, style = opts.styles.strings },
    Character                   = { fg = s.string },
    Number                      = { fg = s.number },
    Boolean                     = { fg = s.boolean },
    Float                       = "Number",

    Identifier                  = { fg = s.variable, style = opts.styles.variables },
    Function                    = { fg = s.func, style = opts.styles.functions },

    Statement                   = { fg = s.keyword, style = opts.styles.keywords },
    Conditional                 = { fg = s.keyword, style = opts.styles.keywords },
    Repeat                      = { fg = s.keyword, style = opts.styles.keywords },
    Label                       = { fg = s.label },
    Operator                    = { fg = s.operator, style = opts.styles.operators },
    Keyword                     = { fg = s.keyword, style = opts.styles.keywords },
    Exception                   = { fg = s.keyword, style = opts.styles.keywords },

    PreProc                     = { fg = s.storage },
    Include                     = { fg = s.keyword, style = opts.styles.keywords },
    Define                      = { fg = s.storage },
    Macro                       = { fg = s.storage },
    PreCondit                   = { fg = s.storage },

    Type                        = { fg = s.type, style = opts.styles.types },
    StorageClass                = { fg = s.storage, style = opts.styles.keywords },
    Structure                   = { fg = s.type },
    Typedef                     = { fg = s.type },

    Special                     = { fg = s.field },
    SpecialChar                 = { fg = s.escape },
    Tag                         = { fg = s.tag },
    Delimiter                   = { fg = s.punctuation },
    SpecialComment              = { fg = c.fg_muted },
    Debug                       = { fg = c.ember },

    Underlined                  = { underline = true },
    Bold                        = { bold = true },
    Italic                      = { italic = true },
    Ignore                      = { fg = c.dark3 },
    Error                       = { fg = c.error },
    Todo                        = { fg = c.on_accent, bg = c.cream, bold = true },

    -- LSP ---------------------------------------------------------------------
    LspReferenceText            = { bg = c.bg_visual }, -- editor.wordHighlightBackground
    LspReferenceRead            = { bg = c.bg_visual },
    LspReferenceWrite           = { bg = c.bg_visual, underline = true, sp = c.blue },
    LspReferenceTarget          = {},
    LspSignatureActiveParameter = { bg = Util.blend_bg(c.blue, 0.25), bold = true },
    LspCodeLens                 = { fg = c.fg_muted },
    LspCodeLensSeparator        = { fg = c.dark3 },
    LspInlayHint                = { fg = c.dark5, bg = c.bg_inlay }, -- editorInlayHint
    LspInfoBorder               = { fg = c.border_highlight, bg = c.bg_float },

    -- Diagnostics -------------------------------------------------------------
    DiagnosticError             = { fg = c.error },
    DiagnosticWarn              = { fg = c.warning },
    DiagnosticInfo              = { fg = c.info },
    DiagnosticHint              = { fg = c.hint },
    DiagnosticOk                = { fg = c.ok },
    DiagnosticUnnecessary       = { fg = c.fg_muted },
    DiagnosticDeprecated        = { strikethrough = true, sp = c.fg_muted },
    DiagnosticVirtualTextError  = { fg = c.error, bg = Util.blend_bg(c.error, 0.1) },
    DiagnosticVirtualTextWarn   = { fg = c.warning, bg = Util.blend_bg(c.warning, 0.1) },
    DiagnosticVirtualTextInfo   = { fg = c.info, bg = Util.blend_bg(c.info, 0.1) },
    DiagnosticVirtualTextHint   = { fg = c.hint, bg = Util.blend_bg(c.hint, 0.1) },
    DiagnosticVirtualTextOk     = { fg = c.ok, bg = Util.blend_bg(c.ok, 0.1) },
    DiagnosticUnderlineError    = { undercurl = true, sp = c.error },
    DiagnosticUnderlineWarn     = { undercurl = true, sp = c.warning },
    DiagnosticUnderlineInfo     = { undercurl = true, sp = c.info },
    DiagnosticUnderlineHint     = { undercurl = true, sp = c.hint },
    DiagnosticUnderlineOk       = { undercurl = true, sp = c.ok },

    -- Misc built-in filetypes -------------------------------------------------
    healthError                 = { fg = c.error },
    healthSuccess               = { fg = c.ok },
    healthWarning               = { fg = c.warning },
    helpCommand                 = { fg = c.cream, bg = c.bg_widget },
    helpExample                 = { fg = c.comment },
    helpHyperTextJump           = { fg = c.sky, underline = true },
    qfFileName                  = { fg = c.sky },
    qfLineNr                    = { fg = c.fg_muted },
    debugPC                     = { bg = c.bg_sidebar },
    debugBreakpoint             = { fg = c.info, bg = Util.blend_bg(c.info, 0.1) },
    dosIniLabel                 = "@property",
    htmlH1                      = { fg = s.heading, bold = true },
    htmlH2                      = { fg = c.azure, bold = true },
  }
end

return M

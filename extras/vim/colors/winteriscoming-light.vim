" Winter is Coming Light for Vim (8.2+ with termguicolors, or gVim)
" upstream: https://github.com/johnpapa/vscode-winteriscoming
" Add extras/vim to your runtimepath, then :colorscheme winteriscoming-light
set background=light
hi clear
if exists("syntax_on") | syntax reset | endif
let g:colors_name = "winteriscoming-light"

hi Added guifg=#22863a gui=NONE cterm=NONE
hi Bold gui=bold cterm=NONE
hi BoldItalic gui=bold,italic cterm=NONE
hi Boolean guifg=#174781 gui=NONE cterm=NONE
hi Changed guifg=#1857a4 gui=NONE cterm=NONE
hi Character guifg=#a44185 gui=NONE cterm=NONE
hi ColorColumn guibg=#f3f3f3 gui=NONE cterm=NONE
hi Comment guifg=#357b42 gui=italic cterm=NONE
hi ComplHint guifg=#7a9eb8 gui=NONE cterm=NONE
hi! link ComplHintMore Question
hi Conceal guifg=#5f7e97 gui=NONE cterm=NONE
hi Conditional guifg=#0784a6 gui=italic cterm=NONE
hi Constant guifg=#2970c7 gui=NONE cterm=NONE
hi! link CurSearch IncSearch
hi Cursor guifg=#ffffff guibg=#2f86d2 gui=NONE cterm=NONE
hi CursorColumn guibg=#eff2ef gui=NONE cterm=NONE
hi CursorIM guifg=#ffffff guibg=#2f86d2 gui=NONE cterm=NONE
hi CursorLine guibg=#eff2ef gui=NONE cterm=NONE
hi CursorLineFold guifg=#2f86d2 gui=NONE cterm=NONE
hi CursorLineNr guifg=#1857a4 gui=bold cterm=NONE
hi Debug guifg=#da5221 gui=NONE cterm=NONE
hi Define guifg=#da5221 gui=NONE cterm=NONE
hi Delimiter guifg=#3e3e3e gui=NONE cterm=NONE
hi DiagnosticDeprecated guisp=#5f7e97 gui=strikethrough cterm=NONE
hi DiagnosticError guifg=#de3d3b gui=NONE cterm=NONE
hi DiagnosticHint guifg=#2f7d70 gui=NONE cterm=NONE
hi DiagnosticInfo guifg=#2f86d2 gui=NONE cterm=NONE
hi DiagnosticOk guifg=#07805e gui=NONE cterm=NONE
hi DiagnosticUnderlineError guisp=#de3d3b gui=undercurl cterm=NONE
hi DiagnosticUnderlineHint guisp=#2f7d70 gui=undercurl cterm=NONE
hi DiagnosticUnderlineInfo guisp=#2f86d2 gui=undercurl cterm=NONE
hi DiagnosticUnderlineOk guisp=#07805e gui=undercurl cterm=NONE
hi DiagnosticUnderlineWarn guisp=#9a6a00 gui=undercurl cterm=NONE
hi DiagnosticUnnecessary guifg=#5f7e97 gui=NONE cterm=NONE
hi DiagnosticVirtualTextError guifg=#de3d3b guibg=#fceceb gui=NONE cterm=NONE
hi DiagnosticVirtualTextHint guifg=#2f7d70 guibg=#eaf2f1 gui=NONE cterm=NONE
hi DiagnosticVirtualTextInfo guifg=#2f86d2 guibg=#eaf3fb gui=NONE cterm=NONE
hi DiagnosticVirtualTextOk guifg=#07805e guibg=#e6f2ef gui=NONE cterm=NONE
hi DiagnosticVirtualTextWarn guifg=#9a6a00 guibg=#f5f0e6 gui=NONE cterm=NONE
hi DiagnosticWarn guifg=#9a6a00 gui=NONE cterm=NONE
hi DiffAdd guibg=#cee4d4 gui=NONE cterm=NONE
hi DiffChange guibg=#e6f0fa gui=NONE cterm=NONE
hi DiffDelete guifg=#f2b5b5 guibg=#f9dcdc gui=NONE cterm=NONE
hi DiffText guibg=#bcd8f1 guisp=#2f86d2 gui=underline cterm=NONE
hi DiffTextAdd guibg=#b8d8c0 guisp=#22863a gui=underline cterm=NONE
hi Directory guifg=#207bb8 gui=NONE cterm=NONE
hi EndOfBuffer guifg=#ffffff gui=NONE cterm=NONE
hi Error guifg=#de3d3b gui=NONE cterm=NONE
hi ErrorMsg guifg=#de3d3b gui=NONE cterm=NONE
hi Exception guifg=#0784a6 gui=italic cterm=NONE
hi! link Float Number
hi FloatBorder guifg=#2f86d2 guibg=#f3f3f3 gui=NONE cterm=NONE
hi FloatFooter guifg=#5f7e97 guibg=#f3f3f3 gui=NONE cterm=NONE
hi FloatShadow guibg=#011627 gui=NONE cterm=NONE
hi FloatShadowThrough guibg=#011627 gui=NONE cterm=NONE
hi FloatTitle guifg=#2f86d2 guibg=#f3f3f3 gui=bold cterm=NONE
hi FoldColumn guifg=#5f7e97 guibg=#ffffff gui=NONE cterm=NONE
hi Folded guifg=#207bb8 guibg=#e6f0fa gui=NONE cterm=NONE
hi Function guifg=#b1108e gui=NONE cterm=NONE
hi Identifier guifg=#6b6b6b gui=NONE cterm=NONE
hi Ignore guifg=#b4b6c0 gui=NONE cterm=NONE
hi IncSearch guifg=#ffffff guibg=#9a6a00 gui=NONE cterm=NONE
hi Include guifg=#0784a6 gui=italic cterm=NONE
hi Italic gui=italic cterm=NONE
hi Keyword guifg=#0784a6 gui=italic cterm=NONE
hi Label guifg=#b02767 gui=NONE cterm=NONE
hi LineNr guifg=#599edb gui=NONE cterm=NONE
hi LineNrAbove guifg=#599edb gui=NONE cterm=NONE
hi LineNrBelow guifg=#599edb gui=NONE cterm=NONE
hi LspCodeLens guifg=#5f7e97 gui=NONE cterm=NONE
hi LspCodeLensSeparator guifg=#b4b6c0 gui=NONE cterm=NONE
hi LspInfoBorder guifg=#2f86d2 guibg=#f3f3f3 gui=NONE cterm=NONE
hi LspInlayHint guifg=#7a9eb8 guibg=#ddeef7 gui=NONE cterm=NONE
hi LspKindArray guifg=#3e3e3e gui=NONE cterm=NONE
hi! link LspKindBoolean Boolean
hi! link LspKindClass Type
hi! link LspKindColor Special
hi! link LspKindConstant Constant
hi LspKindConstructor guifg=#7c2cbd gui=NONE cterm=NONE
hi! link LspKindEnum Type
hi! link LspKindEnumMember Constant
hi! link LspKindEvent Special
hi LspKindField guifg=#b05f0a gui=NONE cterm=NONE
hi! link LspKindFile Normal
hi! link LspKindFolder Directory
hi! link LspKindFunction Function
hi LspKindInterface guifg=#0444ac gui=NONE cterm=NONE
hi LspKindKey guifg=#b05f0a gui=NONE cterm=NONE
hi! link LspKindKeyword Keyword
hi LspKindMethod guifg=#b1108e gui=NONE cterm=NONE
hi LspKindModule guifg=#296d31 gui=NONE cterm=NONE
hi LspKindNamespace guifg=#296d31 gui=NONE cterm=NONE
hi LspKindNull guifg=#2970c7 gui=NONE cterm=NONE
hi! link LspKindNumber Number
hi! link LspKindObject Constant
hi! link LspKindOperator Operator
hi LspKindPackage guifg=#296d31 gui=NONE cterm=NONE
hi LspKindProperty guifg=#b05f0a gui=NONE cterm=NONE
hi LspKindReference guifg=#87429a gui=NONE cterm=NONE
hi! link LspKindSnippet Conceal
hi! link LspKindString String
hi! link LspKindStruct Type
hi LspKindText gui=NONE cterm=NONE
hi LspKindTypeParameter guifg=#0444ac gui=NONE cterm=NONE
hi! link LspKindUnit Type
hi! link LspKindValue String
hi LspKindVariable guifg=#6b6b6b gui=NONE cterm=NONE
hi LspReferenceRead guibg=#cee1f0 gui=NONE cterm=NONE
hi LspReferenceText guibg=#cee1f0 gui=NONE cterm=NONE
hi LspReferenceWrite guibg=#cee1f0 guisp=#2f86d2 gui=underline cterm=NONE
hi LspSignatureActiveParameter guibg=#cbe1f4 gui=bold cterm=NONE
hi Macro guifg=#da5221 gui=NONE cterm=NONE
hi MatchParen guifg=#b05f0a guibg=#c1dbf2 gui=bold cterm=NONE
hi ModeMsg guifg=#37567c gui=bold cterm=NONE
hi MoreMsg guifg=#2f86d2 gui=NONE cterm=NONE
hi MsgArea guifg=#3e3e3e gui=NONE cterm=NONE
hi! link MsgSeparator WinSeparator
hi NonText guifg=#b4b6c0 gui=NONE cterm=NONE
hi Normal guifg=#002339 guibg=#ffffff gui=NONE cterm=NONE
hi NormalFloat guifg=#002339 guibg=#f3f3f3 gui=NONE cterm=NONE
hi NormalNC guifg=#002339 guibg=#ffffff gui=NONE cterm=NONE
hi NormalSB guifg=#37567c guibg=#f3f3f3 gui=NONE cterm=NONE
hi Number guifg=#174781 gui=NONE cterm=NONE
hi OkMsg guifg=#07805e gui=NONE cterm=NONE
hi Operator guifg=#7b30d0 gui=NONE cterm=NONE
hi Pmenu guifg=#3e3e3e guibg=#f3f3f3 gui=NONE cterm=NONE
hi PmenuBorder guifg=#2f86d2 guibg=#f3f3f3 gui=NONE cterm=NONE
hi PmenuExtra guifg=#5f7e97 guibg=#f3f3f3 gui=NONE cterm=NONE
hi PmenuExtraSel guifg=#5f7e97 guibg=#d5e7f6 gui=NONE cterm=NONE
hi PmenuKind guifg=#207bb8 guibg=#f3f3f3 gui=NONE cterm=NONE
hi PmenuKindSel guifg=#207bb8 guibg=#d5e7f6 gui=NONE cterm=NONE
hi PmenuMatch guifg=#0784a6 guibg=#f3f3f3 gui=bold cterm=NONE
hi PmenuMatchSel guifg=#0784a6 guibg=#d5e7f6 gui=bold cterm=NONE
hi PmenuSbar guibg=#e3e3e3 gui=NONE cterm=NONE
hi PmenuSel guibg=#d5e7f6 gui=bold cterm=NONE
hi PmenuThumb guibg=#a1c9eb gui=NONE cterm=NONE
hi PreCondit guifg=#da5221 gui=NONE cterm=NONE
hi PreProc guifg=#da5221 gui=NONE cterm=NONE
hi Question guifg=#2f86d2 gui=NONE cterm=NONE
hi QuickFixLine guibg=#cee1f0 gui=bold cterm=NONE
hi Removed guifg=#b31d28 gui=NONE cterm=NONE
hi Repeat guifg=#0784a6 gui=italic cterm=NONE
hi Search guifg=#011627 guibg=#d8cded gui=NONE cterm=NONE
hi SignColumn guifg=#dde3e7 guibg=#ffffff gui=NONE cterm=NONE
hi SignColumnSB guifg=#dde3e7 guibg=#f3f3f3 gui=NONE cterm=NONE
hi Special guifg=#2f7d70 gui=NONE cterm=NONE
hi SpecialChar guifg=#b8418f gui=NONE cterm=NONE
hi SpecialComment guifg=#5f7e97 gui=NONE cterm=NONE
hi SpecialKey guifg=#b4b6c0 gui=NONE cterm=NONE
hi SpellBad guisp=#de3d3b gui=undercurl cterm=NONE
hi SpellCap guisp=#9a6a00 gui=undercurl cterm=NONE
hi SpellLocal guisp=#2f86d2 gui=undercurl cterm=NONE
hi SpellRare guisp=#2f7d70 gui=undercurl cterm=NONE
hi Statement guifg=#0784a6 gui=italic cterm=NONE
hi StatusLine guifg=#37567c guibg=#f3f3f3 gui=NONE cterm=NONE
hi StatusLineNC guifg=#5f7e97 guibg=#f3f3f3 gui=NONE cterm=NONE
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi StorageClass guifg=#da5221 gui=italic cterm=NONE
hi String guifg=#a44185 gui=NONE cterm=NONE
hi Structure guifg=#0444ac gui=NONE cterm=NONE
hi Substitute guifg=#ffffff guibg=#de3d3b gui=NONE cterm=NONE
hi TabLine guifg=#5f7e97 guibg=#f3f3f3 gui=NONE cterm=NONE
hi TabLineFill guibg=#e8e8e8 gui=NONE cterm=NONE
hi TabLineSel guifg=#3e3e3e guibg=#e3e3e3 gui=bold cterm=NONE
hi Tag guifg=#0444ac gui=NONE cterm=NONE
hi TermCursor guifg=#ffffff guibg=#2f86d2 gui=NONE cterm=NONE
hi TermCursorNC guifg=#ffffff guibg=#5f7e97 gui=NONE cterm=NONE
hi Title guifg=#2f86d2 gui=bold cterm=NONE
hi Todo guifg=#ffffff guibg=#b05f0a gui=bold cterm=NONE
hi Type guifg=#0444ac gui=NONE cterm=NONE
hi Typedef guifg=#0444ac gui=NONE cterm=NONE
hi Underlined gui=underline cterm=NONE
hi VertSplit guifg=#d4d4d4 gui=NONE cterm=NONE
hi Visual guibg=#cee1f0 gui=NONE cterm=NONE
hi VisualNOS guibg=#cee1f0 gui=NONE cterm=NONE
hi WarningMsg guifg=#9a6a00 gui=NONE cterm=NONE
hi Whitespace guifg=#dde3e7 gui=NONE cterm=NONE
hi WildMenu guibg=#cee1f0 gui=NONE cterm=NONE
hi WinBar guifg=#37567c guibg=#ffffff gui=NONE cterm=NONE
hi WinBarNC guifg=#5f7e97 guibg=#ffffff gui=NONE cterm=NONE
hi WinSeparator guifg=#d4d4d4 gui=bold cterm=NONE
hi debugBreakpoint guifg=#2f86d2 guibg=#eaf3fb gui=NONE cterm=NONE
hi debugPC guibg=#f3f3f3 gui=NONE cterm=NONE
hi diffAdded guifg=#22863a guibg=#cee4d4 gui=NONE cterm=NONE
hi diffChanged guifg=#1857a4 guibg=#e6f0fa gui=NONE cterm=NONE
hi diffFile guifg=#207bb8 gui=NONE cterm=NONE
hi diffIndexLine guifg=#7b30d0 gui=NONE cterm=NONE
hi diffLine guifg=#357b42 gui=NONE cterm=NONE
hi diffNewFile guifg=#497803 gui=NONE cterm=NONE
hi diffOldFile guifg=#f76c6c gui=NONE cterm=NONE
hi diffRemoved guifg=#b31d28 guibg=#f9dcdc gui=NONE cterm=NONE
hi dosIniLabel guifg=#b05f0a gui=NONE cterm=NONE
hi healthError guifg=#de3d3b gui=NONE cterm=NONE
hi healthSuccess guifg=#07805e gui=NONE cterm=NONE
hi healthWarning guifg=#9a6a00 gui=NONE cterm=NONE
hi helpCommand guifg=#b05f0a guibg=#e3e3e3 gui=NONE cterm=NONE
hi helpExample guifg=#357b42 gui=NONE cterm=NONE
hi helpHyperTextJump guifg=#207bb8 gui=underline cterm=NONE
hi htmlH1 guifg=#034c7c gui=bold cterm=NONE
hi htmlH2 guifg=#2970c7 gui=bold cterm=NONE
hi lCursor guifg=#ffffff guibg=#2f86d2 gui=NONE cterm=NONE
hi qfFileName guifg=#207bb8 gui=NONE cterm=NONE
hi qfLineNr guifg=#5f7e97 gui=NONE cterm=NONE

let g:terminal_ansi_colors = ["#011627", "#de3d3b", "#08916a", "#c5a332", "#236ebf", "#7c4dff", "#0097a7", "#7e8993", "#403f53", "#f76c6c", "#49d0b0", "#e7c244", "#4e8cdf", "#b15a91", "#00bcd4", "#403f53"]

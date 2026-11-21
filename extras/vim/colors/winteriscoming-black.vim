" Winter is Coming Dark Black for Vim (8.2+ with termguicolors, or gVim)
" upstream: https://github.com/johnpapa/vscode-winteriscoming
" Add extras/vim to your runtimepath, then :colorscheme winteriscoming-black
set background=dark
hi clear
if exists("syntax_on") | syntax reset | endif
let g:colors_name = "winteriscoming-black"

hi Added guifg=#addb67 gui=NONE cterm=NONE
hi Bold gui=bold cterm=NONE
hi BoldItalic gui=bold,italic cterm=NONE
hi Boolean guifg=#8dec95 gui=NONE cterm=NONE
hi Changed guifg=#219fd5 gui=NONE cterm=NONE
hi Character guifg=#bcf0c0 gui=NONE cterm=NONE
hi ColorColumn guibg=#1f1f1a gui=NONE cterm=NONE
hi Comment guifg=#8a9db3 gui=italic cterm=NONE
hi ComplHint guifg=#4d8aa0 gui=NONE cterm=NONE
hi! link ComplHintMore Question
hi Conceal guifg=#5f7e97 gui=NONE cterm=NONE
hi Conditional guifg=#00bff9 gui=italic cterm=NONE
hi Constant guifg=#ad80d4 gui=NONE cterm=NONE
hi! link CurSearch IncSearch
hi Cursor guifg=#282822 guibg=#219fd5 gui=NONE cterm=NONE
hi CursorColumn guibg=#303331 gui=NONE cterm=NONE
hi CursorIM guifg=#282822 guibg=#219fd5 gui=NONE cterm=NONE
hi CursorLine guibg=#303331 gui=NONE cterm=NONE
hi CursorLineFold guifg=#219fd5 gui=NONE cterm=NONE
hi CursorLineNr guifg=#219fd5 gui=bold cterm=NONE
hi Debug guifg=#f78c6c gui=NONE cterm=NONE
hi Define guifg=#c792ea gui=NONE cterm=NONE
hi Delimiter guifg=#d6deeb gui=NONE cterm=NONE
hi DiagnosticDeprecated guisp=#5f7e97 gui=strikethrough cterm=NONE
hi DiagnosticError guifg=#ef5350 gui=NONE cterm=NONE
hi DiagnosticHint guifg=#7fdbca gui=NONE cterm=NONE
hi DiagnosticInfo guifg=#219fd5 gui=NONE cterm=NONE
hi DiagnosticOk guifg=#8dec95 gui=NONE cterm=NONE
hi DiagnosticUnderlineError guisp=#ef5350 gui=undercurl cterm=NONE
hi DiagnosticUnderlineHint guisp=#7fdbca gui=undercurl cterm=NONE
hi DiagnosticUnderlineInfo guisp=#219fd5 gui=undercurl cterm=NONE
hi DiagnosticUnderlineOk guisp=#8dec95 gui=undercurl cterm=NONE
hi DiagnosticUnderlineWarn guisp=#ffca28 gui=undercurl cterm=NONE
hi DiagnosticUnnecessary guifg=#5f7e97 gui=NONE cterm=NONE
hi DiagnosticVirtualTextError guifg=#ef5350 guibg=#3c2c27 gui=NONE cterm=NONE
hi DiagnosticVirtualTextHint guifg=#7fdbca guibg=#313a33 gui=NONE cterm=NONE
hi DiagnosticVirtualTextInfo guifg=#219fd5 guibg=#273434 gui=NONE cterm=NONE
hi DiagnosticVirtualTextOk guifg=#8dec95 guibg=#323c2e gui=NONE cterm=NONE
hi DiagnosticVirtualTextWarn guifg=#ffca28 guibg=#3e3823 gui=NONE cterm=NONE
hi DiagnosticWarn guifg=#ffca28 gui=NONE cterm=NONE
hi DiffAdd guibg=#3d452d gui=NONE cterm=NONE
hi DiffChange guibg=#27393b gui=NONE cterm=NONE
hi DiffDelete guifg=#743833 guibg=#4c302a gui=NONE cterm=NONE
hi DiffText guibg=#255566 guisp=#219fd5 gui=underline cterm=NONE
hi DiffTextAdd guibg=#485333 guisp=#addb67 gui=underline cterm=NONE
hi Directory guifg=#6dbdfa gui=NONE cterm=NONE
hi EndOfBuffer guifg=#282822 gui=NONE cterm=NONE
hi Error guifg=#ef5350 gui=NONE cterm=NONE
hi ErrorMsg guifg=#ef5350 gui=NONE cterm=NONE
hi Exception guifg=#00bff9 gui=italic cterm=NONE
hi! link Float Number
hi FloatBorder guifg=#2381a8 guibg=#1f1f1a gui=NONE cterm=NONE
hi FloatFooter guifg=#5f7e97 guibg=#1f1f1a gui=NONE cterm=NONE
hi FloatShadow guibg=#181814 gui=NONE cterm=NONE
hi FloatShadowThrough guibg=#181814 gui=NONE cterm=NONE
hi FloatTitle guifg=#219fd5 guibg=#1f1f1a gui=bold cterm=NONE
hi FoldColumn guifg=#5f7e97 guibg=#282822 gui=NONE cterm=NONE
hi Folded guifg=#6dbdfa guibg=#21211c gui=NONE cterm=NONE
hi Function guifg=#8fa2f8 gui=NONE cterm=NONE
hi Identifier guifg=#b3c8d9 gui=NONE cterm=NONE
hi Ignore guifg=#4f4e44 gui=NONE cterm=NONE
hi IncSearch guifg=#171713 guibg=#f7ecb5 gui=NONE cterm=NONE
hi Include guifg=#00bff9 gui=italic cterm=NONE
hi Italic gui=italic cterm=NONE
hi Keyword guifg=#00bff9 gui=italic cterm=NONE
hi Label guifg=#4fb4d8 gui=NONE cterm=NONE
hi LineNr guifg=#246f8d gui=NONE cterm=NONE
hi LineNrAbove guifg=#246f8d gui=NONE cterm=NONE
hi LineNrBelow guifg=#246f8d gui=NONE cterm=NONE
hi LspCodeLens guifg=#5f7e97 gui=NONE cterm=NONE
hi LspCodeLensSeparator guifg=#4f4e44 gui=NONE cterm=NONE
hi LspInfoBorder guifg=#2381a8 guibg=#1f1f1a gui=NONE cterm=NONE
hi LspInlayHint guifg=#4d8aa0 guibg=#2e2e2a gui=NONE cterm=NONE
hi LspKindArray guifg=#d6deeb gui=NONE cterm=NONE
hi! link LspKindBoolean Boolean
hi! link LspKindClass Type
hi! link LspKindColor Special
hi! link LspKindConstant Constant
hi LspKindConstructor guifg=#d29ffc gui=NONE cterm=NONE
hi! link LspKindEnum Type
hi! link LspKindEnumMember Constant
hi! link LspKindEvent Special
hi LspKindField guifg=#f7ecb5 gui=NONE cterm=NONE
hi! link LspKindFile Normal
hi! link LspKindFolder Directory
hi! link LspKindFunction Function
hi LspKindInterface guifg=#d29ffc gui=NONE cterm=NONE
hi LspKindKey guifg=#f7ecb5 gui=NONE cterm=NONE
hi! link LspKindKeyword Keyword
hi LspKindMethod guifg=#8fa2f8 gui=NONE cterm=NONE
hi LspKindModule guifg=#d3eed6 gui=NONE cterm=NONE
hi LspKindNamespace guifg=#d3eed6 gui=NONE cterm=NONE
hi LspKindNull guifg=#92b6f4 gui=NONE cterm=NONE
hi! link LspKindNumber Number
hi! link LspKindObject Constant
hi! link LspKindOperator Operator
hi LspKindPackage guifg=#d3eed6 gui=NONE cterm=NONE
hi LspKindProperty guifg=#f7ecb5 gui=NONE cterm=NONE
hi LspKindReference guifg=#78bd65 gui=NONE cterm=NONE
hi! link LspKindSnippet Conceal
hi! link LspKindString String
hi! link LspKindStruct Type
hi LspKindText gui=NONE cterm=NONE
hi LspKindTypeParameter guifg=#d29ffc gui=NONE cterm=NONE
hi! link LspKindUnit Type
hi! link LspKindValue String
hi LspKindVariable guifg=#b3c8d9 gui=NONE cterm=NONE
hi LspReferenceRead guibg=#2a4258 gui=NONE cterm=NONE
hi LspReferenceText guibg=#2a4258 gui=NONE cterm=NONE
hi LspReferenceWrite guibg=#2a4258 guisp=#219fd5 gui=underline cterm=NONE
hi LspSignatureActiveParameter guibg=#26464f gui=bold cterm=NONE
hi Macro guifg=#c792ea gui=NONE cterm=NONE
hi MatchParen guifg=#f7ecb5 guibg=#264c58 gui=bold cterm=NONE
hi ModeMsg guifg=#7799bb gui=bold cterm=NONE
hi MoreMsg guifg=#219fd5 gui=NONE cterm=NONE
hi MsgArea guifg=#d6deeb gui=NONE cterm=NONE
hi! link MsgSeparator WinSeparator
hi NonText guifg=#4f4e44 gui=NONE cterm=NONE
hi Normal guifg=#bce7ff guibg=#282822 gui=NONE cterm=NONE
hi NormalFloat guifg=#bce7ff guibg=#1f1f1a gui=NONE cterm=NONE
hi NormalNC guifg=#bce7ff guibg=#282822 gui=NONE cterm=NONE
hi NormalSB guifg=#7799bb guibg=#1f1f1a gui=NONE cterm=NONE
hi Number guifg=#8dec95 gui=NONE cterm=NONE
hi OkMsg guifg=#8dec95 gui=NONE cterm=NONE
hi Operator guifg=#00bff9 gui=NONE cterm=NONE
hi Pmenu guifg=#d6deeb guibg=#1f1f1a gui=NONE cterm=NONE
hi PmenuBorder guifg=#2381a8 guibg=#1f1f1a gui=NONE cterm=NONE
hi PmenuExtra guifg=#5f7e97 guibg=#1f1f1a gui=NONE cterm=NONE
hi PmenuExtraSel guifg=#5f7e97 guibg=#264c58 gui=NONE cterm=NONE
hi PmenuKind guifg=#6dbdfa guibg=#1f1f1a gui=NONE cterm=NONE
hi PmenuKindSel guifg=#6dbdfa guibg=#264c58 gui=NONE cterm=NONE
hi PmenuMatch guifg=#00bff9 guibg=#1f1f1a gui=bold cterm=NONE
hi PmenuMatchSel guifg=#00bff9 guibg=#264c58 gui=bold cterm=NONE
hi PmenuSbar guibg=#33332c gui=NONE cterm=NONE
hi PmenuSel guibg=#264c58 gui=bold cterm=NONE
hi PmenuThumb guibg=#255e73 gui=NONE cterm=NONE
hi PreCondit guifg=#c792ea gui=NONE cterm=NONE
hi PreProc guifg=#c792ea gui=NONE cterm=NONE
hi Question guifg=#219fd5 gui=NONE cterm=NONE
hi QuickFixLine guibg=#2a4258 gui=bold cterm=NONE
hi Removed guifg=#ef5350 gui=NONE cterm=NONE
hi Repeat guifg=#00bff9 gui=italic cterm=NONE
hi Search guifg=#eeefff guibg=#534072 gui=NONE cterm=NONE
hi SignColumn guifg=#3b3a32 guibg=#282822 gui=NONE cterm=NONE
hi SignColumnSB guifg=#3b3a32 guibg=#1f1f1a gui=NONE cterm=NONE
hi Special guifg=#7fdbca gui=NONE cterm=NONE
hi SpecialChar guifg=#ec9cd2 gui=NONE cterm=NONE
hi SpecialComment guifg=#5f7e97 gui=NONE cterm=NONE
hi SpecialKey guifg=#4f4e44 gui=NONE cterm=NONE
hi SpellBad guisp=#ef5350 gui=undercurl cterm=NONE
hi SpellCap guisp=#ffca28 gui=undercurl cterm=NONE
hi SpellLocal guisp=#219fd5 gui=undercurl cterm=NONE
hi SpellRare guisp=#7fdbca gui=undercurl cterm=NONE
hi Statement guifg=#00bff9 gui=italic cterm=NONE
hi StatusLine guifg=#7799bb guibg=#1f1f1a gui=NONE cterm=NONE
hi StatusLineNC guifg=#5f7e97 guibg=#1f1f1a gui=NONE cterm=NONE
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi StorageClass guifg=#c792ea gui=italic cterm=NONE
hi String guifg=#bcf0c0 gui=NONE cterm=NONE
hi Structure guifg=#d29ffc gui=NONE cterm=NONE
hi Substitute guifg=#171713 guibg=#ef5350 gui=NONE cterm=NONE
hi TabLine guifg=#5f7e97 guibg=#1f1f1a gui=NONE cterm=NONE
hi TabLineFill guibg=#171713 gui=NONE cterm=NONE
hi TabLineSel guifg=#d6deeb guibg=#33332c gui=bold cterm=NONE
hi Tag guifg=#6dbdfa gui=NONE cterm=NONE
hi TermCursor guifg=#282822 guibg=#219fd5 gui=NONE cterm=NONE
hi TermCursorNC guifg=#282822 guibg=#5f7e97 gui=NONE cterm=NONE
hi Title guifg=#219fd5 gui=bold cterm=NONE
hi Todo guifg=#171713 guibg=#f7ecb5 gui=bold cterm=NONE
hi Type guifg=#d29ffc gui=NONE cterm=NONE
hi Typedef guifg=#d29ffc gui=NONE cterm=NONE
hi Underlined gui=underline cterm=NONE
hi VertSplit guifg=#3a3a32 gui=NONE cterm=NONE
hi Visual guibg=#2a4258 gui=NONE cterm=NONE
hi VisualNOS guibg=#2a4258 gui=NONE cterm=NONE
hi WarningMsg guifg=#ffca28 gui=NONE cterm=NONE
hi Whitespace guifg=#3b3a32 gui=NONE cterm=NONE
hi WildMenu guibg=#2a4258 gui=NONE cterm=NONE
hi WinBar guifg=#7799bb guibg=#282822 gui=NONE cterm=NONE
hi WinBarNC guifg=#5f7e97 guibg=#282822 gui=NONE cterm=NONE
hi WinSeparator guifg=#3a3a32 gui=bold cterm=NONE
hi debugBreakpoint guifg=#219fd5 guibg=#273434 gui=NONE cterm=NONE
hi debugPC guibg=#1f1f1a gui=NONE cterm=NONE
hi diffAdded guifg=#addb67 guibg=#3d452d gui=NONE cterm=NONE
hi diffChanged guifg=#219fd5 guibg=#27393b gui=NONE cterm=NONE
hi diffFile guifg=#6dbdfa gui=NONE cterm=NONE
hi diffIndexLine guifg=#c792ea gui=NONE cterm=NONE
hi diffLine guifg=#8a9db3 gui=NONE cterm=NONE
hi diffNewFile guifg=#addb67 gui=NONE cterm=NONE
hi diffOldFile guifg=#ef9a9a gui=NONE cterm=NONE
hi diffRemoved guifg=#ef5350 guibg=#4c302a gui=NONE cterm=NONE
hi dosIniLabel guifg=#f7ecb5 gui=NONE cterm=NONE
hi healthError guifg=#ef5350 gui=NONE cterm=NONE
hi healthSuccess guifg=#8dec95 gui=NONE cterm=NONE
hi healthWarning guifg=#ffca28 gui=NONE cterm=NONE
hi helpCommand guifg=#f7ecb5 guibg=#33332c gui=NONE cterm=NONE
hi helpExample guifg=#8a9db3 gui=NONE cterm=NONE
hi helpHyperTextJump guifg=#6dbdfa gui=underline cterm=NONE
hi htmlH1 guifg=#5abeb0 gui=bold cterm=NONE
hi htmlH2 guifg=#82aaff gui=bold cterm=NONE
hi lCursor guifg=#282822 guibg=#219fd5 gui=NONE cterm=NONE
hi qfFileName guifg=#6dbdfa gui=NONE cterm=NONE
hi qfLineNr guifg=#5f7e97 gui=NONE cterm=NONE

let g:terminal_ansi_colors = ["#282822", "#ef5350", "#22da6e", "#f7ecb5", "#219fd5", "#c792ea", "#80cbc4", "#d6deeb", "#5f7e97", "#ef9a9a", "#addb67", "#ffcb6b", "#82aaff", "#c792ea", "#7fdbca", "#ffffff"]

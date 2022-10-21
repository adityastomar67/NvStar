" Setting up the colors
let s:nvstar0_gui  = "#212126"
let s:nvstar1_gui  = "#da696d"
let s:nvstar2_gui  = "#74be88"
let s:nvstar3_gui  = "#e1b56a"
let s:nvstar4_gui  = "#6d92b7"
let s:nvstar5_gui  = "#be67d5"
let s:nvstar6_gui  = "#679ca6"
let s:nvstar7_gui  = "#b9c1c1"
let s:nvstar8_gui  = "#28292f"
let s:nvstar9_gui  = "#ec6e74"
let s:nvstar10_gui = "#86d19a"
let s:nvstar11_gui = "#d4b27c"
let s:nvstar12_gui = "#6692bf"
let s:nvstar13_gui = "#c585cf"
let s:nvstar14_gui = "#6bd1e0"
let s:nvstar15_gui = "#ccc9c3"
let s:nvstarbg_gui = "#0f0f0f"
let s:nvstarfg_gui = "#dfdee0"
let s:nvstarbg_alt = "#18181a"
let s:nvstarNR_fg  = s:nvstar7_gui
let s:comment      = "#494b56"

hi clear
syntax reset
let g:colors_name = "nvstar"
set background=dark
set t_Co=256
hi Normal guifg=#dfdde0 ctermbg=NONE guibg=#0f0f0f gui=NONE
hi Conceal guibg=NONE

set t_Co=256
let &t_ut=''
if exists('+termguicolors')
  set termguicolors
endif

" Focused line Number toggle
if !exists("g:nvstarNR")
    let g:nvstarNR = 1
endif

" FZF-Lua
exe "hi Fzf1 guibg=NONE"
exe "hi Fzf2 guibg=NONE"
exe "hi Fzf3 guibg=NONE"

" Staline
exe "hi StalineBranch          guifg="s:comment
exe "hi StalineFolderIcon      guibg="s:nvstar1_gui.  " guifg="s:nvstarbg_gui
exe "hi StalineFolderText      guibg="s:nvstar8_gui.  " guifg="s:nvstar15_gui
exe "hi StalineProgress        guibg="s:nvstar8_gui.  " guifg="s:nvstar15_gui
exe "hi StalineFolderSep       guibg="s:nvstarbg_gui. " guifg="s:nvstar1_gui
exe "hi StalineProgressSepIcon guibg="s:nvstar10_gui. " guifg="s:nvstar8_gui
exe "hi StalineFilename        guibg="s:nvstarbg_gui. " guifg="s:nvstar15_gui
exe "hi StalineLogo            guibg="s:nvstarbg_gui. " guifg="s:nvstar12_gui
exe "hi StalineProgressSep     guibg="s:nvstarbg_gui. " guifg="s:nvstar10_gui

" Completiton
exe "hi CmpBorder        guifg="s:nvstar12_gui
exe "hi CmpItemAbbr      guifg="s:nvstarfg_gui
exe "hi CmpItemAbbrMatch guifg="s:nvstar12_gui
exe "highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080"
exe "highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6"
exe "highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch"
exe "highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE"
exe "highlight! link CmpItemKindInterface CmpItemKindVariable"
exe "highlight! link CmpItemKindText CmpItemKindVariable"
exe "highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0"
exe "highlight! link CmpItemKindMethod CmpItemKindFunction"
exe "highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4"
exe "highlight! link CmpItemKindProperty CmpItemKindKeyword"
exe "highlight! link CmpItemKindUnit CmpItemKindKeyword"

"TODO: More highlights help
  "PmenuSel = { bg = "#282C34", fg = "NONE" },
  "Pmenu = { fg = "#C5CDD9", bg = "#22252A" },

 " CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", fmt = "strikethrough" },
 " CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
 " CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
 " CmpItemMenu = { fg = "#C792EA", bg = "NONE", fmt = "italic" },

 " CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
 " CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
 " CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },

 " CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
 " CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
 " CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },

 " CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
"  CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
"  CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },

"  CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
 " CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
"  CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
"  CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
"  CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },

 " CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
 " CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },

 " CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
 " CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
 " CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },

 " CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
 " CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
 " CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },

  "CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
 " CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
 " CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },

" Todo-Comment Sign
exe "hi TodoSignDONE guibg=NONE"
exe "hi TodoSignFIX  guibg=NONE"
exe "hi TodoSignHACK guibg=NONE"
exe "hi TodoSignNOTE guibg=NONE"
exe "hi TodoSignPERF guibg=NONE"
exe "hi TodoSignTEST guibg=NONE"
exe "hi TodoSignTODO guibg=NONE"
exe "hi TodoSignWARN guibg=NONE"

" SearchBox
exe "hi FloatBorder guifg="s:nvstar12_gui

" Diagnostics
exe "hi DiagnosticError guifg="s:nvstar9_gui
exe "hi DiagnosticSign  guibg="s:nvstarbg_gui
exe "hi DiagnosticWarn  guifg="s:nvstar11_gui
exe "hi DiagnosticHint  guifg="s:nvstar14_gui

" Alpha
exe "hi AlphaButton guifg="s:nvstar4_gui
exe "hi AlphaFooter guifg="s:nvstar4_gui
exe "hi AlphaHeader guifg="s:nvstar12_gui

" Telescope
exe "hi TelescopeBorder        guifg="s:nvstarbg_alt
exe "hi TelescopeNormal        guibg="s:nvstarbg_alt
exe "hi TelescopePromptBorder  guifg="s:nvstar0_gui. "  guibg="s:nvstar0_gui
exe "hi TelescopePromptPrefix  guifg="s:nvstar9_gui. "  guibg="s:nvstar0_gui
exe "hi TelescopePromptTitle   guifg="s:nvstar8_gui. "  guibg="s:nvstar9_gui
exe "hi TelescopePromptNormal  guifg="s:nvstarfg_gui."  guibg="s:nvstar0_gui
exe "hi TelescopePreviewBorder guifg="s:nvstarbg_alt."  guibg="s:nvstarbg_alt
exe "hi TelescopePreviewTitle  guifg="s:nvstarbg_alt."  guibg="s:nvstarbg_alt
exe "hi TelescopeResultsTitle  guifg="s:nvstarbg_alt."  guibg="s:nvstarbg_alt
exe "hi TelescopeResultsBorder guifg="s:nvstarbg_alt."  guibg="s:nvstarbg_alt

" Whichkey
exe "hi WhichKey          guifg="s:nvstar2_gui.  " guibg="s:nvstarbg_alt
exe "hi WhichKeyFloat     guifg="s:nvstar2_gui.  " guibg="s:nvstarbg_alt
exe "hi WhichKeySeparator guifg="s:nvstar5_gui.  " guibg="s:nvstarbg_alt
exe "hi WhichKeyDesc      guifg="s:nvstar9_gui.  " guibg="s:nvstarbg_alt
exe "hi WhichKeyValue     guifg="s:nvstar12_gui. " guibg="s:nvstarbg_alt
exe "hi WhichKeyGroup     guifg="s:nvstar12_gui. " guibg="s:nvstarbg_alt

" Syntax Highlighting
exe "hi WarningMsg   guifg="s:nvstar0_gui
exe "hi CursorLine   guibg="s:nvstarbg_gui
exe "hi ErrorMsg     guifg="s:nvstar1_gui." guibg="s:nvstar8_gui
exe "hi CursorLineNR guifg=#F96666          guibg="s:nvstarbg_gui

" Specials
exe "hi PreProc          guifg="s:nvstar4_gui
exe "hi Exception        guifg="s:nvstar7_gui
exe "hi Error            guibg=NONE guifg="s:nvstar1_gui
exe "hi Type             guifg="s:nvstar4_gui
exe "hi Identifier       guifg="s:nvstar1_gui
exe "hi Constant         guifg="s:nvstar4_gui
exe "hi Repeat           guifg="s:nvstar5_gui
exe "hi Keyword          guifg="s:nvstar5_gui
exe "hi IncSearch        guifg="s:nvstar3_gui
exe "hi Title            guifg="s:nvstar2_gui
exe "hi PreCondit        guifg="s:nvstar5_gui
exe "hi SpecialChar      guifg="s:nvstar4_gui
exe "hi Conditional      guifg="s:nvstar1_gui
exe "hi Todo             guibg="s:nvstar3_gui
exe "hi Special          guifg="s:nvstar4_gui
exe "hi Delimiter        guifg="s:nvstar7_gui
exe "hi Number           guifg="s:nvstar6_gui
exe "hi Define           guifg="s:nvstar6_gui
exe "hi String           guifg="s:nvstar2_gui
exe "hi MatchParen       guifg="s:nvstar1_gui
exe "hi Macro            guifg="s:nvstar5_gui
exe "hi Function         guifg="s:nvstar4_gui
exe "hi Directory        guifg="s:nvstar4_gui
exe "hi markdownLinkText guifg="s:nvstar9_gui
exe "hi Include          guifg="s:nvstar1_gui
exe "hi Storage          guifg="s:nvstar9_gui
exe "hi Statement        guifg="s:nvstar5_gui
exe "hi Operator         guifg="s:nvstar4_gui
exe "hi ColorColumn      guibg="s:nvstar8_gui
exe "hi SignColumn       guibg="s:nvstar0_gui
exe "hi Title            guifg="s:nvstar3_gui
exe "hi LineNr           guifg="s:nvstar8_gui
exe "hi Underlined       guifg="s:nvstar3_gui
exe "hi Debug            guifg="s:nvstar13_gui
exe "hi Todo             guifg="s:nvstarbg_gui
exe "hi Label            guifg="s:nvstar12_gui
exe "hi MoreMsg          guifg="s:nvstar14_gui
exe "hi Tag              guifg="s:nvstar15_gui
exe "hi EndOfBuffer      guibg=NONE"
exe "hi TabLineFill      gui  =NONE              guibg="s:nvstar1_gui
exe "hi TabLineSel       gui  =NONE              guibg="s:nvstar1_gui
exe "hi Visual           gui  =NONE              guibg="s:nvstar0_gui
exe "hi NonText          guifg="s:nvstar5_gui."  guibg="s:nvstar0_gui
exe "hi TabLine          guifg="s:nvstarfg_gui." guibg="s:nvstar1_gui
exe "hi Search           guibg="s:nvstar8_gui."  guifg="s:nvstar4_gui
exe "hi PMenuSel         guifg="s:nvstar8_gui."  guibg="s:nvstar12_gui
exe "hi StatusLine       guibg="s:nvstarbg_gui." guifg="s:nvstarfg_gui
exe "hi StatusLineNC     guibg="s:nvstarbg_gui." guifg="s:nvstarfg_gui
exe "hi PMenu            guifg="s:nvstar7_gui."  guibg=" s:nvstarbg_alt
exe "hi VertSplit        gui  =NONE              guifg="s:nvstarbg_alt." guibg="s:nvstarbg_gui
exe "hi SpecialComment   guifg="s:nvstar8_gui "  gui  =italic            guibg=NONE "
exe "hi Comment          guifg="s:comment "      gui  =italic"

" Spell Highlightings
exe "hi SpellBad   guifg="s:nvstar1_gui
exe "hi SpellCap   guifg="s:nvstar1_gui." guibg="s:nvstar8_gui
exe "hi SpellLocal guifg="s:nvstar4_gui
exe "hi SpellRare  guifg="s:nvstar5_gui

" Diff Highlightings
exe "hi DiffAdd    guifg="s:nvstar2_gui." guibg="s:nvstarbg_gui
exe "hi DiffChange guifg="s:nvstar5_gui." guibg="s:nvstarbg_gui
exe "hi DiffDelete guifg="s:nvstar1_gui." guibg="s:nvstarbg_gui
exe "hi DiffText   guifg="s:nvstar2_gui." guibg="s:nvstarbg_gui

" GitGutter Highlightings
exe "hi GitGutterAdd                  guifg=#367E18"
exe "hi GitGutterChange               guifg=#F57328"
exe "hi GitGutterDelete               guifg=#CC3636"
exe "hi GitGutterChangeDelete         guifg=#F2D388"
exe "hi GitGutterLineHighlightsEnable guifg="s:nvstar9_gui." guibg="s:nvstar8_gui

" Nvim-Treesitter Highlights
exe "hi TSAttribute          guifg="s:nvstar4_gui
exe "hi TSBoolean            guifg="s:nvstar6_gui
exe "hi TSCharacter          guifg="s:nvstar4_gui
exe "hi TSComment            guifg="s:nvstar8_gui
exe "hi TSConditional        guifg="s:nvstar1_gui
exe "hi TSConstant           guifg="s:nvstar6_gui
exe "hi TSConstBuiltin       guifg="s:nvstar4_gui
exe "hi TSConstMacro         guifg="s:nvstar3_gui
exe "hi TSConstructor        guifg="s:nvstar4_gui
exe "hi TSException          guifg="s:nvstar8_gui
exe "hi TSField              guifg="s:nvstar1_gui
exe "hi TSFloat              guifg="s:nvstar8_gui
exe "hi TSFunction           guifg="s:nvstar1_gui
exe "hi TSFuncMacro          guifg="s:nvstar2_gui
exe "hi TSInclude            guifg="s:nvstar9_gui
exe "hi TSKeyword            guifg="s:nvstar5_gui
exe "hi TSKeywordFunction    guifg="s:nvstar4_gui
exe "hi TSKeywordReturn      guifg="s:nvstar4_gui
exe "hi TSLabel              guifg="s:nvstar4_gui
exe "hi TSNamespace          guifg="s:nvstar9_gui
exe "hi TSNumber             guifg="s:nvstar3_gui
exe "hi TSParameter          guifg="s:nvstar1_gui
exe "hi TSParameterReference guifg="s:nvstar9_gui
exe "hi TSProperty           guifg="s:nvstar1_gui
exe "hi TSPunctDelimiter     guifg="s:nvstar7_gui
exe "hi TSPunctBracket       guifg="s:nvstar7_gui
exe "hi TSPunctSpecial       guifg="s:nvstar7_gui
exe "hi TSString             guifg="s:nvstar2_gui
exe "hi TSStringRegex        guifg="s:nvstar2_gui
exe "hi TSStringEscape       guifg="s:nvstar4_gui
exe "hi TSStringSpecial      guifg="s:nvstar4_gui
exe "hi TSSymbol             guifg="s:nvstar1_gui
exe "hi TSTag                guifg="s:nvstar4_gui
exe "hi TSTagAttribute       guifg="s:nvstar1_gui
exe "hi TSTagDelimiter       guifg="s:nvstar7_gui
exe "hi TSText               guifg="s:nvstar7_gui
exe "hi TSStrong             guifg="s:nvstar7_gui
exe "hi TSUnderline          guifg="s:nvstar5_gui
exe "hi TSStrike             guifg="s:nvstar7_gui
exe "hi TSTitle              guifg="s:nvstar3_gui
exe "hi TSLiteral            guifg="s:nvstar2_gui
exe "hi TSURI                guifg="s:nvstar3_gui
exe "hi TSMath               guifg="s:nvstar6_gui
exe "hi TSTextReference      guifg="s:nvstar6_gui
exe "hi TSEnvirontment       guifg="s:nvstar5_gui
exe "hi TSEnvironmentName    guifg="s:nvstar3_gui
exe "hi TSNote               guifg="s:nvstar8_gui
exe "hi TSDanger             guifg="s:nvstar8_gui
exe "hi TSType               guifg="s:nvstar3_gui
exe "hi TSTypeBuiltin        guifg="s:nvstar3_gui
exe "hi TSVariable           guifg="s:nvstar7_gui
exe "hi TSVariableBuiltin    guifg="s:nvstar4_gui
exe "hi TSFuncBuiltin        guifg="s:nvstar14_gui
exe "hi TsKeywordOperator    guifg="s:nvstar12_gui
exe "hi TSMethod             guifg="s:nvstar12_gui
exe "hi TSRepeat             guifg="s:nvstar11_gui
exe "hi TSWarning            guifg="s:nvstar0_gui
exe "hi TSEmphasis           gui  =italic           guifg="s:nvstar7_gui

" C Language Higlights
"exe "hi cConstant         guifg="s:nvstar4_gui
"exe "hi cCppBracket       guifg="s:nvstar7_gui
"exe "hi cCppInElse        guifg="s:nvstar7_gui
"exe "hi cCppInElse2       guifg="s:nvstar7_gui
"exe "hi cCppInIf          guifg="s:nvstar4_gui
"exe "hi cCppInSkip        guifg="s:nvstar7_gui
"exe "hi cCppInWapper      guifg="s:nvstar5_gui
"exe "hi cCppOutElse       guifg="s:nvstar7_gui
"exe "hi cCppOutIf         guifg="s:nvstar8_gui
"exe "hi cCppOutIf2        guifg="s:nvstar8_gui
"exe "hi cCppOutInGroup    guifg="s:nvstar8_gui
"exe "hi cCppOutSkip       guifg="s:nvstar8_gui
"exe "hi cCppOutWrapper    guifg="s:nvstar5_gui
"exe "hi cCppParen         guifg="s:nvstar7_gui
"exe "hi cFloat            guifg="s:nvstar8_gui
"exe "hi cFormat           guifg="s:nvstar4_gui
"exe "hi cMutli            guifg="s:nvstar3_gui
"exe "hi cOperator         guifg="s:nvstar4_gui
"exe "hi cParen            guifg="s:nvstar3_gui
"exe "hi PreProcGroup      guifg="s:nvstar4_gui
"exe "hi cSpaceError       guifg="s:nvstar1_gui
"exe "hi cSpecial          guifg="s:nvstar4_gui
"exe "hi cSpecialCharacter guifg="s:nvstar4_gui
"exe "hi cStatement        guifg="s:nvstar5_gui
"exe "hi cStorageClass     guifg="s:nvstar3_gui
"exe "hi cString           guifg="s:nvstar2_gui
"exe "hi cType             guifg="s:nvstar3_gui
"exe "hi cUserCont         guifg="s:nvstar7_gui
"exe "hi cCppString        guifg="s:nvstar2_gui
"exe "hi cCurlyError       guifg="s:nvstar7_gui." guibg="s:nvstar9_gui
"exe "hi cErrInBracket     guifg="s:nvstar7_gui." guibg="s:nvstar9_gui
"exe "hi cErrInParen       guifg="s:nvstar7_gui." guibg="s:nvstar9_gui
"exe "hi cParenError       guifg="s:nvstar7_gui." guibg="s:nvstar9_gui

" GoLang Highlight Groups
exe "hi goExtraType         guifg="s:nvstar3_gui
exe "hi goHexadecimalInt    guifg="s:nvstar3_gui
exe "hi goImaginary         guifg="s:nvstar3_gui
exe "hi goLabel             guifg="s:nvstar3_gui
exe "hi goOctalError        guifg="s:nvstar1_gui
exe "hi goParen             guifg="s:nvstar7_gui
exe "hi goRepeat            guifg="s:nvstar3_gui
exe "hi goStatement         guifg="s:nvstar1_gui
exe "hi goTSComment         guifg="s:nvstar8_gui
exe "hi goTSFunction        guifg="s:nvstar4_gui
exe "hi goTSInclude         guifg="s:nvstar4_gui
exe "hi goTSkeyword         guifg="s:nvstar5_gui
exe "hi goTSKeywordFunction guifg="s:nvstar5_gui
exe "hi goTSMethod          guifg="s:nvstar4_gui
exe "hi goTSNumber          guifg="s:nvstar8_gui
exe "hi goTSProperty        guifg="s:nvstar1_gui
exe "hi goTSPunctBracket    guifg="s:nvstar6_gui
exe "hi goTSRepeat          guifg="s:nvstar3_gui
exe "hi goTSType            guifg="s:nvstar3_gui
exe "hi goTSTypeBuiltin     guifg="s:nvstar3_gui
exe "hi goTSVariable        guifg="s:nvstar5_gui
exe "hi goTodo              guifg="s:nvstar3_gui
exe "hi goType              guifg="s:nvstar3_gui
exe "hi goBlock             guifg="s:nvstar7_gui
exe "hi goCharacter         guifg="s:nvstar1_gui
exe "hi goComment           guifg="s:nvstar8_gui
exe "hi goComplexes         guifg="s:nvstar3_gui
exe "hi goConditional       guifg="s:nvstar5_gui
exe "hi goConstants         guifg="s:nvstar5_gui
exe "hi goDecimalInt        guifg="s:nvstar3_gui
exe "hi goDeclaration       guifg="s:nvstar5_gui
exe "hi goDirective         guifg="s:nvstar1_gui
exe "hi goEscapeC           guifg="s:nvstar4_gui
exe "hi goEscapeBigU        guifg="s:nvstar4_gui
exe "hi goEscapeOctal       guifg="s:nvstar4_gui
exe "hi goEscapeU           guifg="s:nvstar4_gui
exe "hi goEscapeX           guifg="s:nvstar4_gui
exe "hi goFloat             guifg="s:nvstar11_gui
exe "hi goBuiltins          guifg="s:nvstar13_gui
exe "hi goDeclType          guifg="s:nvstar13_gui
exe "hi goFloats            guifg="s:nvstar12_gui
exe "hi goOctalInt          guifg="s:nvstar11_gui
exe "hi goRawString         guifg="s:nvstar10_gui
exe "hi goSignedInts        guifg="s:nvstar11_gui
exe "hi goSpecialString     guifg="s:nvstar12_gui
exe "hi goString            guifg="s:nvstar10_gui
exe "hi goTSOperator        guifg="s:nvstar12_gui
exe "hi goTSPunctDelimiter  guifg="s:nvstar13_gui
exe "hi goTSString          guifg="s:nvstar10_gui
exe "hi goEscapeError       guifg="s:nvstar0_gui." guibg="s:nvstar1_gui
exe "hi goSpaceError        guifg="s:nvstar0_gui." guibg="s:nvstar1_gui

" NvimTree Highlights
exe "hi NvimTreeFileDirty        guifg="s:nvstar1_gui
exe "hi NvimTreeGitDirty         guifg="s:nvstar1_gui
exe "hi NvimTreeGitDeleted       guifg="s:nvstar1_gui
exe "hi NvimTreeRootFolder       guifg="s:nvstar5_gui
exe "hi NvimTreeIndentMarker     guifg="s:nvstar8_gui
exe "hi NvimTreeFolderIcon       guifg="s:nvstar11_gui
exe "hi NvimTreeFoldername       guifg="s:nvstarfg_gui
exe "hi NvimTreeOpenedFolderName guifg="s:nvstarfg_gui
exe "hi NvimTreeEmptyFolderName  guifg="s:nvstar11_gui
exe "hi NvimTreeExecFile         guifg="s:nvstarfg_gui

" Notifications
exe "hi NotifyERRORIcon    guibg="s:nvstarbg_alt. " guifg="s:nvstar9_gui
exe "hi NotifyWARNIcon     guibg="s:nvstarbg_alt. " guifg="s:nvstar3_gui
exe "hi NotifyINFOIcon     guibg="s:nvstarbg_alt. " guifg="s:nvstar4_gui
exe "hi NotifyDEBUGIcon    guibg="s:nvstarbg_alt. " guifg="s:nvstar5_gui
exe "hi NotifyTRACEIcon    guibg="s:nvstarbg_alt. " guifg="s:nvstar6_gui
exe "hi NotifyERRORTitle   guibg="s:nvstarbg_alt. " guifg="s:nvstar9_gui
exe "hi NotifyWARNTitle    guibg="s:nvstarbg_alt. " guifg="s:nvstar3_gui
exe "hi NotifyINFOTitle    guibg="s:nvstarbg_alt. " guifg="s:nvstar4_gui
exe "hi NotifyDEBUGTitle   guibg="s:nvstarbg_alt. " guifg="s:nvstar5_gui
exe "hi NotifyTRACETitle   guibg="s:nvstarbg_alt. " guifg="s:nvstar6_gui
exe "hi NotifyERRORBorder  guifg="s:nvstarbg_alt. " guibg="s:nvstarbg_alt
exe "hi NotifyWARNBorder   guifg="s:nvstarbg_alt. " guibg="s:nvstarbg_alt
exe "hi NotifyINFOBorder   guifg="s:nvstarbg_alt. " guibg="s:nvstarbg_alt
exe "hi NotifyDEBUGBorder  guifg="s:nvstarbg_alt. " guibg="s:nvstarbg_alt
exe "hi NotifyTRACEBorder  guifg="s:nvstarbg_alt. " guibg="s:nvstarbg_alt
exe "hi NotifyERRORBody    guibg="s:nvstarbg_alt. " guifg="s:nvstarfg_gui
exe "hi NotifyWARNBody     guibg="s:nvstarbg_alt. " guifg="s:nvstarfg_gui
exe "hi NotifyINFOBody     guibg="s:nvstarbg_alt. " guifg="s:nvstarfg_gui
exe "hi NotifyDEBUGBody    guibg="s:nvstarbg_alt. " guifg="s:nvstarfg_gui
exe "hi NotifyTRACEBody    guibg="s:nvstarbg_alt. " guifg="s:nvstarfg_gui

" NVim GUI
exe "hi SignColumn guibg=#0f0f0f"


exe "hi luaError guibg=NONE guifg="s:nvstar1_gui

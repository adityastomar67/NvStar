local Wave = {}
local Theme = {}
local ts_colors = {
    white        = "#ffffff",
    yellow       = "#cfcf60",
    red          = "#af3030",
    green        = "#303fa0",
    darker_black = "#070a0e",
    black        = '#0a0d11',
    black2       = "#171b20",
}
local c = {
    white    = '#ffffff',
    black    = '#000000',
    none     = 'NONE',
    search   = '#ADE792',
    wavealt  = '#18181a',
    wavealt2 = '#dfdee0',
    col9     = '#ec6e74',
    col3     = '#e1b56a',
    col4     = '#6d92b7',
    col5     = '#be67d5',
    col6     = '#679ca6',
  }

  if vim.o.background == 'dark' then
    if vim.g.Wave_mirage then
      -- basics
      c.accent             = '#ffcc66'
      c.bg                 = '#212733'
      c.fg                 = '#d9d7ce'
      c.fg_idle            = '#607080'
      -- editor
      c.comment            = '#5c6773'
      c.constant           = '#d4bfff'
      c.entity             = '#73d0ff'
      c.error              = '#ff3333'
      c.func               = '#ffd57f'
      c.keyword            = '#ffae57'
      c.line               = '#242b38'
      c.markup             = '#f07178'
      c.operator           = '#80d4ff'
      c.regexp             = '#95e6cb'
      c.special            = '#ffc44c'
      c.string             = '#bbe67e'
      c.tag                = '#5ccfe6'
      c.ui                 = '#707a8c'
      c.warning            = '#ffa759'
      -- gui
      c.guide_active       = '#576070'
      c.guide_normal       = '#3d4751'
      c.gutter_active      = '#5f687a'
      c.gutter_normal      = '#404755'
      c.panel_bg           = '#272d38'
      c.panel_border       = '#101521'
      c.panel_shadow       = '#141925'
      c.selection_bg       = '#33415e'
      c.selection_border   = '#232a4c'
      c.selection_inactive = '#343f4c'
      -- vcs
      c.vcs_added          = '#a6cc70'
      c.vcs_added_bg       = '#313d37'
      c.vcs_diff_text      = '#465742'
      c.vcs_modified       = '#77a8d9'
      c.vcs_modified_bg    = '#323a4c'
      c.vcs_removed        = '#f27983'
      c.vcs_removed_bg     = '#3e373a'
    else
      -- basics
      c.accent             = '#f29718'
      c.bg                 = '#0f1419'
      c.fg                 = '#e6e1cf'
      c.fg_idle            = '#3e4b59'
      -- editor
      c.comment            = '#5c6773'
      c.constant           = '#ffee99'
      c.entity             = '#59c2ff'
      c.error              = '#ff3333'
      c.func               = '#ffb454'
      c.keyword            = '#ff7733'
      c.line               = '#151a1e'
      c.markup             = '#f07178'
      c.operator           = '#e7c547'
      c.regexp             = '#95e6cb'
      c.special            = '#e6b673'
      c.string             = '#b8cc52'
      c.tag                = '#36a3d9'
      c.ui                 = '#4d5566'
      c.warning            = '#ff8f40'
      -- gui
      c.guide_active       = '#393f4d'
      c.guide_normal       = '#2d3640'
      c.gutter_active      = '#464d5e'
      c.gutter_normal      = '#323945'
      c.panel_bg           = '#14191f'
      c.panel_border       = '#000000'
      c.panel_shadow       = '#00010a'
      c.selection_bg       = '#273747'
      c.selection_border   = '#304357'
      c.selection_inactive = '#253340'
      -- vcs
      c.vcs_added          = '#91b362'
      c.vcs_added_bg       = '#1d2214'
      c.vcs_diff_text      = '#363e1c'
      c.vcs_modified       = '#6994bf'
      c.vcs_modified_bg    = '#1b2733'
      c.vcs_removed        = '#d96c75'
      c.vcs_removed_bg     = '#2d2220'
    end
  else
    -- basics
    c.accent             = '#ff6a00'
    c.bg                 = '#fafafa'
    c.fg                 = '#5c6773'
    c.fg_idle            = '#828c99'
    -- editor
    c.comment            = '#abb0b6'
    c.constant           = '#a37acc'
    c.entity             = '#399ee6'
    c.error              = '#ff3333'
    c.func               = '#f29718'
    c.keyword            = '#ff7733'
    c.line               = '#f3f3f3'
    c.markup             = '#f07178'
    c.operator           = '#e7c547'
    c.regexp             = '#4cbf99'
    c.special            = '#e6b673'
    c.string             = '#86b300'
    c.tag                = '#36a3d9'
    c.ui                 = '#8a9199'
    c.warning            = '#fa8d3e'
    -- gui
    c.guide_active       = '#d3d5d8'
    c.guide_normal       = '#d9d8d7'
    c.gutter_active      = '#a0a6ac'
    c.gutter_normal      = '#cdd0d3'
    c.panel_bg           = '#ffffff'
    c.panel_border       = '#f0f0f0'
    c.panel_shadow       = '#ccced0'
    c.selection_bg       = '#d1e4f4'
    c.selection_border   = '#e1e1e2'
    c.selection_inactive = '#f0eee4'
    -- vcs
    c.vcs_added          = '#99bf4d'
    c.vcs_added_bg       = '#e0e7cd'
    c.vcs_diff_text      = '#d3e0af'
    c.vcs_modified       = '#709ecc'
    c.vcs_modified_bg    = '#e7e8e9'
    c.vcs_removed        = '#f27983'
    c.vcs_removed_bg     = '#f9ebe4'
  end

Theme.syntax = function ()
  local syntax = {
    Boolean             = { fg = c.markup },
    Constant            = { fg = c.constant },
    Debug               = { fg = c.accent },
    Define              = { fg = c.keyword },
    Delimiter           = { fg = c.special },
    Error               = { fg = c.error, sp = 'underline' },
    Exception           = { fg = c.markup },
    Float               = { fg = c.markup },
    Ignore              = { fg = c.fg },
    Include             = { fg = c.func },
    Label               = { fg = c.keyword },
    Macro               = { fg = c.special },
    Number              = { fg = c.markup },
    Operator            = { fg = c.operator },
    PreCondit           = { fg = c.special },
    PreProc             = { fg = c.accent },
    Special             = { fg = c.accent },
    Statement           = { fg = c.keyword },
    StorageClass        = { fg = c.special },
    Structure           = { fg = c.special },
    Tag                 = { fg = c.accent },
    Type                = { fg = c.entity },
    Typedef             = { fg = c.accent },
    IncSearch           = { fg = c.search, bg = c.none },
    Underlined          = { fg = c.tag, style = 'underline', sp = c.tag },
  }

  if vim.g.Wave_avoid_italics then
    syntax.Character      = { fg = c.markup }
    syntax.Comment        = { fg = c.comment }
    syntax.Conditional    = { fg = c.keyword }
    syntax.Function       = { fg = c.func }
    syntax.Identifier     = { fg = c.entity }
    syntax.Keyword        = { fg = c.keyword }
    syntax.Repeat         = { fg = c.keyword }
    syntax.SpecialChar    = { fg = c.keyword }
    syntax.SpecialComment = { fg = c.entity }
    syntax.String         = { fg = c.string }
    syntax.Todo           = { fg = c.markup,  style = 'bold' }
  else
    syntax.Character      = { fg = c.markup}
    syntax.Comment        = { fg = c.comment, style = 'italic' }
    syntax.Conditional    = { fg = c.keyword, style = 'italic' }
    syntax.Function       = { fg = c.func,  }
    syntax.Identifier     = { fg = c.entity,  style = 'italic' }
    syntax.Keyword        = { fg = c.keyword }
    syntax.Repeat         = { fg = c.keyword }
    syntax.SpecialChar    = { fg = c.keyword, style = 'italic' }
    syntax.SpecialComment = { fg = c.entity,  style = 'italic' }
    syntax.String         = { fg = c.string,  style = 'italic' }
    syntax.Todo           = { fg = c.markup,  style = 'bold,italic' }
  end

  return syntax
end

Theme.languages = function()
  local html = {
    htmlLink = { fg = c.tag,      style = "underline" },
    htmlH1   = { fg = c.special,  style = "bold,italic" },
    htmlH2   = { fg = c.tag,      style = "bold" },
    htmlH3   = { fg = c.accent,   style = "italic" },
    htmlH4   = { fg = c.entity },
    htmlH5   = { fg = c.keyword,  style = "bold" },
  }
  local markdown = {
    markdownH1          = { fg = c.special,  style = "bold,italic" },
    markdownH2          = { fg = c.tag,      style = "bold" },
    markdownH3          = { fg = c.accent,   style = "italic" },
    markdownH4          = { fg = c.entity },
    markdownCode        = { fg = c.fg,       style = "italic" },
    markdownCodeBlock   = { fg = c.fg,       style = "italic" },
    markdownH1Delimiter = { fg = c.special,  style = "bold,italic" },
    markdownH2Delimiter = { fg = c.tag ,     style = "bold" },
    markdownH3Delimiter = { fg = c.accent,   style = "italic" },
    markdownH4Delimiter = { fg = c.entity },
  }
  return vim.tbl_extend('error',
    html,
    markdown
  )
end

Theme.editor = function ()
  return {
    ColorColumn       = { bg = c.line },
    Conceal           = { fg = c.comment },
    CursorColumn      = { bg = c.line },
    CursorLine        = { bg = c.line },
    CursorLineConceal = { fg = c.guide_normal, bg = c.line },
    CursorLineNr      = { fg = c.accent, bg = c.none },
    DiffAdd           = { bg = c.vcs_added_bg },
    DiffAdded         = { fg = c.vcs_added },
    DiffChange        = { bg = c.vcs_modified_bg },
    DiffDelete        = { bg = c.vcs_removed_bg },
    DiffRemoved       = { fg = c.vcs_removed },
    DiffText          = { bg = c.vcs_diff_text },
    Directory         = { fg = c.func },
    ErrorMsg          = { fg = c.error},
    FloatBorder       = { fg = c.panel_border, bg = c.bg },
    FoldColumn        = { bg = c.bg },
    Folded            = { fg = c.fg_idle, bg = c.panel_bg },
    IncSearch         = { fg = c.keyword, bg = c.ui },
    LineNr            = { fg = c.guide_normal },
    MatchParen        = { style = 'underline', sp = c.func },
    MsgSeparator      = { fg = c.none, bg = c.none },
    ModeMsg           = { fg = c.string },
    MoreMsg           = { fg = c.string },
    NonText           = { fg = c.guide_normal },
    Normal            = { fg = c.fg, bg = c.none },
    NormalFloat       = { fg = c.fg,      bg = c.bg },
    Pmenu             = { fg = c.fg,      bg = c.selection_inactive },
    PmenuSbar         = { fg = c.accent,  bg = c.selection_inactive },
    PmenuSel          = { fg = c.accent,  bg = c.selection_inactive, style = 'reverse' },
    PmenuThumb        = { fg = c.fg,      bg = c.accent },
    Question          = { fg = c.string },
    QuickFixLine      = { fg = c.special, bg = c.guide_normal },
    Search            = { fg = c.bg,      bg = c.constant },
    SignColumn        = { fg = c.fg, bg = c.none },
    SpecialKey        = { fg = c.selection_inactive },
    SpellBad          = { style = 'undercurl', sp = c.error },
    SpellCap          = { style = 'undercurl', sp = c.tag },
    SpellLocal        = { style = 'undercurl', sp = c.keyword },
    SpellRare         = { style = 'undercurl', sp = c.regexp },
    StatusLine        = { fg = c.fg,      bg = c.panel_bg },
    StatusLineNC      = { fg = c.fg_idle, bg = c.panel_bg },
    StatusLineTerm    = { fg = c.fg,      bg = c.panel_bg },
    StatusLineTermNC  = { fg = c.fg_idle, bg = c.panel_bg },
    TabLine           = { fg = c.comment, bg = c.panel_shadow },
    TabLineFill       = { fg = c.fg,      bg = c.panel_border },
    TabLineSel        = { fg = c.fg,      bg = c.bg },
    Title             = { fg = c.keyword },
    VertSplit         = { fg = c.none, bg = c.none },
    Visual            = { bg = c.selection_inactive },
    VisualNOS         = { bg = c.selection },
    WarningMsg        = { fg = c.warning },
    WildMenu          = { fg = c.fg, bg = c.markup },
    healthError       = { fg = c.error },
    healthSuccess     = { fg = c.string },
    healthWarning     = { fg = c.warning },
    qfLineNr          = { fg = c.keyword },
  }
end

Theme.terminal = function ()
  vim.g.terminal_color_0  = c.bg
  vim.g.terminal_color_1  = c.markup
  vim.g.terminal_color_2  = c.string
  vim.g.terminal_color_3  = c.accent
  vim.g.terminal_color_4  = c.tag
  vim.g.terminal_color_5  = c.constant
  vim.g.terminal_color_6  = c.regexp
  vim.g.terminal_color_7  = c.black
  vim.g.terminal_color_8  = c.fg_idle
  vim.g.terminal_color_9  = c.error
  vim.g.terminal_color_10 = c.string
  vim.g.terminal_color_11 = c.accent
  vim.g.terminal_color_12 = c.tag
  vim.g.terminal_color_13 = c.constant
  vim.g.terminal_color_14 = c.regexp
  vim.g.terminal_color_15 = c.comment
end

Theme.treesitter = function ()
  local treesitter = {
    TSAttribute          = { fg = c.accent },
    TSBoolean            = { fg = c.markup },
    TSConstBuiltin       = { fg = c.constant, style = 'italic' },
    TSConstMacro         = { fg = c.constant, style = 'bold' },
    TSConstant           = { fg = c.constant },
    TSConstructor        = { fg = c.entity },
    TSDanger             = { fg = c.error, style = 'standout' },
    TSEmphasis           = { fg = c.special, style = 'italic' },
    TSEnvironmentName    = { fg = c.entity, style = 'italic'  },
    TSEnvironment        = { fg = c.func },
    TSError              = { fg = c.error },
    TSException          = { fg = c.constant },
    TSField              = { fg = c.entity },
    TSFloat              = { fg = c.accent },
    TSFuncMacro          = { fg = c.entity },
    TSInclude            = { fg = c.special, style = 'bold,italic' },
    TSKeywordOperator    = { fg = c.regexp },
    TSKeywordReturn      = { fg = c.entity, style = 'bold,italic' },
    TSLabel              = { fg = c.accent, style = 'italic' },
    TSLiteral            = { fg = c.fg },
    TSMath               = { fg = c.operator },
    TSNamespace          = { fg = c.constant },
    TSNone               = { fg = c.fg },
    TSNote               = { fg = c.comment },
    TSNumber             = { fg = c.markup },
    TSOperator           = { fg = c.special },
    TSParameter          = { fg = c.tag, style = 'italic' },
    TSParameterReference = { fg = c.tag },
    TSProperty           = { fg = c.fg, style = 'italic' },
    TSPunctBracket       = { fg = c.special },
    TSPunctDelimiter     = { fg = c.special },
    TSPunctSpecial       = { fg = c.special },
    TSStrike             = { fg = c.fg, style = 'strikethrough' },
    TSStrong             = { fg = c.fg,  style = 'bold' },
    TSSymbol             = { fg = c.constant },
    TSTag                = { fg = c.accent },
    TSTagDelimiter       = { fg = c.constant },
    TSText               = { fg = c.accent },
    TSTextReference      = { fg = c.constant },
    TSTitle              = { fg = c.ui, style = 'bold' },
    TSType               = { fg = c.keyword },
    TSTypeBuiltin        = { fg = c.keyword },
    TSURI                = { fg = c.tag },
    TSUnderline          = { sp = c.tag, style = 'underline' },
    TSWarning            = { fg = c.warning },
  }

  if vim.g.Wave_avoid_italics then
    treesitter.TSCharacter       = { fg = c.markup }
    treesitter.TSComment         = { fg = c.comment }
    treesitter.TSConditional     = { fg = c.keyword }
    treesitter.TSFuncBuiltin     = { fg = c.special }
    treesitter.TSFunction        = { fg = c.func }
    treesitter.TSKeyword         = { fg = c.keyword, style = 'bold' }
    treesitter.TSKeywordFunction = { fg = c.func }
    treesitter.TSMethod          = { fg = c.func }
    treesitter.TSRepeat          = { fg = c.keyword }
    treesitter.TSString          = { fg = c.string }
    treesitter.TSStringEscape    = { fg = c.fg }
    treesitter.TSStringRegex     = { fg = c.func }
    treesitter.TSStringSpecial   = { fg = c.string, style = 'bold' }
    treesitter.TSVariable        = { fg = c.entity }
    treesitter.TSVariableBuiltin = { fg = c.entity }
  else
    treesitter.TSCharacter       = { fg = c.markup, style = 'italic' }
    treesitter.TSComment         = { fg = c.comment, style = 'italic' }
    treesitter.TSConditional     = { fg = c.keyword, style = 'italic' }
    treesitter.TSFuncBuiltin     = { fg = c.special, style = 'italic' }
    treesitter.TSFunction        = { fg = c.func,    style = 'italic' }
    treesitter.TSKeyword         = { fg = c.keyword, style = 'bold,italic' }
    treesitter.TSKeywordFunction = { fg = c.func,    style = 'italic' }
    treesitter.TSMethod          = { fg = c.func,    style = 'italic' }
    treesitter.TSRepeat          = { fg = c.keyword, style = 'italic' }
    treesitter.TSString          = { fg = c.string, style = 'italic' }
    treesitter.TSStringEscape    = { fg = c.fg,     style = 'italic' }
    treesitter.TSStringRegex     = { fg = c.func,   style = 'italic' }
    treesitter.TSStringSpecial   = { fg = c.string, style = 'bold,italic' }
    treesitter.TSVariable        = { fg = c.entity, style = 'italic' }
    treesitter.TSVariableBuiltin = { fg = c.entity, style = 'italic' }
  end

  return treesitter
end

Theme.lsp = function ()
  return {
    LspCodeLens                          = { fg = c.comment },
    LspDiagnosticsDefaultError           = { fg = c.error },
    LspDiagnosticsDefaultHint            = { fg = c.regexp  },
    LspDiagnosticsDefaultInformation     = { fg = c.tag },
    LspDiagnosticsDefaultWarning         = { fg = c.keyword },
    LspDiagnosticsError                  = { fg = c.error },
    LspDiagnosticsFloatingError          = { fg = c.error },
    LspDiagnosticsFloatingHint           = { fg = c.regexp  },
    LspDiagnosticsFloatingInformation    = { fg = c.tag },
    LspDiagnosticsFloatingWarning        = { fg = c.keyword },
    LspDiagnosticsHint                   = { fg = c.keyword },
    LspDiagnosticsInformation            = { fg = c.tag },
    LspDiagnosticsSignError              = { fg = c.error },
    LspDiagnosticsSignHint               = { fg = c.regexp  },
    LspDiagnosticsSignInformation        = { fg = c.tag },
    LspDiagnosticsSignWarning            = { fg = c.keyword },
    LspDiagnosticsUnderlineError         = { style = 'undercurl', sp = c.error },
    LspDiagnosticsUnderlineHint          = { style = 'undercurl', sp = c.regexp },
    LspDiagnosticsUnderlineInformation   = { style = 'undercurl', sp = c.tag },
    LspDiagnosticsUnderlineWarning       = { style = 'undercurl', sp = c.keyword },
    LspDiagnosticsVirtualTextError       = { fg = c.error },
    LspDiagnosticsVirtualTextHint        = { fg = c.regexp },
    LspDiagnosticsVirtualTextInformation = { fg = c.tag },
    LspDiagnosticsVirtualTextWarning     = { fg = c.keyword },
    LspDiagnosticsWarning                = { fg = c.regexp },
    LspReferenceRead                     = { fg = c.accent, bg = c.panel_bg },
    LspReferenceText                     = { fg = c.accent, bg = c.panel_bg },
    LspReferenceWrite                    = { fg = c.accent, bg = c.panel_bg },
  }
end

Theme.plugins = function()
  local telescope = {
    TelescopeBorder            = { fg = "#1b1f27", bg = "#1b1f27" },
    TelescopePromptBorder      = { fg = "#252931", bg = "#252931" },
    TelescopePromptNormal      = { fg = "#abb2bf", bg = "#252931" },
    TelescopePromptPrefix      = { fg = "#e06c75", bg = "#252931" },
    TelescopePreviewTitle      = { fg = "#1e222a", bg = "#98c379" },
    TelescopePromptTitle       = { fg = "#1e222a", bg = "#e06c75" },
    TelescopeResultsTitle      = { fg = "#1b1f27", bg = "#1b1f27" },
    TelescopeSelection         = { bg = "#252931", fg = "#abb2bf" },
    TelescopeNormal            = { bg = "#1b1f27" },
    TelescopeResultsDiffAdd    = { fg = "#98c379" },
    TelescopeResultsDiffChange = { fg = "#e7c787" },
    TelescopeResultsDiffDelete = { fg = "#e06c75" }
    }
  local whichkey = {
    WhichKey       = { fg = c.fg },
    WhichKeyBorder = { fg = c.entity },
  }
  local bufferline = {
    BufferLineIndicatorSelected = { fg = c.accent },
    BufferLineFill              = { bg = c.bg },
  }
  local cmp = {
    CmpItemAbbr              = { fg = "#abb2bf" },
    CmpItemAbbrMatch         = { fg = "#61afef", style = "bold" },
    CmpBorder                = { fg = "#42464e" },
    CmpDocBorder             = { fg = "#1b1f27", bg = c.none },
    CmPmenu                  = { bg = c.none },
    CmpItemKind              = { fg = c.accent, style = 'italic' },
    PmenuSel                 = { fg = c.none   , bg   = c.none  },
    Pmenu                    = { fg = "#C5CDD9", bg   = c.none },
    CmpItemAbbrDeprecated    = { fg = "#7E8294", bg   = c.none, style = "strikethrough" },
    CmpItemAbbrMatchFuzzy    = { fg = "#82AAFF", bg   = c.none, style = "bold" },
    CmpItemMenu              = { fg = "#C792EA", bg   = c.none },
    CmpItemKindField         = { fg = "#e06c75", bg   = c.none },
    CmpItemKindIdentifier    = { fg = "#e06c75", bg   = c.none },
    CmpItemKindEvent         = { fg = "#EED8DA", bg   = c.none },
    CmpItemKindText          = { fg = "#98c379", bg   = c.none },
    CmpItemKindEnum          = { fg = "#C3E88D", bg   = c.none },
    CmpItemKindConstant      = { fg = "#d19a66", bg   = c.none },
    CmpItemKindConstructor   = { fg = "#61afef", bg   = c.none },
    CmpItemKindCopilot       = { fg = "#98c379", bg   = c.none },
    CmpItemKindFunction      = { fg = "#61afef", bg   = c.none },
    CmpItemKindClass         = { fg = "#EADFF0", bg   = c.none },
    CmpItemKindModule        = { fg = "#e5c07b", bg   = c.none },
    CmpItemKindType          = { fg = "#e5c07b", bg   = c.none },
    CmpItemKindReference     = { fg = "#abb2bf", bg   = c.none },
    CmpItemKindOperator      = { fg = "#abb2bf", bg   = c.none },
    CmpItemKindVariable      = { fg = "#c678dd", bg   = c.none },
    CmpItemKindStructure     = { fg = "#c678dd", bg   = c.none },
    CmpItemKindStruct        = { fg = "#c678dd", bg   = c.none },
    CmpItemKindUnit          = { fg = "#c678dd", bg   = c.none },
    CmpItemKindSnippet       = { fg = "#e06c75", bg   = c.none },
    CmpItemKindKeyword       = { fg = "#c8ccd4", bg   = c.none },
    CmpItemKindFile          = { fg = "#c8ccd4", bg   = c.none },
    CmpItemKindFolder        = { fg = "#c8ccd4", bg   = c.none },
    CmpItemKindMethod        = { fg = "#61afef", bg   = c.none },
    CmpItemKindValue         = { fg = "#DDE5F5", bg   = c.none },
    CmpItemKindEnumMember    = { fg = "#DDE5F5", bg   = c.none },
    CmpItemKindInterface     = { fg = "#D8EEEB", bg   = c.none },
    CmpItemKindColor         = { fg = "#e06c75", bg   = c.none },
    CmpItemKindProperty      = { fg = "#e06c75", bg   = c.none },
    CmpItemKindTypeParameter = { fg = "#e06c75", bg   = c.none },
  }
  local gitsigns = {
    GitSignsAdd      = { fg = c.vcs_added },
    GitSignsAddNr    = { fg = c.vcs_added },
    GitSignsAddLn    = { fg = c.vcs_added },
    GitSignsChange   = { fg = c.vcs_modified },
    GitSignsChangeNr = { fg = c.vcs_modified },
    GitSignsChangeLn = { fg = c.vcs_modified },
    GitSignsDelete   = { fg = c.vcs_removed },
    GitSignsDeleteNr = { fg = c.vcs_removed },
    GitSignsDeleteLn = { fg = c.vcs_removed },
  }
  local indentblankline = {
    IndentBlanklineChar               = { fg = c.guide_active },
    IndentBlanklineContextChar        = { fg = c.guide_active },
    IndentBlanklineSpaceChar          = { fg = c.guide_active },
    IndentBlanklineSpaceCharBlankline = { fg = c.guide_active },
  }
  local nvimtree = {
    NvimTreeEmptyFolderName  = { fg = c.fg },
    NvimTreeExecFile         = { fg = c.fg },
    NvimTreeFolderIcon       = { fg = c.accent },
    NvimTreeFolderName       = { fg = c.special },
    NvimTreeImageFile        = { fg = c.constant },
    NvimTreeIndentMarker     = { fg = c.guide_normal },
    NvimTreeMarkdownFile     = { fg = c.error, style = 'italic' },
    NvimTreeNormal           = { fg = c.fg,     bg = c.none },
    NvimTreeOpenedFile       = { fg = c.entity, style = 'italic' },
    NvimTreeOpenedFolderName = { fg = c.entity },
    NvimTreeRootFolder       = { fg = c.keyword, style = 'bold,italic' },
    NvimTreeSpecialFile      = { fg = c.special },
    NvimTreeSymlink          = { fg = c.tag },
    NvimTreeWindowPicker     = { fg = c.constant, bg = c.panel_border, style = 'bold' },

    NvimTreeGitDeleted  = { fg = c.vcs_removed },
    NvimTreeGitDirty    = { fg = c.accent },
    NvimTreeGitMerge    = { fg = c.error },
    NvimTreeGitNew      = { fg = c.vcs_added },
    NvimTreeGitRenamed  = { fg = c.vcs_added, style = 'italic' },
    NvimTreeGitStaged   = { fg = c.vcs_modified },
    NvimTreeFileDeleted = { fg = c.vcs_removed },
    NvimTreeFileDirty   = { fg = c.accent },
    NvimTreeFileMerge   = { fg = c.error },
    NvimTreeFileNew     = { fg = c.vcs_added },
    NvimTreeFileRenamed = { fg = c.vcs_added, style = 'italic' },
    NvimTreeFileStaged  = { fg = c.vcs_modified },
  }
  local packer = {
    packerBool             = { fg = c.markup },
    packerFail             = { fg = c.error },
    packerHash             = { fg = c.vcs_added },
    packerOutput           = { fg = c.fg },
    packerPackageName      = { fg = c.entity },
    packerPackageNotLoaded = { fg = c.keyword },
    packerProgress         = { fg = c.constant },
    packerRelDate          = { fg = c.constant },
    packerStatus           = { fg = c.entity },
    packerStatusCommit     = { fg = c.vcs_added },
    packerStatusFail       = { fg = c.error },
    packerStatusSuccess    = { fg = c.special },
    packerString           = { fg = c.string, style = 'italic' },
    packerSuccess          = { fg = c.ui },
    packerTimeHigh         = { fg = c.selection_bg },
    packerTimeLow          = { fg = c.selection_border },
    packerTimeMedium       = { fg = c.selection_inactive },
    packerTrivial          = { fg = c.warning },
    packerWorking          = { fg = c.fg_idle },
  }
  local startify = {
    StartifyBracket = { fg = c.fg_idle },
    StartifyFile    = { fg = c.tag,           style = 'bold' },
    StartifyFooter  = { fg = c.operator },
    StartifyHeader  = { fg = c.operator },
    StartifyNumber  = { fg = c.markup },
    StartifyPath    = { fg = c.gutter_active, style = 'italic' },
    StartifySection = { fg = c.accent },
    StartifySelect  = { fg = c.fg,            style = 'bold' },
    StartifySlash   = { fg = c.fg_idle,       style = 'italic' },
    StartifySpecial = { fg = c.keyword },
    StartifyVar     = { fg = c.constant },
  }
  local notify = {
    NotifyERRORIcon   = { fg = c.col9    , bg = c.wavealt},
    NotifyWARNIcon    = { fg = c.col3    , bg = c.wavealt},
    NotifyINFOIcon    = { fg = c.col4    , bg = c.wavealt},
    NotifyDEBUGIcon   = { fg = c.col5    , bg = c.wavealt},
    NotifyTRACEIcon   = { fg = c.col6    , bg = c.wavealt},
    NotifyERRORTitle  = { fg = c.col9    , bg = c.wavealt},
    NotifyWARNTitle   = { fg = c.col3    , bg = c.wavealt},
    NotifyINFOTitle   = { fg = c.col4    , bg = c.wavealt},
    NotifyDEBUGTitle  = { fg = c.col5    , bg = c.wavealt},
    NotifyTRACETitle  = { fg = c.col6    , bg = c.wavealt},
    NotifyERRORBorder = { fg = c.wavealt , bg = c.wavealt},
    NotifyWARNBorder  = { fg = c.wavealt , bg = c.wavealt},
    NotifyINFOBorder  = { fg = c.wavealt , bg = c.wavealt},
    NotifyDEBUGBorder = { fg = c.wavealt , bg = c.wavealt},
    NotifyTRACEBorder = { fg = c.wavealt , bg = c.wavealt},
    NotifyERRORBody   = { fg = c.wavealt2, bg = c.wavealt},
    NotifyWARNBody    = { fg = c.wavealt2, bg = c.wavealt},
    NotifyINFOBody    = { fg = c.wavealt2, bg = c.wavealt},
    NotifyDEBUGBody   = { fg = c.wavealt2, bg = c.wavealt},
    NotifyTRACEBody   = { fg = c.wavealt2, bg = c.wavealt},
  }
  local termdebug = {
    debugPC         = { fg = c.none,          bg = c.guide_active },
    debugBreakpoint = { fg = c.gutter_normal, bg = c.accent },
  }
  local staline = {
      StalineBranch = { bg = c.none },
      StalineFilename = { fg = c.none, bg = c.none },
  }

  return vim.tbl_extend('error',
    bufferline,
    cmp,
    gitsigns,
    indentblankline,
    nvimtree,
    packer,
    startify,
    termdebug,
    whichkey,
    staline,
    telescope
  )
end

function highlight(group, color)
  local fg    = color.fg    and 'guifg=' .. color.fg    or 'guifg=NONE'
  local bg    = color.bg    and 'guibg=' .. color.bg    or 'guibg=NONE'
  local style = color.style and 'gui='   .. color.style or 'gui=NONE'
  local sp    = color.sp    and 'guisp=' .. color.sp    or ''

  vim.api.nvim_command(string.format(
    'highlight %s %s %s %s %s',
    group, fg, bg, style, sp
  ))
end

function Wave.apply()
  vim.api.nvim_command('highlight clear')
  if vim.fn.exists('syntax_on') then
    vim.api.nvim_command('syntax reset')
  end
  vim.o.termguicolors = true
  vim.g.colors_name   = 'Wave'

  local async
  async = vim.loop.new_async(
    vim.schedule_wrap(
      function ()
        Theme.terminal()
        for group, color in pairs(Theme.plugins()) do
          highlight(group, color)
        end
        for group, color in pairs(Theme.treesitter()) do
          highlight(group, color)
        end
        for group, color in pairs(Theme.lsp()) do
          highlight(group, color)
        end
        for group, color in pairs(Theme.languages()) do
          highlight(group, color)
        end

        async:close()
      end
    )
  )

  for group, color in pairs(Theme.editor()) do
    highlight(group, color)
  end
  for group, color in pairs(Theme.syntax()) do
    highlight(group, color)
  end
  async:send()
  vim.cmd("hi @field guifg=#e1b56a")
end

vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
return Wave.apply()

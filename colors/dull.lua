-- Credits for this colorscheme goes to - https://github.com/Alexis12119/nvim-config

-- set colorscheme style based on time
local colorscheme_by_time = function()
  local time = tonumber(os.date "%H")
  if time >= 0 and time <= 15 then
    return "slime"
  elseif time >= 16 and time <= 17 then
    return "sunset"
  else
    return "night"
  end
end

vim.g.dull_style = colorscheme_by_time()

local Dull = {}
local Color = {}
local Theme = {}
local transparent = {
    transparent        = "NONE",
    cursor_highlight   = "#292e42",
    transparent_header = "#7aa2f7",
}

local night = {
    night_bg         = "#16161E",
    night            = "#1a1b26",
    night_statusline = "#202328",
    night_header     = "#545c7e",
    night_column     = "#292e42",
    sky              = "#7aa2f7",
    border           = "#5F87AF",
    night_separator  = "#101016",
}

local sunset = {
    sunset_bg        = "#140B14",
    dark_red         = "#4D2B39",
    light_red        = "#81454C",
    sunset_root      = "#AF8696",
    sunset_cursor    = "#322E32",
    indicator        = "#D19A66",
    sunset_separator = "#0f080f",
}

local slime = {
    slime_bg        = "#141b1e",
    slime           = "#98be65",
    directory       = "#222A29",
    slime_cursor    = "#242E32",
    slime_column    = "#242E2F",
    slime_border    = "#87AF87",
    slime_separator = "#0f1416",
}

local colors = {
    none            = "NONE",
    bg              = "#121220",
    bg_tabline      = "#101016",
    fg              = "#bbc2cf",
    night2          = "#1a1b26",
    bg_highlight    = "#292e42",
    fg_cursorlinenr = "#AAAAAA",
    bg_dark         = "#1f2335",
    fg_dark         = "#A9B1D6",
    cursor_fg       = "#415062",
    cursor_bg       = "#AbAbAf",
    cyan            = "#7dcfff",
    green           = "#98be65",
    green1          = "#73daca",
    green2          = "#41a6b5",
    green3          = "#449DAB",
    orange          = "#FF8800",
    violet          = "#a9a1e1",
    purple          = "#C678DD",
    magenta         = "#BB9AF7",
    const_orange    = "#D19A66",
    red             = "#db4b4b",
    red1            = "#ec5f67",
    yellow          = "#ECBE7B",
    blue            = "#7aa2f7",
    darkblue        = "#081633",
    blue0           = "#3d59a1",
    blue1           = "#2ac3de",
    blue2           = "#0db9d7",
    blue5           = "#89ddff",
    blue6           = "#b4f9f8",
    blue7           = "#394b70",
    blue8           = "#6183BB",
    blue9           = "#7dcfff",
    root            = "#7aa2f7",
    magenta2        = "#ff007c",
    teal            = "#1abc9c",
    dark3           = "#545c7e",
    dark5           = "#737aa2",
    comment         = "#565f89",
    black           = "#000000",
    fg_gutter       = "#3b4261",
    bg_statusline   = "#16161E",
    terminal_black  = "#414868",
    fg_sidebar      = "#A9B1D6",
    virtual_err     = "#2D202A",
    virtual_info    = "#192B38",
    virtual_warn    = "#2E2A2D",
    virtual_hint    = "#2E2A2D",
}

if vim.g.dull_style == "sunset" then
    Color = vim.tbl_deep_extend("force", {}, colors, sunset)
elseif vim.g.dull_style == "night" then
    Color = vim.tbl_deep_extend("force", {}, colors, night)
elseif vim.g.dull_style == "slime" then
    Color = vim.tbl_deep_extend("force", {}, colors, slime)
elseif vim.g.dull_style == "transparent" then
    Color = vim.tbl_deep_extend("force", {}, colors, transparent)
else
    Color = colors
end

-- Miscellaneous
Theme.highlight = function()
    local syntax = {
        MsgArea = { fg = Color.fg, bg = Color.sunset_bg or Color.slime_bg or Color.night_bg or Color.transparent },
        Conceal = { bg = Color.transparent },
        Normal = { fg = Color.fg, bg = Color.sunset_bg or Color.slime_bg or Color.night_bg or Color.transparent },
        NormalNC = { fg = Color.fg, bg = Color.sunset_bg or Color.slime_bg or Color.night_bg or Color.transparent },
        SignColumn = {
            fg = Color.fg,
            bg = Color.transparent or Color.sunset_bg or Color.slime_bg or Color.night_bg,
        },
        SignColumnSB = {
            fg = Color.fg,
            bg = Color.transparent or Color.sunset_bg or Color.slime_bg or Color.night_bg,
        },
        ColorColumn = {
            fg = Color.none,
            bg = Color.sunset_cursor or Color.slime_column or Color.night_column or Color.cursor_highlight,
        },
        CursorColumn = {
            fg = Color.none,
            bg = Color.sunset_cursor or Color.slime_column or Color.night_column or Color.cursor_highlight,
        },
        LineNr = {
            fg = Color.dark3,
            bg = Color.none or Color.sunset_bg or Color.slime_bg or Color.night_bg,
        },
        CursorLineNr = {
            fg = Color.fg_cursorlinenr,
            bg = Color.sunset_bg or Color.slime_bg or Color.night_bg or Color.transparent,
        },
        Directory = { fg = Color.sunset_root or Color.slime or Color.sky or Color.transparent_header },
        EndOfBuffer = { fg = Color.sunset_bg or Color.slime_bg or Color.night_bg or Color.transparent },
        Substitute = { fg = Color.fg, bg = Color.terminal_black },
        FocusedSymbol = { fg = Color.blue, bg = Color.none },
        Folded = { fg = Color.blue, bg = Color.fg_gutter },
        FoldColumn = { fg = Color.comment, bg = Color.none },
        Keyword = { fg = Color.cursor_bg },
        ModeMsg = { fg = Color.fg_dark, bold = true },
        NonText = { fg = Color.fg_dark },
        Question = { fg = Color.blue },
        Special = { fg = Color.blue },
        SpecialChar = { fg = Color.fg },
        SpecialKey = { fg = Color.fg },
        CursorLine = {
            bg = Color.sunset_cursor or Color.slime_cursor or Color.night_column or Color.cursor_highlight,
        },
        Visual = { bg = Color.bg_highlight },
        VisualNOS = { bg = Color.bg_highlight },
        Title = { fg = Color.blue, bold = true },
        ErrorMsg = { fg = Color.red },
        WarningMsg = { fg = Color.const_orange },
        Whitespace = { fg = Color.fg_gutter },
        WildMenu = { bg = Color.bg_dark },
        Identifier = { fg = Color.magenta },
        Boolean = { fg = Color.yellow },
        Comment = { fg = Color.comment },
        Character = { fg = Color.green },
        Conditional = { fg = Color.purple },
        Constant = { fg = Color.const_orange },
        Define = { fg = Color.purple },
        Delimiter = { fg = Color.fg },
        Exception = { fg = Color.yellow },
        Float = { fg = Color.blue },
        Function = { fg = Color.blue },
        Include = { fg = Color.blue },
        Label = { fg = Color.blue },
        Macro = { fg = Color.const_orange },
        Number = { fg = Color.yellow },
        Operator = { fg = Color.fg },
        PreProc = { fg = Color.cyan },
        PreCondit = { fg = Color.cyan },
        Repeat = { fg = Color.blue },
        Statement = { fg = Color.blue },
        StorageClass = { fg = Color.yellow },
        String = { fg = Color.green },
        Structure = { fg = Color.yellow },
        Tag = { fg = Color.blue },
        Todo = { fg = Color.dark5, bg = Color.bg_highlight },
        Type = { fg = Color.yellow },
        Typedef = { fg = Color.purple },
        Error = { fg = Color.red },

        -- matchparen
        MatchParen = { bold = false, fg = Color.yellow },

        -- Font
        Bold = { bold = true },
        Italic = { italic = true },
        Underlined = { underline = true, sp = Color.dark5 },

        -- Cursor
        TermCursor = { fg = Color.bg_dark, bg = Color.cursor_bg },
        Cursor = { fg = Color.bg, bg = Color.fg },
        lCursor = { fg = Color.bg, bg = Color.fg },
        CursorIM = { fg = Color.bg, bg = Color.fg },

        -- Separator
        VertSplit = { fg = Color.sunset_bg or Color.slime_bg or Color.night_bg or Color.cursor_highlight },
        WinSeparator = { fg = Color.border or Color.light_red or Color.slime_border, bg = Color.none },

        -- Spell
        SpellBad = { sp = Color.red, undercurl = true },
        SpellCap = { sp = Color.const_orange, undercurl = true },
        SpellLocal = { sp = Color.blue, undercurl = true },
        SpellRare = { sp = Color.yellow, undercurl = true },

        --Statusline
        StatusLineNC = { bg = Color.sunset_bg or Color.slime_bg or Color.night_bg or Color.transparent },
        StatusLine = { fg = Color.fg_sidebar, bg = Color.dark_red or Color.slime_column or Color.night },

        -- Float
        NormalFloat = {
            fg = Color.fg,
            bg = Color.sunset_bg or Color.slime_bg or Color.night_bg or Color.transparent,
        },
        FloatBorder = { fg = Color.border or Color.light_red or Color.slime_border, bg = Color.none },

        -- Pmenu
        Pmenu = { fg = "#C0CAF5", bg = Color.night_bg },
        PmenuSel = { bg = "#343A55" },
        PmenuSBar = { bg = "#222229" },
        PmenuThumb = { bg = Color.fg_gutter },

        -- Search
        CurSearch = { link = "IncSearch" },
        Search = { fg = Color.black, bg = Color.blue },
        IncSearch = { fg = Color.black, bg = "#87AF87" },

        htmlH1 = { fg = Color.magenta, bold = true },
        htmlH2 = { fg = Color.blue, bold = true },

        qfLineNr = { link = "CursorLineNr" },
        qfFileName = { fg = Color.none },

        -- Diff
        DiffAdd = { fg = Color.bg_dark, bg = Color.blue },
        DiffChange = { fg = Color.bg_dark, bg = Color.green },
        DiffDelete = { fg = Color.bg_dark, bg = Color.red },
        DiffText = { fg = Color.bg_dark, bg = Color.fg },

        -- Tabline
        TabLine = { bg = Color.bg_statusline, fg = Color.fg },
        TabLineFill = { bg = Color.bg_dark },
        TabLineSel = { fg = Color.fg, bg = Color.night_bg },

        -- Bufferline
        BufferLineSeparator = {
            fg = Color.indicator or Color.slime or Color.sky,
            bg = Color.sunset_separator or Color.slime_separator or Color.night_separator,
        },
        BufferLineFill = { bg = Color.dark_red or Color.directory or Color.night },
        BufferLineIndicatorSelected = {
            fg = Color.indicator or Color.slime or Color.sky or Color.transparent_header,
        },

        -- Trouble
        TroubleText = { fg = Color.fg },
        TroubleCount = { fg = Color.magenta, bg = Color.fg_gutter },
        TroubleNormal = { fg = Color.fg_sidebar, bg = Color.bg_sidebar },

        -- GitGutter
        GitGutterAdd = {
            fg = Color.green,
            bg = Color.sunset_bg or Color.slime_bg or Color.night_bg or Color.transparent,
        },
        GitGutterChange = {
            fg = Color.blue,
            bg = Color.sunset_bg or Color.slime_bg or Color.night_bg or Color.transparent,
        },
        GitGutterDelete = {
            fg = Color.red,
            bg = Color.sunset_bg or Color.slime_bg or Color.night_bg or Color.transparent,
        },

        mkdCodeDelimiter = { bg = Color.terminal_black, fg = Color.fg },
        mkdCodeStart = { fg = Color.red, bold = true },
        mkdCodeEnd = { fg = Color.fg, bold = true },
        markdownHeadingDelimiter = { fg = Color.const_orange, bold = true },
        markdownCode = { fg = Color.blue },
        markdownCodeBlock = { fg = Color.green },
        markdownH1 = { fg = Color.fg, bold = true },
        markdownH2 = { fg = Color.fg, bold = true },
        markdownH3 = { fg = Color.fg, bold = true },
        markdownH4 = { fg = Color.fg, bold = true },
        markdownH5 = { fg = Color.fg, bold = true },
        markdownH6 = { fg = Color.fg, bold = true },
        markdownLinkText = { fg = Color.blue, underline = true, sp = Color.terminal_black },
        markdownLink = { fg = Color.fg, underline = true, sp = Color.cursor_fg },
        markdownUrl = { fg = Color.fg, underline = true, sp = Color.cursor_fg },

        -- Glyph palette
        GlyphPalette1 = { fg = Color.red },
        GlyphPalette2 = { fg = Color.green },
        GlyphPalette3 = { fg = Color.yellow },
        GlyphPalette4 = { fg = Color.blue },
        GlyphPalette6 = { fg = Color.green1 },
        GlyphPalette7 = { fg = Color.fg },
        GlyphPalette9 = { fg = Color.red },

        -- Neovim
        healthError = { fg = Color.red },
        healthSuccess = { fg = Color.green1 },
        healthWarning = { fg = Color.const_orange },

        -- Illuminate
        IlluminatedWord = { bg = Color.fg_gutter },
        IlluminatedCurWord = { bg = Color.fg_gutter },
        IlluminatedWordText = { bg = Color.fg_gutter },
        IlluminatedWordRead = { bg = Color.fg_gutter },
        IlluminatedWordWrite = { bg = Color.fg_gutter },

        -- Treesitter
        -- ["@annotation"] = { link = "PreProc" },
        -- ["@preproc"] = { link = "PreProc" },
        -- ["@debug"] = { fg = Color.red },
        -- ["@variable"] = { fg = Color.fg },
        -- ["@variable.builtin"] = { fg = Color.blue },
        -- ["@none"] = { fg = Color.none },
        -- ["@boolean"] = { fg = Color.magenta },
        -- ["@character"] = { fg = Color.green },
        -- ["@comment"] = { fg = Color.comment },
        -- ["@conceal"] = { fg = Color.fg, bg = Color.none },
        -- ["@conditional"] = { fg = Color.purple },
        -- ["@constant"] = { fg = Color.const_orange },
        -- ["@constant.builtin"] = { fg = Color.const_orange },
        -- ["@constant.macro"] = { fg = Color.const_orange },
        -- ["@constructor"] = { fg = Color.blue },
        -- ["@exception"] = { fg = Color.yellow },
        -- ["@field"] = { fg = Color.green1 },
        -- ["@float"] = { fg = Color.fg },
        -- ["@function.builtin"] = { fg = Color.blue },
        -- ["@function"] = { fg = Color.blue },
        -- ["@function.macro"] = { fg = Color.blue },
        -- ["@include"] = { fg = Color.blue },
        -- ["@keyword"] = { fg = Color.purple },
        -- ["@keyword.function"] = { fg = Color.purple },
        -- ["@keyword.operator"] = { fg = Color.cyan },
        -- ["@operator"] = { fg = Color.fg },
        -- ["@label"] = { fg = Color.magenta },
        -- ["@method"] = { fg = Color.blue },
        -- ["@method.call"] = { fg = Color.blue },
        -- ["@namespace"] = { fg = Color.yellow },
        -- ["@number"] = { fg = Color.yellow },
        -- ["@parameter"] = { fg = Color.fg },
        -- ["@parameter.reference"] = { fg = Color.fg },
        -- ["@property"] = { fg = Color.yellow },
        -- ["@punctuation"] = { fg = Color.dark5 },
        -- ["@punctuation.delimiter"] = { fg = Color.fg },
        -- ["@punctuation.bracket"] = { fg = Color.dark5 },
        -- ["@punctuation.special"] = { fg = Color.blue5 },
        -- ["@punctuation.special.markdown"] = { fg = Color.const_orange, bold = true },
        -- ["@repeat"] = { fg = Color.purple },
        -- ["@string"] = { fg = Color.green },
        -- ["@string.regex"] = { fg = Color.blue6 },
        -- ["@string.special"] = { fg = Color.green },
        -- ["@string.escape"] = { fg = Color.green },
        -- ["@symbol"] = { fg = Color.fg_dark },
        -- ["@tag"] = { link = "Tag" },
        -- ["@tag.delimiter"] = { link = "Tag" },
        -- ["@tag.attribute"] = { fg = Color.yellow },
        -- ["@text"] = { fg = Color.fg },
        -- ["@text.uri"] = { underline = true, sp = Color.dark5 },
        -- ["@text.literal"] = { fg = Color.green },
        -- ["@text.math"] = { fg = Color.blue },
        -- ["@text.environment"] = { fg = Color.fg_gutter },
        -- ["@text.environment.name"] = { fg = Color.fg },
        -- ["@text.reference"] = { fg = Color.blue },
        -- ["@text.title"] = { fg = Color.fg },
        -- ["@text.note"] = { fg = Color.bg_dark, bg = Color.fg_dark },
        -- ["@text.warning"] = { fg = Color.bg, bg = Color.const_orange },
        -- ["@text.error"] = { fg = Color.bg, bg = Color.red },
        -- ["@text.strike"] = { fg = Color.fg },
        -- ["@text.strong"] = { link = "Bold" },
        -- ["@text.emphasis"] = { link = "Italic" },
        -- ["@text.underline"] = { link = "Underlined" },
        -- ["@text.literal.markdown_inline"] = { bg = Color.terminal_black, fg = Color.blue },
        -- ["@text.todo"] = { link = "Todo" },
        -- ["@text.todo.checked"] = { link = "Directory" },
        -- ["@text.todo.unchecked"] = { link = "PreProc" },
        -- ["@type"] = { fg = Color.yellow },
        -- ["@type.builtin"] = { fg = Color.yellow },
        -- ["@type.qualifier"] = { link = "Special" },
        -- ["@type.definition"] = { link = "Typedef" },
        -- ["@storageclass"] = { link = "StorageClass" },
        --
        -- TSNodeKey = { fg = Color.magenta2, bold = true },
        -- TSNodeUnmatched = { fg = Color.dark3 },

        -- Indent Blankline
        IndentBlanklineContextChar = { fg = Color.fg_dark },

        -- HTML
        htmlUnderline = { underline = true, sp = Color.dark5 },
        htmlBoldUnderline = { bold = true, underline = true, sp = Color.dark5 },
        htmlItalicUnderline = { italic = true, underline = true, sp = Color.dark5 },
        htmlUnderlineBold = { bold = true, underline = true, sp = Color.dark5 },
        htmlUnderlineBoldItalic = { underline = true, sp = Color.dark5 },
        htmlUnderlineItalic = { underline = true, sp = Color.dark5 },
        htmlUnderlineItalicBold = { underline = true, sp = Color.dark5 },
        htmlItalicUnderlineBold = { italic = true, underline = true, sp = Color.dark5 },
        htmlBoldItalicUnderline = { bold = true, italic = true, underline = true, sp = Color.dark5 },
        htmlBoldUnderlineItalic = { bold = true, underline = true, sp = Color.dark5 },
        htmlItalicBoldUnderline = { italic = true, bold = true, underline = true, sp = Color.dark5 },

        -- NvimTree
        NvimTreeGitDeleted = { fg = Color.red },
        NvimTreeEndOfBuffer = { link = "EndOfBuffer" },
        NvimTreeSpecialFile = { underline = true, sp = Color.fg_cursorlinenr },
        NvimTreeIndentMarker = { fg = Color.terminal_black },
        NvimTreeSymlink = { fg = Color.yellow },
        NvimTreeNormal = { link = "Normal" },
        NvimTreeNormalNC = { link = "NormalNC" },
        NvimTreeFolderIcon = { fg = Color.light_red or Color.slime or Color.fg_dark },
        NvimTreeRootFolder = { fg = Color.sunset_root or Color.slime or Color.root, bold = false },
        NvimTreeFolderName = { fg = Color.fg },
        NvimTreeOpenedFolderName = { fg = Color.fg_dark },
        NvimTreeEmptyFolderName = { fg = Color.fg_dark },
        NvimTreeGitDirty = { fg = Color.blue8 },
        NvimTreeGitNew = { fg = Color.green3 },

        -- WhichKey
        WhichKeyBorder = { fg = Color.border or Color.light_red or Color.slime_border, bg = Color.none },
        WhichKeyFloat = { link = "NormalFloat" },
        WhichKey = { fg = Color.blue9 },
        WhichKeyGroup = { fg = Color.sunset_root or Color.slime or Color.sky or Color.transparent },
        WhichKeyDesc = { fg = Color.magenta },
        WhichKeySeparator = { fg = Color.comment },
        WhichKeyValue = { fg = Color.dark5 },

        -- Barbar
        BufferCurrent = { bg = Color.night, fg = Color.fg },
        BufferCurrentIndex = { bg = Color.night, fg = Color.blue },
        BufferCurrentMod = { bg = Color.night, fg = Color.yellow },
        BufferCurrentSign = { bg = Color.night, fg = Color.blue },
        BufferCurrentTarget = { bg = Color.fg_gutter, fg = Color.red },
        BufferVisible = { bg = Color.bg_statusline, fg = Color.fg },
        BufferVisibleIndex = { bg = Color.bg_statusline, fg = Color.blue },
        BufferVisibleMod = { bg = Color.bg_statusline, fg = Color.yellow },
        BufferVisibleSign = { bg = Color.bg_statusline, fg = Color.blue },
        BufferVisibleTarget = { bg = Color.bg_statusline, fg = Color.red },
        BufferInactive = { bg = Color.bg_statusline, fg = Color.dark5 },
        BufferInactiveIndex = { bg = Color.bg_statusline, fg = Color.dark5 },
        BufferInactiveMod = { bg = Color.bg_statusline, fg = Color.yellow },
        BufferInactiveSign = { bg = Color.bg_statusline, fg = Color.dark3 },
        BufferInactiveTarget = { bg = Color.bg_statusline, fg = Color.red },
        BufferTabpages = { bg = Color.bg_statusline, fg = Color.none },
        BufferTabpage = { bg = Color.bg_statusline, fg = Color.dark3 },
        BufferTabpageFill = { bg = Color.night },

        -- Telescope
        TelescopeNormal = { fg = Color.fg_cursorlinenr, bg = Color.none },
        TelescopeMatching = { fg = Color.sunset_root or Color.slime or Color.sky, bg = Color.none },
        TelescopeSelection = { fg = Color.sunset_root or Color.slime or Color.sky, bg = Color.none },
        TelescopeMultiSelection = { bg = Color.none },
        TelescopePreviewLine = { bg = Color.none },
        TelescopePromptPrefix = { fg = Color.sky or Color.light_red or Color.slime_border, bg = Color.none },
        TelescopePromptBorder = { fg = Color.border or Color.light_red or Color.slime_border, bg = Color.none },
        TelescopePreviewBorder = { fg = Color.border or Color.light_red or Color.slime_border, bg = Color.none },
        TelescopeResultsBorder = { fg = Color.border or Color.light_red or Color.slime_border, bg = Color.none },
        TelescopePromptTitle = { fg = Color.terminal_black, bg = Color.none },
        TelescopePreviewTitle = { fg = Color.terminal_black, bg = Color.none },
        TelescopeResultsTitle = { fg = Color.terminal_black, bg = Color.none },
        TelescopeTitle = { fg = Color.fg, bg = Color.none },

        -- Alpha
        AlphaHeader = { fg = Color.light_red or Color.slime or Color.night_header or Color.transparent_header },
        AlphaButton = { fg = Color.fg },
        AlphaFooter = { fg = Color.fg },

        -- Dashboard
        DashboardHeader = { fg = Color.light_red or Color.slime or Color.night_header or Color.transparent_header },
        DashboardCenter = { fg = Color.fg },
        DashboardFooter = { fg = Color.fg },

        -- Git
        GitSignsChange = { fg = Color.blue, bg = Color.sunset_bg or Color.slime_bg or Color.night_bg },
        GitSignsDelete = { fg = Color.red, bg = Color.sunset_bg or Color.slime_bg or Color.night_bg },
        GitSignsAdd = { fg = Color.green, bg = Color.sunset_bg or Color.slime_bg or Color.night_bg },

        -- diff
        diffAdded = { fg = Color.green },
        diffRemoved = { fg = Color.red },
        diffChanged = { fg = Color.blue },
        diffOldFile = { fg = Color.yellow },
        diffNewFile = { fg = Color.const_orange },
        diffFile = { fg = Color.blue },
        diffLine = { fg = Color.comment },
        diffIndexLine = { fg = Color.magenta },

        -- ts-rainbow
        rainbowcol1 = { fg = Color.red },
        rainbowcol2 = { fg = Color.yellow },
        rainbowcol3 = { fg = Color.green },
        rainbowcol4 = { fg = Color.teal },
        rainbowcol5 = { fg = Color.blue },
        rainbowcol6 = { fg = Color.magenta },
        rainbowcol7 = { fg = Color.purple },

        -- LSP
        DiagnosticWarning = { link = "DiagnosticWarn" },
        DiagnosticInformation = { link = "DiagnosticInfo" },
        LspSagaSignatureHelpBorder = { fg = Color.border or Color.light_red or Color.slime_border, bg = Color.none },
        LspSagaDefPreviewBorder = { fg = Color.border or Color.light_red or Color.slime_border, bg = Color.none },
        LspSagaRenameBorder = { fg = Color.border or Color.light_red or Color.slime_border, bg = Color.none },
        LspFloatWinBorder = { fg = Color.border or Color.light_red or Color.slime_border, bg = Color.none },
        LspSagaBorderTitle = { fg = Color.border or Color.light_red or Color.slime_border, bg = Color.none },
        LspSagaHoverBorder = { fg = Color.border or Color.light_red or Color.slime_border, bg = Color.none },
        LspSagaCodeActionBorder = { fg = Color.border or Color.light_red or Color.slime_border, bg = Color.none },
        LspSagaFinderSelection = { fg = Color.bg_visual },
        LspSagaCodeActionTitle = { fg = Color.blue1 },
        LspSagaCodeActionContent = { fg = Color.purple },
        ReferencesCount = { fg = Color.purple },
        DefinitionCount = { fg = Color.purple },
        DefinitionIcon = { fg = Color.blue },
        ReferencesIcon = { fg = Color.blue },
        TargetWord = { fg = Color.cyan },
        LspReferenceText = { bg = Color.fg_gutter },
        LspReferenceRead = { bg = Color.fg_gutter },
        LspReferenceWrite = { bg = Color.fg_gutter },
        LspInfoBorder = { link = "FloatBorder" },
        LspFloatWinNormal = { link = "NormalFloat" },

        DiagnosticError = { fg = Color.red },
        DiagnosticInfo = { fg = Color.blue },
        DiagnosticWarn = { fg = Color.const_orange },
        DiagnosticHint = { fg = Color.yellow },
        DiagnosticUnderlineError = { underline = false },
        DiagnosticUnderlineInfo = { underline = false },
        DiagnosticUnderlineWarn = { underline = false },
        DiagnosticUnderlineHint = { underline = false },
        DiagnosticVirtualTextError = { fg = Color.red, bg = Color.virtual_err },
        DiagnosticVirtualTextInfo = { fg = Color.blue, bg = Color.virtual_info },
        DiagnosticVirtualTextWarn = { fg = Color.const_orange, bg = Color.virtual_warn },
        DiagnosticVirtualTextHint = { fg = Color.yellow, bg = Color.virtual_hint },
        DiagnosticFloatingError = { link = "DiagnosticError" },
        DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
        DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
        DiagnosticFloatingHint = { link = "DiagnosticHint" },
        DiagnosticSignError = { link = "DiagnosticError" },
        DiagnosticSignInfo = { link = "DiagnosticInfo" },
        DiagnosticSignWarn = { link = "DiagnosticWarn" },
        DiagnosticSignHint = { link = "DiagnosticHint" },

        CmpDocumentationBorder = { fg = Color.terminal_black },
        CmpCompletionBorder = { fg = Color.terminal_black },
        CmpCursorLine = { bg = Color.bg_highlight },
        CmpItemKindFolder = { fg = Color.blue },
        CmpItemKindFile = { fg = Color.green },
        CmpItemKindEnumMember = { fg = Color.purple },
        CmpItemKindFunction = { fg = Color.purple },
        CmpItemKindMethod = { fg = Color.purple },
        CmpItemKindStruct = { fg = Color.purple },
        CmpItemKindEnum = { fg = Color.purple },
        CmpItemKindConstructor = { fg = Color.yellow },
        CmpItemKindInterface = { fg = Color.yellow },
        CmpItemKindReference = { fg = Color.yellow },
        CmpItemKindConstant = { fg = Color.yellow },
        CmpItemKindProperty = { fg = Color.yellow },
        CmpItemKindModule = { fg = Color.yellow },
        CmpItemKindClass = { fg = Color.yellow },
        CmpItemKindField = { fg = Color.yellow },
        CmpItemKindEvent = { fg = Color.yellow },
        CmpItemKindTypeParameter = { fg = Color.fg_dark },
        CmpItemKindVariable = { fg = Color.fg_dark },
        CmpItemKindOperator = { fg = Color.blue },
        CmpItemKindSnippet = { fg = Color.blue },
        CmpItemKindKeyword = { fg = Color.blue },
        CmpItemKindText = { fg = Color.fg_dark },
        CmpItemKindUnit = { fg = Color.fg_dark },
        CmpItemKindValue = { fg = Color.blue },
        CmpItemAbbrMatch = { fg = Color.sunset_root or Color.slime or Color.sky, bg = Color.none },
        CmpItemAbbrDeprecated = { fg = Color.fg_gutter, bg = Color.none, strikethrough = true },
        CmpItemAbbrMatchFuzzy = { fg = Color.sunset_root or Color.slime or Color.sky, bg = Color.none },
        CmpItemAbbr = { fg = Color.fg, bg = Color.none },

        -- Navic
        NavicIconsFile = { fg = Color.green, bg = Color.none },
        NavicIconsModule = { fg = Color.yellow, bg = Color.none },
        NavicIconsNamespace = { fg = Color.yellow, bg = Color.none },
        NavicIconsPackage = { fg = Color.fg, bg = Color.none },
        NavicIconsClass = { fg = Color.const_orange, bg = Color.none },
        NavicIconsMethod = { fg = Color.blue, bg = Color.none },
        NavicIconsProperty = { fg = Color.yellow, bg = Color.none },
        NavicIconsField = { fg = Color.yellow, bg = Color.none },
        NavicIconsConstructor = { fg = Color.const_orange, bg = Color.none },
        NavicIconsEnum = { fg = Color.purple, bg = Color.none },
        NavicIconsInterface = { fg = Color.const_orange, bg = Color.none },
        NavicIconsFunction = { fg = Color.purple, bg = Color.none },
        NavicIconsVariable = { fg = Color.blue, bg = Color.none },
        NavicIconsConstant = { fg = Color.const_orange, bg = Color.none },
        NavicIconsString = { fg = Color.green, bg = Color.none },
        NavicIconsNumber = { fg = Color.yellow, bg = Color.none },
        NavicIconsBoolean = { fg = Color.const_orange, bg = Color.none },
        NavicIconsArray = { fg = Color.blue, bg = Color.none },
        NavicIconsObject = { fg = Color.blue, bg = Color.none },
        NavicIconsKey = { fg = Color.purple, bg = Color.none },
        NavicIconsKeyword = { fg = Color.cursor_bg, bg = Color.none },
        NavicIconsNull = { fg = Color.blue, bg = Color.none },
        NavicIconsEnumMember = { fg = Color.yellow, bg = Color.none },
        NavicIconsStruct = { fg = Color.purple, bg = Color.none },
        NavicIconsEvent = { fg = Color.blue, bg = Color.none },
        NavicIconsOperator = { fg = Color.fg, bg = Color.none },
        NavicIconsTypeParameter = { fg = Color.fg_dark, bg = Color.none },
        NavicText = { fg = Color.fg, bg = Color.none },
        NavicSeparator = { fg = Color.fg, bg = Color.none },

        -- Scrollbar
        ScrollbarHandle = { fg = Color.none, bg = Color.bg_highlight },
        ScrollbarSearchHandle = { fg = Color.const_orange, bg = Color.bg_highlight },
        ScrollbarSearch = { fg = Color.const_orange, bg = Color.none },
        ScrollbarErrorHandle = { fg = Color.red, bg = Color.bg_highlight },
        ScrollbarError = { fg = Color.red, bg = Color.none },
        ScrollbarWarnHandle = { fg = Color.const_orange, bg = Color.bg_highlight },
        ScrollbarWarn = { fg = Color.const_orange, bg = Color.none },
        ScrollbarInfoHandle = { fg = Color.blue, bg = Color.bg_highlight },
        ScrollbarInfo = { fg = Color.blue, bg = Color.none },
        ScrollbarHintHandle = { fg = Color.yellow, bg = Color.bg_highlight },
        ScrollbarHint = { fg = Color.yellow, bg = Color.none },
        ScrollbarMiscHandle = { fg = Color.purple, bg = Color.bg_highlight },
        ScrollbarMisc = { fg = Color.purple, bg = Color.none },

        -- Yanky
        YankyPut = { link = "Visual" },
        YankyYanked = { link = "Visual" },
        YankHighlight = { bg = Color.dark3 },

        -- Notify
        NotifyERRORBorder = { fg = Color.red, bg = Color.bg },
        NotifyWARNBorder = { fg = Color.const_orange, bg = Color.bg },
        NotifyINFOBorder = { fg = Color.blue, bg = Color.bg },
        NotifyDEBUGBorder = { fg = Color.comment, bg = Color.bg },
        NotifyTRACEBorder = { fg = Color.purple, bg = Color.bg },
        --- Icons
        NotifyERRORIcon = { fg = Color.red },
        NotifyWARNIcon = { fg = Color.const_orange },
        NotifyINFOIcon = { fg = Color.blue },
        NotifyDEBUGIcon = { fg = Color.comment },
        NotifyTRACEIcon = { fg = Color.purple },
        --- Title
        NotifyERRORTitle = { fg = Color.red },
        NotifyWARNTitle = { fg = Color.const_orange },
        NotifyINFOTitle = { fg = Color.blue },
        NotifyDEBUGTitle = { fg = Color.comment },
        NotifyTRACETitle = { fg = Color.purple },
        --- Body
        NotifyERRORBody = { fg = Color.fg, bg = Color.bg },
        NotifyWARNBody = { fg = Color.fg, bg = Color.bg },
        NotifyINFOBody = { fg = Color.fg, bg = Color.bg },
        NotifyDEBUGBody = { fg = Color.fg, bg = Color.bg },
        NotifyTRACEBody = { fg = Color.fg, bg = Color.bg },

        MiniCompletionActiveParameter = { underline = true },
        MiniCursorword = { bg = Color.fg_gutter },
        MiniCursorwordCurrent = { bg = Color.fg_gutter },
        MiniIndentscopeSymbol = { fg = Color.blue1 },
        MiniIndentscopePrefix = { nocombine = true }, -- Make it invisible
        MiniJump = { bg = Color.magenta2, fg = "#ffffff" },
        MiniJump2dSpot = { fg = Color.magenta2, bold = true, nocombine = true },
        MiniStarterCurrent = { nocombine = true },
        MiniStarterFooter = { fg = Color.yellow, italic = true },
        MiniStarterHeader = { fg = Color.blue },
        MiniStarterInactive = { fg = Color.comment },
        MiniStarterItem = { fg = Color.fg, bg = Color.bg },
        MiniStarterItemBullet = { fg = Color.dark3 },
        MiniStarterItemPrefix = { fg = Color.const_orange },
        MiniStarterSection = { fg = Color.blue1 },
        MiniStarterQuery = { fg = Color.blue },
        MiniStatuslineDevinfo = { fg = Color.fg_dark, bg = Color.bg_highlight },
        MiniStatuslineFileinfo = { fg = Color.fg_dark, bg = Color.bg_highlight },
        MiniStatuslineFilename = { fg = Color.fg_dark, bg = Color.fg_gutter },
        MiniStatuslineInactive = { fg = Color.blue, bg = Color.bg_statusline },
        MiniStatuslineModeCommand = { fg = Color.black, bg = Color.yellow, bold = true },
        MiniStatuslineModeInsert = { fg = Color.black, bg = Color.green, bold = true },
        MiniStatuslineModeNormal = { fg = Color.black, bg = Color.blue, bold = true },
        MiniStatuslineModeOther = { fg = Color.black, bg = Color.teal, bold = true },
        MiniStatuslineModeReplace = { fg = Color.black, bg = Color.red, bold = true },
        MiniStatuslineModeVisual = { fg = Color.black, bg = Color.magenta, bold = true },
        MiniSurround = { bg = Color.orange, fg = Color.black },
        MiniTablineCurrent = { fg = Color.fg, bg = Color.fg_gutter },
        MiniTablineFill = { bg = Color.black },
        MiniTablineHidden = { fg = Color.dark5, bg = Color.bg_statusline },
        MiniTablineModifiedCurrent = { fg = Color.const_orange, bg = Color.fg_gutter },
        MiniTablineModifiedHidden = { bg = Color.bg_statusline, fg = Color.const_orange },
        MiniTablineModifiedVisible = { fg = Color.const_orange, bg = Color.bg_statusline },
        MiniTablineTabpagesection = { bg = Color.bg_statusline, fg = Color.none },
        MiniTablineVisible = { fg = Color.fg, bg = Color.bg_statusline },
        MiniTestEmphasis = { bold = true },
        MiniTestFail = { fg = Color.red, bold = true },
        MiniTestPass = { fg = Color.green, bold = true },
        MiniTrailspace = { bg = Color.red },
        -- Noice
        NoiceCompletionItemKindDefault = { fg = Color.fg_dark, bg = Color.none },
        NoiceCompletionItemKindKeyword = { fg = Color.cyan, bg = Color.none },
        NoiceCompletionItemKindVariable = { fg = Color.magenta, bg = Color.none },
        NoiceCompletionItemKindConstant = { fg = Color.magenta, bg = Color.none },
        NoiceCompletionItemKindReference = { fg = Color.magenta, bg = Color.none },
        NoiceCompletionItemKindValue = { fg = Color.magenta, bg = Color.none },
        NoiceCompletionItemKindFunction = { fg = Color.blue, bg = Color.none },
        NoiceCompletionItemKindMethod = { fg = Color.blue, bg = Color.none },
        NoiceCompletionItemKindConstructor = { fg = Color.blue, bg = Color.none },
        NoiceCompletionItemKindClass = { fg = Color.orange, bg = Color.none },
        NoiceCompletionItemKindInterface = { fg = Color.orange, bg = Color.none },
        NoiceCompletionItemKindStruct = { fg = Color.orange, bg = Color.none },
        NoiceCompletionItemKindEvent = { fg = Color.orange, bg = Color.none },
        NoiceCompletionItemKindEnum = { fg = Color.orange, bg = Color.none },
        NoiceCompletionItemKindUnit = { fg = Color.orange, bg = Color.none },
        NoiceCompletionItemKindModule = { fg = Color.yellow, bg = Color.none },
        NoiceCompletionItemKindProperty = { fg = Color.green1, bg = Color.none },
        NoiceCompletionItemKindField = { fg = Color.green1, bg = Color.none },
        NoiceCompletionItemKindTypeParameter = { fg = Color.green1, bg = Color.none },
        NoiceCompletionItemKindEnumMember = { fg = Color.green1, bg = Color.none },
        NoiceCompletionItemKindOperator = { fg = Color.green1, bg = Color.none },
        NoiceCompletionItemKindSnippet = { fg = Color.dark5, bg = Color.none },
    }
    return syntax
end

local terminal_colors = {
    terminal_color_0 = Color.black,
    terminal_color_8 = Color.terminal_black,
    terminal_color_7 = Color.fg_dark,
    terminal_color_15 = Color.fg,
    terminal_color_1 = Color.red1,
    terminal_color_9 = Color.red1,
    terminal_color_2 = Color.green,
    terminal_color_10 = Color.green,
    terminal_color_3 = Color.yellow,
    terminal_color_11 = Color.yellow,
    terminal_color_4 = Color.blue,
    terminal_color_12 = Color.blue,
    terminal_color_5 = Color.magenta,
    terminal_color_13 = Color.magenta,
    terminal_color_6 = Color.cyan,
    terminal_color_14 = Color.cyan,
}

local function highlight(group, color)
    local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
    local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
    local style = color.style and "gui=" .. color.style or "gui=NONE"
    local sp = color.sp and "guisp=" .. color.sp or ""

    vim.api.nvim_command(string.format("highlight %s %s %s %s %s", group, fg, bg, style, sp))
end

function Dull.apply()
    vim.api.nvim_command "highlight clear"
    if vim.fn.exists "syntax_on" then
        vim.api.nvim_command "syntax reset"
    end

    vim.o.termguicolors = true
    vim.g.colors_name = "dull"
    -- local async
    -- async = vim.loop.new_async(vim.schedule_wrap(
    -- function()
    --     for group, color in pairs(Theme.plugins()) do
    --         highlight(group, color)
    --     end
    --     for group, color in pairs(Theme.treesitter()) do
    --         highlight(group, color)
    --     end
    --     for group, color in pairs(Theme.lsp()) do highlight(group, color) end
    --     for group, color in pairs(Theme.languages()) do
    --         highlight(group, color)
    --     end

    --     async:close()
    -- end))

    -- for group, color in pairs(Theme.editor()) do highlight(group, color) end
    for group, color in pairs(Theme.highlight()) do
        highlight(group, color)
    end
    for group, color in pairs(terminal_colors) do
        vim.g[group] = color
    end

    -- async:send()
    -- vim.api.nvim_command "hi Normal guibg=NONE ctermbg=NONE"
    -- vim.api.nvim_command "hi Conceal guibg=NONE"
end

-- vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
return Dull.apply()

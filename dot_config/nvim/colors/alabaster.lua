-- Reset highlighting.
vim.cmd.highlight('clear')
if vim.fn.exists('syntax_on') then
    vim.cmd.syntax('reset')
end
vim.g.colors_name = 'alabaster'

local colors = {
    light = {
        bg = '#F7F7F7',
        fg = '#000000',
        comment = '#9DA39A',
        string = '#448C27',
        constant = '#7A3E9D',
        entity = '#325CC0',
        escape = '#777777',
        punctuation = '#777777',
        invalid_bg = '#F7E6E6',
        invalid_fg = '#660000',

        warning = '#CB9000',
        info = '#0083B2',
        hint = '#448C27',

        line_highlight = '#F0F0F0',
        selection = '#BFDBFE',
        selection_highlight = '#E3E3E3',
        line_number = '#9DA39A',

        find_match = '#FFBC5D',
        find_match_highlight = '#FFE9C2',

        visual = '#BFDBFE',

        diff_add_bg = '#DDFFDD',
        diff_delete_bg = '#FFDDDD',
        diff_change_bg = '#DDDDFF',
        diff_text = '#434343',

        statusline_bg = '#DDDDDD',
        statusline_fg = '#474747',

        term_black = '#000000',
        term_red = '#AA3731',
        term_green = '#448C27',
        term_yellow = '#CB9000',
        term_blue = '#325CC0',
        term_magenta = '#7A3E9D',
        term_cyan = '#0083B2',
        term_white = '#BBBBBB',
        term_bright_black = '#777777',
        term_bright_red = '#F05050',
        term_bright_green = '#60CB00',
        term_bright_yellow = '#FFBC5D',
        term_bright_blue = '#007ACC',
        term_bright_magenta = '#E64CE6',
        term_bright_cyan = '#00AACB',
        term_bright_white = '#FFFFFF',
    },
    dark = {
        bg = '#0E1415',
        fg = '#CECECE',
        comment = '#6B7678',
        string = '#91B362',
        constant = '#B77FDB',
        entity = '#6199D9',
        escape = '#999999',
        punctuation = '#999999',
        invalid_bg = '#3D2022',
        invalid_fg = '#D96468',

        warning = '#D9B76C',
        info = '#5AAEBD',
        hint = '#91B362',

        line_highlight = '#1A1F20',
        selection = '#1C3D5C',
        selection_highlight = '#2A2F30',
        line_number = '#4A5759',

        find_match = '#5F4C00',
        find_match_highlight = '#3D3100',

        visual = '#1C3D5C',

        diff_add_bg = '#1D3124',
        diff_delete_bg = '#3D2022',
        diff_change_bg = '#1D2845',
        diff_text = '#CECECE',

        statusline_bg = '#1A1F20',
        statusline_fg = '#999999',

        term_black = '#000000',
        term_red = '#D96468',
        term_green = '#91B362',
        term_yellow = '#D9B76C',
        term_blue = '#6199D9',
        term_magenta = '#B77FDB',
        term_cyan = '#5AAEBD',
        term_white = '#BBBBBB',
        term_bright_black = '#666666',
        term_bright_red = '#F07178',
        term_bright_green = '#AAD94C',
        term_bright_yellow = '#FFD580',
        term_bright_blue = '#73B8FF',
        term_bright_magenta = '#D2A6FF',
        term_bright_cyan = '#7FD5E0',
        term_bright_white = '#FFFFFF',
    },
}

local c = colors[(vim.o.background == 'dark' and 'dark') or 'light']

local highlights = {
    Normal = { fg = c.fg, bg = c.bg },
    NormalFloat = { link = 'Normal' },
    Comment = { fg = c.comment },

    Constant = { fg = c.constant },
    String = { fg = c.string },
    Character = { fg = c.constant },
    Number = { fg = c.constant },
    Boolean = { fg = c.constant },
    Float = { fg = c.constant },

    Identifier = { fg = c.fg },
    Function = { fg = c.entity },

    Statement = { fg = c.fg },
    Conditional = { fg = c.fg },
    Repeat = { fg = c.fg },
    Label = { fg = c.fg },
    Operator = { fg = c.fg },
    Keyword = { fg = c.fg },
    Exception = { fg = c.fg },

    PreProc = { fg = c.fg },
    Include = { fg = c.fg },
    Define = { fg = c.fg },
    Macro = { fg = c.fg },
    PreCondit = { fg = c.fg },

    Type = { fg = c.fg },
    StorageClass = { fg = c.fg },
    Structure = { fg = c.fg },
    Typedef = { fg = c.fg },

    Special = { fg = c.punctuation },
    SpecialChar = { fg = c.escape },
    Tag = { fg = c.entity },
    Delimiter = { fg = c.punctuation },
    SpecialComment = { fg = c.comment },
    Debug = { fg = c.comment },

    Underlined = { underline = true },
    Ignore = { fg = c.punctuation },
    Error = { fg = c.invalid_fg, bg = c.invalid_bg },
    Todo = { fg = c.comment },

    CursorLine = { bg = c.line_highlight },
    CursorLineNr = { fg = c.fg },
    LineNr = { fg = c.line_number },
    SignColumn = { bg = c.bg },

    Visual = { bg = c.visual },
    VisualNOS = { bg = c.visual },

    Pmenu = { fg = c.fg, bg = c.line_highlight },
    PmenuSel = { fg = c.fg, bg = c.selection_highlight },
    PmenuSbar = { bg = c.line_highlight },
    PmenuThumb = { bg = c.punctuation },

    StatusLine = { fg = c.fg, bg = c.statusline_bg },
    StatusLineNC = { fg = c.statusline_fg, bg = c.statusline_bg },

    Search = { bg = c.find_match },
    IncSearch = { bg = c.find_match },

    MatchParen = { bg = c.selection_highlight },

    -- Window & Split UI
    WinSeparator = { fg = c.line_number },
    VertSplit = { link = 'WinSeparator' },
    WinBar = { fg = c.fg, bg = c.bg },
    WinBarNC = { fg = c.line_number, bg = c.bg },

    -- Floating Windows
    FloatBorder = { fg = c.line_number, bg = c.bg },
    FloatTitle = { fg = c.fg, bg = c.bg },

    -- Tab Line
    TabLine = { fg = c.line_number, bg = c.statusline_bg },
    TabLineFill = { bg = c.statusline_bg },
    TabLineSel = { fg = c.fg, bg = c.bg },

    -- Folding
    Folded = { fg = c.line_number, bg = c.line_highlight },
    FoldColumn = { fg = c.line_number, bg = c.bg },

    -- Messages & Command Line
    ErrorMsg = { fg = c.invalid_fg },
    WarningMsg = { fg = c.warning },
    ModeMsg = { fg = c.fg, bold = true },
    MoreMsg = { fg = c.string },
    Question = { fg = c.string },
    MsgArea = { fg = c.fg },

    -- Special Text
    NonText = { fg = c.line_number },
    EndOfBuffer = { fg = c.line_number },
    Whitespace = { fg = c.line_number },
    SpecialKey = { fg = c.line_number },
    Conceal = { fg = c.punctuation },

    -- Columns & Lines
    ColorColumn = { bg = c.line_highlight },
    CursorColumn = { bg = c.line_highlight },

    -- Navigation & Selection
    Directory = { fg = c.entity },
    Title = { fg = c.entity, bold = true },
    WildMenu = { fg = c.fg, bg = c.selection },
    QuickFixLine = { bg = c.selection },

    -- Diff
    DiffAdd = { bg = c.diff_add_bg, fg = c.diff_text },
    DiffChange = { bg = c.diff_change_bg, fg = c.diff_text },
    DiffDelete = { bg = c.diff_delete_bg, fg = c.diff_text },
    DiffText = { bg = c.diff_change_bg, fg = c.diff_text },

    -- Spelling
    SpellBad = { underline = true, sp = c.invalid_fg },
    SpellCap = { underline = true, sp = c.entity },
    SpellRare = { underline = true, sp = c.constant },
    SpellLocal = { underline = true, sp = c.string },

    -- LSP Diagnostics
    DiagnosticError = { fg = c.invalid_fg },
    DiagnosticWarn = { fg = c.warning },
    DiagnosticInfo = { fg = c.info },
    DiagnosticHint = { fg = c.hint },

    DiagnosticVirtualTextError = { fg = c.invalid_fg, bg = c.invalid_bg },
    DiagnosticVirtualTextWarn = { fg = c.warning },
    DiagnosticVirtualTextInfo = { fg = c.info },
    DiagnosticVirtualTextHint = { fg = c.hint },

    DiagnosticUnderlineError = { underline = true, sp = c.invalid_fg },
    DiagnosticUnderlineWarn = { underline = true, sp = c.warning },
    DiagnosticUnderlineInfo = { underline = true, sp = c.info },
    DiagnosticUnderlineHint = { underline = true, sp = c.hint },

    DiagnosticSignError = { fg = c.invalid_fg },
    DiagnosticSignWarn = { fg = c.warning },
    DiagnosticSignInfo = { fg = c.info },
    DiagnosticSignHint = { fg = c.hint },

    DiagnosticFloatingError = { fg = c.invalid_fg },
    DiagnosticFloatingWarn = { fg = c.warning },
    DiagnosticFloatingInfo = { fg = c.info },
    DiagnosticFloatingHint = { fg = c.hint },

    -- Treesitter
    ['@comment'] = { link = 'Comment' },
    ['@string'] = { link = 'String' },
    ['@string.escape'] = { fg = c.escape },
    ['@string.regexp'] = { link = 'String' },
    ['@number'] = { link = 'Number' },
    ['@boolean'] = { link = 'Boolean' },
    ['@constant'] = { link = 'Constant' },
    ['@constant.builtin'] = { link = 'Constant' },
    ['@function'] = { link = 'Function' },
    ['@function.builtin'] = { link = 'Function' },
    ['@function.macro'] = { link = 'Function' },
    ['@keyword'] = { fg = c.fg },
    ['@keyword.function'] = { fg = c.fg },
    ['@keyword.operator'] = { fg = c.fg },
    ['@keyword.return'] = { fg = c.fg },
    ['@operator'] = { link = 'Operator' },
    ['@punctuation.delimiter'] = { fg = c.punctuation },
    ['@punctuation.bracket'] = { fg = c.punctuation },
    ['@punctuation.special'] = { fg = c.punctuation },
    ['@variable'] = { fg = c.fg },
    ['@variable.builtin'] = { fg = c.fg },
    ['@type'] = { fg = c.fg },
    ['@type.builtin'] = { fg = c.fg },
    ['@tag'] = { fg = c.entity },
    ['@tag.attribute'] = { fg = c.fg },
    ['@tag.delimiter'] = { fg = c.punctuation },
    ['@symbol'] = { fg = c.constant },
    ['@symbol.clojure'] = { fg = c.constant },
    ['@keyword.clojure'] = { fg = c.constant },
    ['@namespace'] = { fg = c.entity },
    ['@function.call'] = { fg = c.fg },
    ['@method.call'] = { fg = c.fg },
    ['@type.definition'] = { fg = c.entity },
    ['@type.qualifier'] = { fg = c.fg },
    ['@variable.parameter'] = { fg = c.fg },
    ['@variable.member'] = { fg = c.fg },

    -- Treesitter (newer captures)
    ['@module'] = { fg = c.entity },
    ['@property'] = { fg = c.fg },
    ['@constructor'] = { fg = c.entity },
    ['@attribute'] = { fg = c.constant },
    ['@label'] = { fg = c.fg },
    ['@character.special'] = { fg = c.escape },
    ['@string.special'] = { fg = c.escape },
    ['@string.special.url'] = { fg = c.entity, underline = true },
    ['@string.special.path'] = { fg = c.string },

    -- Markup (markdown, docs, etc.)
    ['@markup.heading'] = { fg = c.entity, bold = true },
    ['@markup.heading.1'] = { fg = c.entity, bold = true },
    ['@markup.heading.2'] = { fg = c.entity, bold = true },
    ['@markup.heading.3'] = { fg = c.entity, bold = true },
    ['@markup.heading.4'] = { fg = c.entity, bold = true },
    ['@markup.heading.5'] = { fg = c.entity, bold = true },
    ['@markup.heading.6'] = { fg = c.entity, bold = true },
    ['@markup.strong'] = { bold = true },
    ['@markup.italic'] = { italic = true },
    ['@markup.strikethrough'] = { strikethrough = true },
    ['@markup.underline'] = { underline = true },
    ['@markup.quote'] = { fg = c.comment, italic = true },
    ['@markup.math'] = { fg = c.constant },
    ['@markup.link'] = { fg = c.entity, underline = true },
    ['@markup.link.label'] = { fg = c.entity },
    ['@markup.link.url'] = { fg = c.string, underline = true },
    ['@markup.raw'] = { fg = c.string },
    ['@markup.raw.block'] = { fg = c.string },
    ['@markup.list'] = { fg = c.punctuation },
    ['@markup.list.checked'] = { fg = c.string },
    ['@markup.list.unchecked'] = { fg = c.punctuation },

    -- LSP Semantic Tokens
    ['@lsp.type.class'] = { fg = c.entity },
    ['@lsp.type.decorator'] = { fg = c.constant },
    ['@lsp.type.enum'] = { fg = c.entity },
    ['@lsp.type.enumMember'] = { fg = c.constant },
    ['@lsp.type.function'] = { link = 'Function' },
    ['@lsp.type.interface'] = { fg = c.entity },
    ['@lsp.type.macro'] = { link = 'Function' },
    ['@lsp.type.method'] = { link = 'Function' },
    ['@lsp.type.namespace'] = { fg = c.entity },
    ['@lsp.type.parameter'] = { fg = c.fg },
    ['@lsp.type.property'] = { fg = c.fg },
    ['@lsp.type.struct'] = { fg = c.entity },
    ['@lsp.type.type'] = { fg = c.fg },
    ['@lsp.type.typeParameter'] = { fg = c.entity },
    ['@lsp.type.variable'] = { fg = c.fg },
    ['@lsp.type.comment'] = { link = 'Comment' },
    ['@lsp.mod.deprecated'] = { strikethrough = true },
    ['@lsp.mod.readonly'] = { fg = c.constant },
    ['@lsp.mod.defaultLibrary'] = { link = '@variable.builtin' },
    ['@lsp.typemod.function.defaultLibrary'] = { link = '@function.builtin' },
    ['@lsp.typemod.variable.defaultLibrary'] = { link = '@variable.builtin' },
}

for group, settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, settings)
end

vim.g.terminal_color_0 = c.term_black
vim.g.terminal_color_1 = c.term_red
vim.g.terminal_color_2 = c.term_green
vim.g.terminal_color_3 = c.term_yellow
vim.g.terminal_color_4 = c.term_blue
vim.g.terminal_color_5 = c.term_magenta
vim.g.terminal_color_6 = c.term_cyan
vim.g.terminal_color_7 = c.term_white
vim.g.terminal_color_8 = c.term_bright_black
vim.g.terminal_color_9 = c.term_bright_red
vim.g.terminal_color_10 = c.term_bright_green
vim.g.terminal_color_11 = c.term_bright_yellow
vim.g.terminal_color_12 = c.term_bright_blue
vim.g.terminal_color_13 = c.term_bright_magenta
vim.g.terminal_color_14 = c.term_bright_cyan
vim.g.terminal_color_15 = c.term_bright_white

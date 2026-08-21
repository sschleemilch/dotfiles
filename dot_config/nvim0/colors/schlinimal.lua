-- Reset highlighting. 

vim.cmd.highlight('clear')
if vim.fn.exists('syntax_on') then
    vim.cmd.syntax('reset')
end
vim.g.colors_name = 'schlinimal'

--- Converts a hex color string to an RGB table
---@param hex string A hex color string like "#RRGGBB"
---@return table
local function rgb(hex)
    hex = hex:lower()
    return {
        tonumber(hex:sub(2, 3), 16),
        tonumber(hex:sub(4, 5), 16),
        tonumber(hex:sub(6, 7), 16),
    }
end

--- Blends two colors based on alpha transparency
---@param foreground string Foreground hex color
---@param background string Background hex color
---@param alpha number Blend factor (0 to 1)
---@return string # A hex color string like "#RRGGBB"
local function blend(foreground, background, alpha)
    local fg = rgb(foreground)
    local bg = rgb(background)

    local function blend_channel(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format('#%02X%02X%02X', blend_channel(1), blend_channel(2), blend_channel(3))
end

-- NVIM DARK COLORS
-- color0 #07080d
-- color1 #ffc0b9
-- color2 #b3f6c0
-- color3 #fce094
-- color4 #a6dbff
-- color5 #ffcaff
-- color6 #8cf8f7
-- color7 #eef1f8
-- color8 #4f5258
-- color9 #ffc0b9
-- color10 #b3f6c0
-- color11 #fce094
-- color12 #a6dbff
-- color13 #ffcaff
-- color14 #8cf8f7
-- color15 #eef1f8
-- background #14161b
-- selection_foreground #14161b
-- cursor #9b9ea4
-- cursor_text_color #e0e2ea
-- foreground #e0e2ea
-- selection_background #e0e2ea

local c = {
    bg = '#101010',
    fg = '#ffffff',
    dim = '#474747',
    line = '#404040',
    keyword = '#bbbbbb',
    type = '#bbbbbb',
    operbtor = '#bbbbbb',
    comment = '#777777',
    border = '#bbbbbb',
    emphasis = '#ffffff',
    func = '#8cf8f7',
    string = '#b3f6c0',
    char = '#ffffff',
    identifier = '#ffffff',
    const = '#ffffff',
    info = '#a6dbff',
    success = '#b3f6c0',
    danger = '#ffc0b9',
    warning = '#fce094',
}


-- stylua: ignore
local groups = {
    --- BASE
    Normal            = { fg = c.fg, bg = c.bg },
    NormalFloat       = { link = "Normal" },
    FloatBorder       = { fg = c.border, bg = c.bg, },
    Cursor            = { link = "Normal" },
    TermCursor        = { link = "Cursor" },
    lCursor           = { link = "Cursor" },
    CursorIM          = { link = "Cursor" },
    CursorColumn      = { bg = c.line },
    CursorLine        = { bg = c.line },
    ColorColumn       = { bg = c.line },
    CursorLineNr      = { fg = c.identifier, bold = true },
    LineNr            = { fg = c.comment },
    StatusLine        = { fg = c.fg, bg = c.line },
    StatusLineNC      = { fg = c.comment, bg = c.line },
    StatusLineTerm    = { link = "StatusLine" },
    StatusLineTermNC  = { link = "StatusLineNC" },
    WinBar            = { link = "Normal" },
    WinBarNC          = { link = "Normal" },
    WinSeparator      = { fg = c.border },
    Pmenu             = { bg = c.bg },
    PmenuSel          = { fg = c.fg, bg = c.line, bold = true },
    PmenuThumb        = { bg = c.fg },
    PmenuMatch        = { fg = c.const, bold = true },
    Visual            = { bg = c.line },
    Search            = { link = "Visual" },
    CurSearch         = { link = "DiffChange" },
    IncSearch         = { link = "CurSearch" },
    Substitute        = { link = "DiffAdd" },
    MatchParen        = { bg = c.line, bold = true },
    NonText           = { fg = c.dim },
    EndOfBuffer       = { fg = c.line },
    Question          = { fg = c.const },
    MoreMsg           = { link = "Question" },
    ErrorMsg          = { fg = c.danger },
    WarningMsg        = { link = "Question" },
    ModeMsg           = { link = "Question" },
    MsgSeparator      = { fg = c.fg },
    Directory         = { fg = c.emphasis },
    QuickFixLine      = { fg = c.const, underline = true },
    qfLineNr          = { fg = c.comment },
    SpecialKey        = { fg = c.comment },
    TabLineSel        = { fg = c.emphasis, bg = c.line },
    Title             = { fg = c.emphasis, bold = true },
    DiffAdd           = { fg = c.success, bg = blend(c.success, c.bg, 0.2) },
    DiffChange        = { fg = c.warning, bg = blend(c.warning, c.bg, 0.2) },
    DiffDelete        = { fg = c.danger, bg = blend(c.danger, c.bg, 0.2) },
    DiffText          = { fg = c.warning, bg = blend(c.warning, c.bg, 0.4) },

    -- SYNTAX
    Comment         = { fg = c.comment, italic = true},
    Constant        = { fg = c.fg },
    String          = { fg = c.string },
    Character       = { fg = c.char },
    Number          = { fg = c.const },
    Boolean         = { fg = c.const },
    Float           = { fg = c.const },
    Identifier      = { fg = c.identifier },
    Function        = { fg = c.func },
    Keyword         = { fg = c.keyword },
    Statement       = { fg = c.keyword },
    Conditional     = { link = "Keyword" },
    Repeat          = { link = "Keyword" },
    Label           = { fg = c.keyword },
    Operator        = { fg = c.operator },
    Exception       = { link = "Keyword" },
    PreProc         = { fg = c.fg },
    Include         = { fg = c.keyword },
    Define          = { fg = c.keyword },
    Macro           = { fg = c.const },
    PreCondit       = { fg = c.keyword },
    Type            = { fg = c.type },
    StorageClass    = { fg = c.keyword },
    Structure       = { fg = c.keyword },
    Typedef         = { fg = c.keyword },
    Special         = { fg = c.fg },
    SpecialChar     = { link = "Special" },
    Tag             = { fg = c.fg },
    Delimiter       = { fg = c.type },
    SpecialComment  = { link = "Comment" },
    Debug           = { fg = c.const },
    Underlined      = { underline = true },
    Error           = { fg = c.danger },
    Added           = { fg = c.success },
    Changed         = { fg = c.warning },
    Removed         = { fg = c.danger },

    -- TREESITTER
    ["@variable"]                      = { fg = c.fg },
    ["@variable.builtin"]              = { link = "Constant" }, -- e.g. this, self
    ["@variable.parameter"]            = { fg = c.fg },
    ["@variable.parameter.builtin"]    = { fg = c.fg },
    ["@variable.member"]               = { fg = c.fg },
    ["@constant"]                      = { link = "Constant" },
    ["@constant.macro"]                = { link = "Constant" },
    ["@constant.builtin"]              = { link = "Constant" },
    ["@module"]                        = { fg = c.fg },
    ["@module.builtin"]                = { link = "Special" },
    ["@label"]                         = { link = "Structure" },
    ["@string"]                        = { link = "String" },
    ["@string.documentation"]          = { link = "Comment" },
    ["@string.regexp"]                 = { link = "String" },
    ["@string.escape"]                 = { link = "Special" },
    ["@string.special"]                = { link = "Special" },
    ["@string.special.symbol"]         = { link = "Special" },
    ["@string.special.path"]           = { link = "Special" },
    ["@string.special.url"]            = { link = "Underlined" },
    ["@character"]                     = { link = "Character" },
    ["@character.special"]             = { fg = c.identifier },
    ["@boolean"]                       = { link = "Boolean" },
    ["@number"]                        = { link = "Number" },
    ["@number.float"]                  = { link = "Number" },
    ["@type"]                          = { link = "Type" },
    ["@type.builtin"]                  = { link = "Type" },
    ["@type.definition"]               = { fg = c.fg },
    ["@attribute"]                     = { link = "Keyword" },
    ["@attribute.builtin"]             = { link = "Keyword" },
    ["@property"]                      = { link = "Identifier"},
    ["@function"]                      = { link = "Function" },
    ["@function.builtin"]              = { link = "Function" },
    ["@function.call"]                 = { link = "Function" },
    ["@function.macro"]                = { link = "Macro" },
    ["@function.method"]               = { link = "Function" },
    ["@function.method.call"]          = { link = "Function" },
    ["@constructor"]                   = { fg = c.fg },
    ["@operator"]                      = { link = "Operator" },
    ["@keyword"]                       = { link = "Keyword" },
    ["@keyword.coroutine"]             = { link = "Keyword" },
    ["@keyword.function"]              = { link = "Keyword" },
    ["@keyword.operator"]              = { link = "Operator" },
    ["@keyword.import"]                = { link = "Include" },
    ["@keyword.type"]                  = { link = "Keyword" },
    ["@keyword.modifier"]              = { link = "Keyword" },
    ["@keyword.repeat"]                = { link = "Repeat" },
    ["@keyword.return"]                = { link = "Keyword"},
    ["@keyword.debug"]                 = { link = "Keyword" },
    ["@keyword.exception"]             = { link = "Exception" },
    ["@keyword.conditional"]           = { link = "Conditional" },
    ["@keyword.conditional.ternary"]   = { link = "Conditional" },
    ["@keyword.directive"]             = { link = "Keyword" },
    ["@keyword.directive.define"]      = { link = "Keyword" },
    ["@punctuation"]                   = { link = "Keyword" },
    ["@punctuation.delimiter"]         = { link = "Delimiter" },
    ["@punctuation.bracket"]           = { fg = c.fg },
    ["@punctuation.special"]           = { fg = c.fg },
    ["@comment"]                       = { link = "Comment" },
    ["@comment.documentation"]         = { link = "Comment" },
    ["@comment.error"]                 = { fg = c.danger },
    ["@comment.warning"]               = { fg = c.warning },
    ["@comment.todo"]                  = { fg = c.info },
    ["@comment.note"]                  = { fg = c.emphasis },
    ["@markup.strong"]                 = { bold = true },
    ["@markup.italic"]                 = { italic = true },
    ["@markup.strikethrough"]          = { fg = c.danger, strikethrough = true },
    ["@markup.underline"]              = { underline = true },
    ["@markup.heading"]                = { fg = c.emphasis, bold = true },
    ["@markup.heading.gitcommit"]      = { fg = c.fg },
    ["@markup.heading.1.markdown"]     = { link = "@markup.heading" },
    ["@markup.heading.2.markdown"]     = { link = "@markup.heading" },
    ["@markup.heading.3.markdown"]     = { link = "@markup.heading" },
    ["@markup.heading.4.markdown"]     = { link = "@markup.heading" },
    ["@markup.heading.5.markdown"]     = { link = "@markup.heading" },
    ["@markup.heading.6.markdown"]     = { link = "@markup.heading" },
    ["@markup.quote"]                  = { link = "Comment" },
    ["@markup.math"]                   = { link = "Special" },
    ["@markup.link"]                   = { fg = c.emphasis, underline = true },
    ["@markup.link.label"]             = { fg = c.emphasis, underline = false },
    ["@markup.link.url"]               = { fg = c.info, underline = true },
    ["@markup.raw"]                    = { fg = c.const },
    ["@markup.raw.block"]              = { fg = c.const },
    ["@markup.list"]                   = { fg = c.emphasis },
    ["@markup.list.checked"]           = { fg = c.success },
    ["@markup.list.unchecked"]         = { fg = c.danger },
    ["@diff.plus"]                     = { link = "DiffAdd" },
    ["@diff.minus"]                    = { link = "DiffDelete" },
    ["@diff.delta"]                    = { link = "DiffChange" },
    ["@tag"]                           = { link = "Keyword" },
    ["@tag.builtin"]                   = { fg = c.fg },
    ["@tag.delimiter"]                 = { link = "Keyword" },
    ["@tag.attribute"]                 = { link = "Keyword" },

    -- LSP
    DiagnosticError                          = { fg = c.danger },
    DiagnosticHint                           = { fg = c.info },
    DiagnosticInfo                           = { fg = c.fg },
    DiagnosticOK                             = { fg = c.success },
    DiagnosticWarn                           = { fg = c.warning },
    DiagnosticUnderlineError                 = { sp = c.danger, underline = true },
    DiagnosticUnderlineHint                  = { sp = c.info, underline = true },
    DiagnosticUnderlineInfo                  = { sp = c.fg, underline = true },
    DiagnosticUnderlineOK                    = { sp = c.success, underline = true },
    DiagnosticUnderlineWarn                  = { sp = c.warning, underline = true },
    LspInlayHint                             = { fg = c.comment },
    ["@lsp.type.comment"]                    = {}, -- use treesitter styles
    ["@lsp.type.lifetime"]                   = { fg = c.const },
    ["@lsp.type.modifier"]                   = { link = "Keyword" },
    ["@lsp.type.struct"]                     = { fg = c.fg },
    ["@lsp.typemod.namespace.attribute"]     = { link = "Keyword" },
    ["@lsp.typemod.interface.declaration"]   = { fg = c.fg },
    ["@lsp.typemod.interface.public"]        = { fg = c.fg },
    ["@lsp.typemod.struct.declaration"]      = { fg = c.fg },
    ["@lsp.typemod.enum.declaration"]        = { fg = c.fg },
    ["@lsp.typemod.type.declaration"]        = { fg = c.fg },
    ["@lsp.typemod.class.declaration"]       = { fg = c.fg },
    ["@lsp.typemod.class.globalScope"]       = { fg = c.fg },
    ["@lsp.typemod.generic.attribute"]       = { fg = c.fg },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    -- ["@lsp.type.namespace"]                = { fg = c.keyword },
}

for group, opts in pairs(groups) do
    vim.api.nvim_set_hl(0, group, opts)
end

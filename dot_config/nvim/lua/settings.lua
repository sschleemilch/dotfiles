vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.o.clipboard = 'unnamedplus' -- Always sync clipboard with OS

vim.o.wrap = false -- Do not wrap long lines

-- Indents
vim.o.shiftwidth = 4 -- size of an indent
vim.o.tabstop = 4 -- Number of spaces tabs count for
vim.o.smartindent = true -- Smartly indent newlines

vim.o.expandtab = true -- Expands tabs to spaces

vim.o.ignorecase = true
vim.o.smartcase = true -- Not ignoring case if search contains capital letters

vim.o.undofile = true -- Stores undo history persistent
vim.o.writebackup = false -- Don't store backup while overwriting the file
vim.o.signcolumn = 'yes' -- Always show sign column
vim.o.updatetime = 300 -- Lower update time. Triggers CursorHold earlier
vim.o.scrolloff = 8 -- Keep more context when scrolling

vim.o.foldlevelstart = 99 -- Do not fold initially
vim.wo.foldtext = '' -- Do not modify the line that is folded

vim.opt.fillchars = {
    eob = ' ',
    fold = ' ',
}

-- Max completion menu entries
vim.o.pumheight = 15

-- Diagnostics
local diagnostic_opts = {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '●',
            [vim.diagnostic.severity.WARN] = '●',
            [vim.diagnostic.severity.HINT] = '●',
            [vim.diagnostic.severity.INFO] = '●',
        },
    },
    virtual_text = {
        current_line = true,
        prefix = '',
    },
}

MiniDeps.later(function()
    vim.diagnostic.config(diagnostic_opts)
end)

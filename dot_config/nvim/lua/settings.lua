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
vim.o.winborder = 'single' -- floating border style
vim.o.scrolloff = 8 -- Keep more context when scrolling

vim.o.fillchars = 'eob: ' -- Remove ~ from end of file

-- Max completion menu entries
vim.o.pumheight = 15

-- Diagnostics
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
        },
    },
    virtual_text = {
        current_line = true,
        prefix = '',
    },
})

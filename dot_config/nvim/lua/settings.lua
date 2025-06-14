vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.o.clipboard = 'unnamedplus' -- Always sync clipboard with OS

vim.o.wrap = false -- Do not wrap long lines

-- Indents
vim.o.shiftwidth = 4 -- size of an indent
vim.o.tabstop = 4 -- Number of spaces tabs count for
vim.o.smartindent = true -- Smartly indent newlines

vim.o.expandtab = true -- Expands tabs to spaces

-- Linue numbers
vim.wo.nu = true -- shows the abolsute line number at cursor
vim.wo.rnu = true -- and relative line numbers above and below

vim.o.undofile = true -- Stores undo history persistent
vim.o.writebackup = false -- Don't store backup while overwriting the file
vim.o.signcolumn = 'yes' -- Always show sign column
vim.opt.shortmess:append({ I = true }) -- Disable intro message
vim.o.updatetime = 300 -- Lower update time. Triggers CursorHold earlier
vim.o.winborder = 'single' -- floating border style
vim.o.scrolloff = 8 -- Keep more context when scrolling

-- Diagnostics
vim.diagnostic.config({
    virtual_text = {
        current_line = true,
        prefix = '',
    },
})

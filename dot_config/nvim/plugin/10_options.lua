vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.o.clipboard = 'unnamedplus' -- Always sync clipboard with OS

-- Indents
vim.o.shiftwidth = 4 -- size of an indent
vim.o.tabstop = 4 -- Number of spaces tabs count for
vim.o.smartindent = true -- Smartly indent newlines

vim.o.expandtab = true -- Expands tabs to spaces

vim.o.wrap = false -- Disables line wrapping

vim.o.ignorecase = true
vim.o.smartcase = true -- Not ignoring case if search contains capital letters

vim.o.undofile = true -- Stores undo history persistent
vim.o.writebackup = false -- Don't store backup while overwriting the file
vim.o.signcolumn = 'yes' -- Always show sign column
vim.o.updatetime = 300 -- Lower update time. Triggers CursorHold earlier
vim.o.winborder = 'single' -- floating border style
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
vim.diagnostic.config({
    virtual_text = {
        current_line = true,
        prefix = '',
    },
})

require('vim._extui').enable({})

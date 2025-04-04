-- <space> is leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- UI characters
local arrows = require('icons').arrows
vim.opt.fillchars = {
  eob = ' ',
  fold = ' ',
  foldclose = arrows.right,
  foldopen = arrows.down,
  foldsep = ' ',
  msgsep = '─',
  stl = ' ',
}

-- Folding
vim.o.foldlevel = 99
vim.o.foldcolumn = '0'
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'expr'
vim.wo.foldtext = ''
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Highlight cursor line
vim.o.cursorline = true

-- Sync clipboard with OS
vim.o.clipboard = 'unnamedplus'

-- Wrap long lines at words
vim.o.linebreak = true

-- Indents
vim.o.shiftwidth = 2 -- size of an indent
vim.o.tabstop = 2 -- Number of spaces tabs count for
vim.o.expandtab = true -- Use spaces instead of tabs

-- Line Numbers
vim.wo.number = true

-- Show whitespaces
vim.opt.list = true
vim.opt.listchars = { space = ' ', trail = '⋅', tab = '  ' }

-- Stores undo history for a file
vim.o.undofile = true

-- Case insensitive searching unless search has capitals
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enable mouse
vim.o.mouse = 'a' -- Enable mouse

-- Status line
vim.o.laststatus = 3
vim.o.cmdheight = 1

-- Completion
vim.o.pumheight = 15 -- Max popup entries
vim.o.completeopt = 'menuone,noselect,noinsert'

-- Always show sign column
vim.o.signcolumn = 'yes'

vim.opt.shortmess:append { I = true, c = true, C = true, w = true, s = true }

-- Update times and timeouts.
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

-- Rounded floating borders
vim.o.winborder = 'rounded'

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

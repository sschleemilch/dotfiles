vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local opt = vim.opt -- for conciseness

opt.autowrite = true -- write contents on buffer switch etc
opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus' -- Sync with system clipboard
opt.completeopt = 'menu,menuone,noselect' -- configures the completion behavior
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = false -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Whether to highlight the cursorline
opt.expandtab = true -- Use spaces instead of tabs

local arrows = require('icons').arrows
opt.fillchars = {
  eob = ' ',
  fold = ' ',
  foldclose = arrows.right,
  foldopen = arrows.down,
  foldsep = ' ',
  msgsep = '─',
  stl = ' ',
}
opt.foldlevel = 99
opt.foldcolumn = '0'
opt.foldlevelstart = 99
opt.foldmethod = 'expr'
opt.foldtext = ''
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

opt.cmdheight = 1 -- 0 for noice and the statusline being instantly on bottom

opt.ignorecase = true
opt.inccommand = 'nosplit'
opt.jumpoptions = 'view'
opt.laststatus = 3
opt.linebreak = true -- line breaks at convenient points
opt.list = true -- Show some invisible characters such as tabs
opt.listchars = {
  tab = '  ',
  trail = '·',
  extends = '»',
  precedes = '«',
}
opt.mouse = 'a' -- Enable mouse
opt.number = false -- line numbers
opt.relativenumber = false -- relative line numbers
opt.pumheight = 10 -- Max popup entries
opt.scrolloff = 4 -- lines of context on borders
opt.sidescrolloff = 8 -- columns context
opt.shiftround = true -- round indent
opt.shiftwidth = 2 -- size of an indent
opt.shortmess:append { I = true, c = true, C = true }
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { 'en' }
opt.spelloptions:append('noplainbuffer') -- only check spelling when syntax enabled
opt.splitbelow = true -- New windows below on hsplit
opt.splitright = true -- New windows right on vsplit
opt.splitkeep = 'screen' -- Keeps text on the same screen line
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.undofile = true -- Stores undo history for a file
opt.undolevels = 10000 -- Max number of changes that can be undone
opt.timeoutlen = 1000 -- Set to lower for which-key, default: 1000
opt.updatetime = 300 -- Save swap after this ms and trigger CursorHold default 4000
opt.virtualedit = 'block' -- Allow virtual editing in Visual block mode.
opt.wildmode = 'longest:full,full' -- Command-Line completion mode
opt.winminwidth = 5 -- Min window width
opt.wrap = false -- Disable line wrap
opt.smoothscroll = true

return {
  {
    'echasnovski/mini.files',
    version = false,
    lazy = false,
    config = true,
    keys = {
      {
        '<leader>e',
        function()
          local minifiles = require('mini.files')
          minifiles.open(vim.api.nvim_buf_get_name(0))
          minifiles.reveal_cwd()
        end,
        desc = 'Explorer',
      },
    },
  },
  -- search/replace in multiple files
  {
    'MagicDuck/grug-far.nvim',
    opts = {
      headerMaxWidth = 80,
    },
    cmd = 'GrugFar',
    config = true,
    mode = { 'n', 'v' },
    keys = {
      {
        '<leader>sr',
        '<cmd>GrugFar<cr>',
        desc = 'Replace in files (Grug-far)',
      },
    },
  },
  {
    'ibhagwan/fzf-lua',
    lazy = false,
    dependencies = {
      'mini.icons',
    },
    cmd = 'FzfLua',
    opts = {
      winopts = {
        backdrop = 100,
        height = 0.7,
        width = 0.6,
        border = 'rounded',
        preview = {
          hidden = 'hidden',
        },
        fullscreen = false,
      },
      oldfiles = {
        cwd_only = true,
      },
      fzf_opts = {
        ['--padding'] = '1,1,2,2',
      },
      fzf_colors = true,
    },
    init = function()
      require('fzf-lua').register_ui_select()
    end,
    keys = {
      { '<leader><leader>', '<cmd>FzfLua files<cr>', desc = 'Files' },
      { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Buffers' },
      { '<leader>,', '<cmd>FzfLua buffers<cr>', desc = 'Buffers' },
      { '<leader>fb', '<cmd>FzfLua buffers<cr>', desc = 'Buffers' },
      { '<leader>/', '<cmd>FzfLua live_grep<cr>', desc = 'Grep' },
      { '<leader>fg', '<cmd>FzfLua live_grep<cr>', desc = 'Grep' },
      { '<leader>fr', '<cmd>FzfLua oldfiles<cr>', desc = 'Files recent' },
      { '<leader>fh', '<cmd>FzfLua helptags<cr>', desc = 'Help' },
      { '<leader>fq', '<cmd>FzfLua quickfix<cr>', desc = 'Quickfix' },
      { '<leader>fs', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Symbols' },
      { '<leader>fd', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Diagnostics' },
      { '<leader>fz', '<cmd>FzfLua<cr>', desc = 'Fzf' },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      signs_staged = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    lazy = false,
    opts = {},
    keys = {
      { '<leader>ft', '<cmd>TodoQuickFix<cr>', desc = 'Todos' },
    },
  },
  {
    'folke/flash.nvim',
    opts = {},
    lazy = false,
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'o', 'x' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
    },
  },
  {
    'echasnovski/mini.hipatterns',
    opts = function()
      local hi = require('mini.hipatterns')
      return {
        highlighters = {
          hex_color = hi.gen_highlighter.hex_color { priority = 2000 },
        },
      }
    end,
    config = function(_, opts)
      require('mini.hipatterns').setup(opts)
    end,
  },
}

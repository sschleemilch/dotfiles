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
      {
        '<leader>ft',
        function()
          Snacks.picker.todo_comments()
        end,
        desc = 'Todo',
      },
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

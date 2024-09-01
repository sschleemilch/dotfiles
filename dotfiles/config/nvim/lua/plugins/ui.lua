return {
  {
    'echasnovski/mini.icons',
    enabled = true,
    lazy = true,
    opts = {},
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    enabled = true,
    opts = {
      indent = {
        char = '╎',
        tab_char = '│',
      },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          'fzf',
          'help',
          'lazy',
          'mason',
        },
      },
    },
    main = 'ibl',
  },
  {
    'echasnovski/mini.notify',
    enabled = true,
    version = false,
    config = {
      window = {
        config = {
          border = 'none',
        },
      },
    },
    init = function()
      vim.notify = require('mini.notify').make_notify()
    end,
    keys = {
      {
        '<leader>nh',
        function()
          require('mini.notify').show_history()
        end,
        desc = 'Notification history',
      },
    },
  },
  {
    'sschleemilch/slimline.nvim',
    dev = false,
    opts = {
      components = {
        left = {
          "mode",
          "path",
          function ()
            return require('nvim-navic').get_location() .. '%#Slimline#'
          end
          -- function ()
          --   local navic = require('nvim-navic')
          --   local icons  = require('icons')
          --   local h = require('slimline.highlights')
          --   if not navic.is_available() then
          --     return ''
          --   end
          --   local data = navic.get_data()
          --
          --   local parts = {}
          --
          --   if data ~= nil then
          --
          --     for _, entry in ipairs(data) do
          --       table.insert(parts, h.hl_content(icons.kinds[entry.type], "Normal") .. '%#Slimline#' .. entry.name)
          --     end
          --   end
          --
          --   return "%#Slimline# " .. table.concat(parts, icons.kinds.Collapsed)
          -- end
        },
        right = {
          "diagnostics",
          "git",
          "filetype_lsp",
          "progress"
        }
      }
    },
  },
  {
    'SmiteshP/nvim-navic',
    opts = {
      -- depth_limit = 5
      highlight = true
    }
  },
}

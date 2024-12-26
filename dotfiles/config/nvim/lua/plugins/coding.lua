return {
  {
    'echasnovski/mini.pairs',
    lazy = false,
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { 'string' },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },
  {
    'folke/ts-comments.nvim',
    lazy = false,
    opts = {},
  },
  -- Fast and feature-rich surround actions. For text that includes
  -- surrounding characters like brackets or quotes, this allows you
  -- to select the text inside, change or modify the surrounding characters,
  -- and more.
  {
    'echasnovski/mini.surround',
    lazy = false,
    opts = {
      mappings = {
        add = 'gsa', -- Add surrounding in Normal and Visual modes
        delete = 'gsd', -- Delete surrounding
        find = 'gsf', -- Find surrounding (to the right)
        find_left = 'gsF', -- Find surrounding (to the left)
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr', -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`
      },
    },
  },
  {
    'saghen/blink.cmp',
    lazy = false,
    version = 'v0.*',
    config = {
      keymap = {
        preset = 'default',
      },
      completion = {
        menu = {
          auto_show = function(ctx)
            return ctx.mode ~= 'cmdline'
          end,
          border = 'rounded',
          draw = {
            columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
            treesitter = { 'lsp' },
          },
        },
        documentation = {
          window = {
            border = 'rounded',
          },
        },
      },

      signature = {
        enabled = true,
        window = {
          max_height = 1,
          border = 'rounded',
        },
      },
      appearance = {
        nerd_font_variant = 'normal',
      },
    },
  },
}

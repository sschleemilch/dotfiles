return {
  {
    'saghen/blink.cmp',
    lazy = false,
    version = 'v1.*',
    opts = {
      keymap = {
        preset = 'default',
      },
      completion = {
        menu = {
          draw = {
            treesitter = { 'lsp' },
            columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
            components = {
              kind_icon = {
                text = function(ctx)
                  local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                  return kind_icon .. ' '
                end,
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
              kind = {
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 500,
        },
      },
      signature = {
        enabled = true,
      },
    },
  },
}

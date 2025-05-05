MiniDeps.later(function()
  MiniDeps.add({
    source = 'saghen/blink.cmp',
    checkout = 'v1.2.0',
  })
  require('blink.cmp').setup({
    keymap = {
      preset = 'default',
    },
    completion = {
      menu = {
        draw = {
          columns = { { 'kind_icon' }, { 'label', gap = 1 } },
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
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
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
  })
end)

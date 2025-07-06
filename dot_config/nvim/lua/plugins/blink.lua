MiniDeps.later(function()
    MiniDeps.add({
        source = 'saghen/blink.cmp',
        checkout = 'v1.4.1',
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
                    },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
        },
        signature = {
            enabled = true,
        },
    })
end)

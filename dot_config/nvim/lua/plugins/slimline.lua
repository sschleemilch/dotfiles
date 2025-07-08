MiniDeps.now(function()
    -- MiniDeps.add({ name = 'slimline.nvim', checkout = 'HEAD' })
    MiniDeps.add('sschleemilch/slimline.nvim')
    require('slimline').setup({
        bold = false,
        style = 'bg',
        configs = {
            path = {
                icons = {
                    modified = '*',
                    read_only = '[RO]',
                },
            },
            diagnostics = {
                style = 'fg',
                workspace = true,
            },
            progress = {
                column = true,
                follow = false,
            },
        },
        spaces = {
            components = '',
            left = '',
            right = '',
        },
        sep = {
            hide = {
                first = true,
                last = true,
            },
            left = '',
            right = '',
        },
    })
end)

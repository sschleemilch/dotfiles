MiniDeps.now(function()
    -- MiniDeps.add({ name = 'slimline.nvim', checkout = 'HEAD' })
    MiniDeps.add('sschleemilch/slimline.nvim')
    require('slimline').setup({
        style = 'fg',
        hl = {
            base = 'StatusLine',
        },
        components = {
            left = {
                'mode',
                'path',
            },
        },
        spaces = {
            left = '',
            right = '',
        },
        configs = {
            diagnostics = {
                workspace = true,
                icons = {
                    ERROR = '● ',
                    WARN = '● ',
                    HINT = '● ',
                    INFO = '● ',
                },
            },
            progress = {
                column = true,
                follow = false,
            },
        },
    })
end)

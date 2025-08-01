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
        sep = {
            left = '',
            right = '',
        },
        spaces = {
            right = '',
        },
        configs = {
            mode = {
                style = 'bg',
            },
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

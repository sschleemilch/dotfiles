return {
    'sschleemilch/slimline.nvim',
    -- 'slimline.nvim',
    event = 'VeryLazy',
    -- dev = true,
    opts = {
        bold = true,
        style = 'bg',
        components = {
            left = {
                'mode',
            },
        },
        configs = {
            mode = {
                verbose = true,
            },
            diagnostics = {
                workspace = true,
            },
            progress = {
                column = true,
            },
        },

        hl = {
            primary = 'NormalFloat',
        },

        spaces = {
            left = '',
            right = '',
        },
    },
}

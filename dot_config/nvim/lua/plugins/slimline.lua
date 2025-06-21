return {
    'sschleemilch/slimline.nvim',
    -- 'slimline.nvim',
    enabled = true,
    -- dev = true,
    opts = {
        bold = false,
        style = 'bg',
        components = {
            left = {
                'path',
                ' ',
                'diagnostics',
            },
            right = {
                'progress',
            },
        },
        components_inactive = {
            left = {
                'path',
            },
            right = {
                'progress',
            },
        },
        configs = {
            diagnostics = {
                workspace = true,
                style = 'fg',
                icons = {
                    ERROR = 'E:',
                    WARN = 'W:',
                    HINT = 'H:',
                    INFO = 'I:',
                },
            },
            progress = {
                column = true,
                follow = false,
            },
        },

        hl = {
            primary = 'NormalFloat',
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
    },
}

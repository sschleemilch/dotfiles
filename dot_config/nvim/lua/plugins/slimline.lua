return {
    'sschleemilch/slimline.nvim',
    -- 'slimline.nvim',
    -- dev = true,
    opts = {
        components = {
            left = {
                'mode',
                'path',
                'diagnostics',
            },
            right = {
                'progress',
            },
        },
        components_inactive = {
            left = {
                'mode',
                'path',
            },
        },
        configs = {
            path = {
                icons = {
                    modified = '*',
                },
            },
            diagnostics = {
                workspace = true,
                icons = {
                    ERROR = 'E:',
                    WARN = 'W:',
                    HINT = 'H:',
                    INFO = 'I:',
                },
            },
            progress = {
                column = true,
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

return {
    'sschleemilch/slimline.nvim',
    -- 'slimline.nvim',
    -- dev = true,
    opts = {
        bold = false,
        style = 'bg',
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
            right = {
                'progress',
            },
        },
        configs = {
            mode = {
                sep = {
                    right = '',
                },
            },
            path = {
                sep = {
                    left = '',
                    right = '',
                },
                icons = {
                    modified = '*',
                    read_only = '[RO]',
                },
            },
            diagnostics = {
                sep = {
                    left = '',
                    right = '',
                },
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
    },
}

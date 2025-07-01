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
            path = {
                icons = {
                    modified = '*',
                    read_only = '[RO]',
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

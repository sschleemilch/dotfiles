return {
    'sschleemilch/slimline.nvim',
    -- 'slimline.nvim',
    -- dev = true,
    opts = {
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
    },
}

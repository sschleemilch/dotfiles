MiniDeps.now(function()
    -- MiniDeps.add({ name = 'slimline.nvim', checkout = 'HEAD' })
    MiniDeps.add('sschleemilch/slimline.nvim')
    require('slimline').setup({
        style = 'fg',
        components = {
            left = {
                'mode',
                'path',
            },
        },
        spaces = {
            components = '',
            left = '',
            right = '',
        },
        configs = {
            path = {
                icons = {
                    folder = '',
                },
            },
            mode = {
                format = {
                    ['n'] = { short = 'NOR' },
                    ['v'] = { short = 'VIS' },
                    ['V'] = { short = 'V-L' },
                    ['\22'] = { short = 'V-B' },
                    ['s'] = { short = 'SEL' },
                    ['S'] = { short = 'S-L' },
                    ['\19'] = { short = 'S-B' },
                    ['i'] = { short = 'INS' },
                    ['R'] = { short = 'REP' },
                    ['c'] = { short = 'CMD' },
                    ['r'] = { short = 'PRO' },
                    ['!'] = { short = 'SHE' },
                    ['t'] = { short = 'TER' },
                    ['U'] = { short = 'UNK' },
                },
            },
            diagnostics = {
                workspace = true,
                icons = {
                    ERROR = 'E:',
                    WARN = 'W:',
                    INFO = 'I:',
                    HINT = 'H:',
                },
            },
            progress = {
                column = true,
                follow = false,
            },
        },
    })
end)

require('slimline').setup({
    style = 'bg',
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
    sep = {
        hide = {
            first = true,
            last = true,
        },
        left = '',
        right = '',
    },
    configs = {
        path = {
            icons = {
                folder = '',
                modified = '*',
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
            icon = '',
            column = true,
            follow = false,
        },
    },
})

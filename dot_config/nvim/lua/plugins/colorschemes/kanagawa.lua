require('kanagawa').setup({
    undercurl = false,
    keywordStyle = { italic = false },
    colors = {
        theme = {
            all = {
                ui = {
                    bg_gutter = 'none',
                },
            },
        },
    },
})
vim.cmd('colorscheme kanagawa')

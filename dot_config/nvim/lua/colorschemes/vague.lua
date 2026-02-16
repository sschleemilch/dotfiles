return {
    src = 'https://github.com/vague2k/vague.nvim',
    setup = function()
        require('vague').setup({
            bold = false,
            italic = false,
        })
        vim.cmd.colorscheme('vague')
    end,
}

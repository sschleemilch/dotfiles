return {
    src = 'https://github.com/folke/tokyonight.nvim',
    setup = function()
        require('tokyonight').setup()
        vim.cmd.colorscheme('tokyonight-night')
    end,
}

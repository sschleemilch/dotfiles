return {
    src = 'https://github.com/nvim-mini/mini.nvim',
    setup = function()
        require('plugins.mini-icons')
        require('plugins.mini-notify')
        require('mini.extra').setup()
        require('mini.ai').setup()
        require('plugins.mini-clue')
        require('plugins.mini-completion')
        require('plugins.mini-files')
        require('plugins.mini-hipatterns')
        require('plugins.mini-pick')
        require('mini.pairs').setup()
        require('plugins.mini-surround')
        require('plugins.mini-diff')
    end,
}

MiniDeps.now(function()
    MiniDeps.add('vague2k/vague.nvim')
    require('vague').setup({
        bold = false,
        italic = false,
    })
    vim.cmd('colorscheme vague')
end)

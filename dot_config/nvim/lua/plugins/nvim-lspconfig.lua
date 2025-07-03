return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
        vim.lsp.enable({
            'lua_ls',
            'basedpyright',
            'ruff',
            'dockerls',
            'gopls',
            'ts_ls',
            'jsonls',
            'yamlls',
            'astro',
            'ltex_plus',
            'buf_ls',
            'marksman',
            'graphql',
        })
    end,
}

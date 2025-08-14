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
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
        },
    },
})

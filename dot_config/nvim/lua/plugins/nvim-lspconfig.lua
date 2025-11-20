return {
    src = 'https://github.com/neovim/nvim-lspconfig',
    setup = function()
        vim.lsp.enable({
            'lua_ls',
            'ty',
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
            'rust_analyzer',
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
    end,
}

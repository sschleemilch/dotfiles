local now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later

now_if_args(function()
    MiniDeps.add({
        source = 'nvim-treesitter/nvim-treesitter',
        checkout = 'master',
        hooks = {
            post_checkout = function()
                vim.cmd('TSUpdate')
            end,
        },
    })
    local configs = require('nvim-treesitter.configs')
    configs.setup({
        auto_install = true,
        ensure_installed = {
            'bash',
            'c',
            'cpp',
            'css',
            'csv',
            'cmake',
            'diff',
            'dockerfile',
            'gitcommit',
            'go',
            'graphql',
            'html',
            'javascript',
            'json',
            'jsonc',
            'lua',
            'luadoc',
            'luap',
            'markdown',
            'markdown_inline',
            'printf',
            'python',
            'query',
            'regex',
            'toml',
            'tsx',
            'typescript',
            'vim',
            'vimdoc',
            'xml',
            'yaml',
            'rasi',
        },
        highlight = { enable = true },
        indent = { enable = true },
    })
    MiniDeps.add('nvim-treesitter/nvim-treesitter-context')
    require('treesitter-context').setup()
end)

return {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
    setup = function()
        local ensure_installed = {
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
            'toml',
            'tsx',
            'typescript',
            'vim',
            'vimdoc',
            'xml',
            'yaml',
            'rust',
            'ron',
            'http',
        }
        local isnt_installed = function(lang)
            return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
        end
        local to_install = vim.tbl_filter(isnt_installed, ensure_installed)
        if #to_install > 0 then
            require('nvim-treesitter').install(to_install)
        end

        local filetypes = vim.iter(ensure_installed):map(vim.treesitter.language.get_filetypes):flatten():totable()
        vim.list_extend(filetypes, { 'markdown', 'pandoc' })
        local ts_start = function(ev)
            vim.treesitter.start(ev.buf)
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.cmd.normal('zx')
        end
        vim.api.nvim_create_autocmd('FileType', { pattern = filetypes, callback = ts_start })
    end,
}

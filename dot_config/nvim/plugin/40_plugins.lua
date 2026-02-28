local add = vim.pack.add
local now, now_if_args, later = Config.now, Config.now_if_args, Config.later

now_if_args(function()
    local ts_update = function()
        vim.cmd('TSUpdate')
    end
    Config.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

    add({
        'https://github.com/nvim-treesitter/nvim-treesitter',
        'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    })

    local languages = {
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
    }
    local isnt_installed = function(lang)
        return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
    end
    local to_install = vim.tbl_filter(isnt_installed, languages)
    if #to_install > 0 then
        require('nvim-treesitter').install(to_install)
    end

    local filetypes = {}
    for _, lang in ipairs(languages) do
        for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
            table.insert(filetypes, ft)
        end
    end
    local ts_start = function(ev)
        vim.treesitter.start(ev.buf)
    end
    Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
end)

now_if_args(function()
    add({ 'https://github.com/neovim/nvim-lspconfig' })

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
end)

later(function()
    add({ 'https://github.com/stevearc/conform.nvim' })

    ---@diagnostic disable-next-line: redundant-parameter
    require('conform').setup({
        formatters_by_ft = {
            lua = { 'stylua' },
            sh = { 'shfmt' },
            javascript = { 'prettier' },
            javascriptreact = { 'prettier' },
            typescript = { 'prettier' },
            typescriptreact = { 'prettier' },
            css = { 'prettier' },
            scss = { 'prettier' },
            html = { 'prettier' },
            json = { 'prettier' },
            yaml = { 'prettier' },
            markdown = { 'prettier' },
            graphql = { 'prettier' },
            go = { 'goimports', 'gofumpt' },
            proto = { 'buf' },
            astro = { 'prettier' },
            nix = { 'nixfmt' },
        },
        format_on_save = {
            timeout_ms = 1000,
            lsp_fallback = true,
        },
        default_format_opts = {
            timeout_ms = 3000,
            async = false,
            quiet = false,
            lsp_format = 'fallback',
        },
    })
end)

later(function()
    add({ 'https://github.com/tpope/vim-fugitive' })
end)

later(function()
    add({ 'https://github.com/christoomey/vim-tmux-navigator' })
end)

later(function()
    add({ 'https://github.com/folke/flash.nvim' })

    ---@diagnostic disable-next-line: redundant-parameter
    require('flash').setup({ prompt = { enabled = false } })

    vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
        require('flash').jump()
    end, { desc = 'Flash' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
        require('flash').treesitter()
    end, { desc = 'Flash Treesitter' })
end)

later(function()
    add({ 'https://github.com/williamboman/mason.nvim' })

    ---@diagnostic disable-next-line: redundant-parameter
    require('mason').setup({
        ui = {
            backdrop = 100,
        },
    })

    local ensure_installed = {
        'stylua',
        'shfmt',
        'ty',
        'ruff',
        'lua-language-server',
        'dockerfile-language-server',
        'gopls',
        'typescript-language-server',
        'astro-language-server',
        'json-lsp',
        'prettier',
        'yaml-language-server',
        'ltex-ls-plus',
        'goimports',
        'gofumpt',
        'buf',
        'marksman',
        'graphql-language-service-cli',
        'rust-analyzer',
        'nixfmt',
    }
    local mr = require('mason-registry')
    mr.refresh(function()
        for _, tool in ipairs(ensure_installed) do
            local p = mr.get_package(tool)
            if not p:is_installed() then
                p:install()
            end
        end
    end)
end)

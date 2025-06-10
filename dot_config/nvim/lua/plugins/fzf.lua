return {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    opts = function()
        local actions = require('fzf-lua.actions')
        return {
            winopts = {
                backdrop = 100,
                height = 0.7,
                width = 0.6,
                border = 'single',
                preview = {
                    hidden = 'hidden',
                },
            },
            files = {
                cwd_prompt = false,
                actions = {
                    ['enter'] = actions.file_edit,
                },
            },
            oldfiles = {
                cwd_only = true,
            },
            defaults = {
                formatter = 'path.dirname_first',
            },
            helptags = {
                actions = {
                    ['enter'] = actions.help_vert,
                },
            },
            diagnostics = {
                -- Remove dashed line between items
                multiline = 1,
            },
            hls = {
                border = 'FloatBorder',
                preview_border = 'FloatBorder',
            },
        }
    end,
    init = function()
        require('fzf-lua').register_ui_select()
    end,
    keys = {
        { '<leader><leader>', '<cmd>FzfLua files<cr>', desc = 'Files' },
        { '<leader>,', '<cmd>FzfLua buffers<cr>', desc = 'Buffers' },
        { '<leader>/', '<cmd>FzfLua live_grep<cr>', desc = 'Grep' },
        { '<leader>/', '<cmd>FzfLua grep_visual<cr>', desc = 'Grep', mode = 'x' },
        { '<leader>fr', '<cmd>FzfLua oldfiles<cr>', desc = 'Files recent' },
        { '<leader>fh', '<cmd>FzfLua helptags<cr>', desc = 'Help' },
        { '<leader>fq', '<cmd>FzfLua quickfix<cr>', desc = 'Quickfix' },
        { '<leader>fs', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Symbols' },
        { '<leader>fd', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Diagnostics Document' },
        { '<leader>fD', '<cmd>FzfLua diagnostics_workspace<cr>', desc = 'Diagnostics Workspace' },
        { 'gd', '<cmd>FzfLua lsp_definitions<cr>', desc = 'LSP definition' },
        { 'grr', '<cmd>FzfLua lsp_references<cr>', desc = 'LSP reference' },
        { '<leader>fx', '<cmd>FzfLua<cr>', desc = 'Fzf' },
    },
}

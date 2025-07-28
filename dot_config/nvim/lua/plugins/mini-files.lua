MiniDeps.later(function()
    require('mini.files').setup()
    vim.keymap.set('n', '<leader>e', function()
        local minifiles = require('mini.files')
        minifiles.open(vim.api.nvim_buf_get_name(0))
        minifiles.reveal_cwd()
    end, { desc = 'Explorer' })
    vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesWindowOpen',
        callback = function(args)
            local win_id = args.data.win_id
            local config = vim.api.nvim_win_get_config(win_id)
            config.border = 'solid'
            vim.api.nvim_win_set_config(win_id, config)
        end,
    })
end)

local ok, kulala = pcall(require, 'kulala')

if ok then
    vim.keymap.set({ 'n', 'v' }, '<localleader>s', function()
        kulala.run()
    end, { desc = 'Send Request' })

    vim.keymap.set('n', '<localleader>a', function()
        kulala.run_all()
    end, { desc = 'Send All' })

    vim.keymap.set('n', '<localleader>r', function()
        kulala.replay()
    end, { desc = 'Replay last' })

    vim.keymap.set('n', '<localleader>o', function()
        kulala.open()
    end, { desc = 'Kulala open' })

    vim.keymap.set('n', '<localleader>e', function()
        kulala.set_selected_env()
    end, { desc = 'Select environment' })

    vim.keymap.set('n', '<localleader>X', function()
        kulala.clear_cached_files()
    end, { desc = 'Clear cached files' })
else
    vim.notify('could not set http kulala keymaps', vim.log.levels.WARN)
end

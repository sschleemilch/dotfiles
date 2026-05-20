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
else
    vim.notify('could not set http kulala keymaps', vim.log.levels.WARN)
end

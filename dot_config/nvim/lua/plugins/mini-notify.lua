MiniDeps.now(function()
  require('mini.notify').setup({
    content = {
      format = function(notif)
        return ' ' .. notif.msg .. ' '
      end,
    },
    window = {
      config = {
        title = '',
      },
    },
  })
  vim.notify = MiniNotify.make_notify()

  vim.keymap.set('n', '<leader>nh', function()
    MiniNotify.show_history()
  end, { desc = 'Notification history' })
end)

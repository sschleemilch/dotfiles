return {
    'echasnovski/mini.notify',
    opts = {
        content = {
            format = function(notif)
                return ' ' .. notif.msg .. ' '
            end,
        },
        window = {
            config = {
                title = '',
                border = 'none',
            },
        },
    },
    init = function()
        vim.notify = require('mini.notify').make_notify()
    end,
    keys = {
        {
            '<leader>nh',
            function()
                MiniNotify.show_history()
            end,
            desc = 'Notification history',
        },
        {
            '<leader>nc',
            function()
                MiniNotify.clear()
            end,
            desc = 'Clear notifications',
        },
    },
}

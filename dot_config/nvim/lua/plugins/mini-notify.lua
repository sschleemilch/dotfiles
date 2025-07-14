MiniDeps.now(function()
    local ignore = {
        'ltex_plus',
    }
    local predicate = function(notif)
        return not vim.tbl_contains(ignore, notif.data.client_name)
    end
    local custom_sort = function(notif_arr)
        return MiniNotify.default_sort(vim.tbl_filter(predicate, notif_arr))
    end
    require('mini.notify').setup({
        content = {
            format = function(notif)
                return ' ' .. notif.msg .. ' '
            end,
            sort = custom_sort,
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

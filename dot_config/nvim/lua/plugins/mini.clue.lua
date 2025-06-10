return {
    'echasnovski/mini.clue',
    event = 'VeryLazy',
    opts = function()
        local miniclue = require('mini.clue')

        return {
            triggers = {
                -- Builtins.
                { mode = 'n', keys = 'g' },
                { mode = 'x', keys = 'g' },
                { mode = 'n', keys = '`' },
                { mode = 'x', keys = '`' },
                { mode = 'n', keys = '"' },
                { mode = 'x', keys = '"' },
                { mode = 'i', keys = '<C-r>' },
                { mode = 'c', keys = '<C-r>' },
                { mode = 'n', keys = '<C-w>' },
                { mode = 'n', keys = 'z' },
                -- Leader triggers.
                { mode = 'n', keys = '<leader>' },
                { mode = 'x', keys = '<leader>' },
                -- Moving between stuff.
                { mode = 'n', keys = '[' },
                { mode = 'n', keys = ']' },
            },
            clues = {
                -- Leader/movement groups.
                { mode = 'n', keys = '<leader>b', desc = '+buffers' },
                { mode = 'n', keys = '<leader>c', desc = '+code' },
                { mode = 'n', keys = '<leader>f', desc = '+find' },
                { mode = 'n', keys = '<leader>t', desc = '+toggle' },
                { mode = 'n', keys = '[', desc = '+prev' },
                { mode = 'n', keys = ']', desc = '+next' },
                -- Builtins.
                miniclue.gen_clues.builtin_completion(),
                miniclue.gen_clues.g(),
                miniclue.gen_clues.marks(),
                miniclue.gen_clues.registers(),
                miniclue.gen_clues.windows(),
                miniclue.gen_clues.z(),
            },
            window = {
                delay = 500,
                scroll_down = '<C-f>',
                scroll_up = '<C-b>',
                config = function(bufnr)
                    local max_width = 0
                    for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
                        max_width = math.max(max_width, vim.fn.strchars(line))
                    end

                    -- Keep some right padding.
                    max_width = max_width + 2

                    return {
                        width = math.min(70, max_width),
                    }
                end,
            },
        }
    end,
}

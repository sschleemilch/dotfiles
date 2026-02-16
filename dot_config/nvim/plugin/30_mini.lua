local now, now_if_args, later = Config.now, Config.now_if_args, Config.later

now(function()
    require('mini.icons').setup({
        lsp = {
            boolean = { glyph = '󰨙', hl = 'MiniIconsOrange' },
            enum = { glyph = '', hl = 'MiniIconsPurple' },
            enummember = { glyph = '', hl = 'MiniIconsYellow' },
            field = { glyph = '', hl = 'MiniIconsYellow' },
            ['function'] = { glyph = '󰊕', hl = 'MiniIconsAzure' },
            interface = { glyph = '', hl = 'MiniIconsPurple' },
            key = { glyph = '', hl = 'MiniIconsYellow' },
            method = { glyph = '󰊕', hl = 'MiniIconsAzure' },
            module = { glyph = '', hl = 'MiniIconsPurple' },
            namespace = { glyph = '󰦮', hl = 'MiniIconsRed' },
            null = { glyph = '', hl = 'MiniIconsGrey' },
            number = { glyph = '󰎠', hl = 'MiniIconsOrange' },
            object = { glyph = '', hl = 'MiniIconsGrey' },
            package = { glyph = '', hl = 'MiniIconsPurple' },
            property = { glyph = '', hl = 'MiniIconsYellow' },
            reference = { glyph = '', hl = 'MiniIconsCyan' },
            snippet = { glyph = '󱄽', hl = 'MiniIconsGreen' },
            string = { glyph = '', hl = 'MiniIconsGreen' },
            value = { glyph = '', hl = 'MiniIconsBlue' },
            variable = { glyph = '󰀫', hl = 'MiniIconsCyan' },
        },
    })
    MiniIcons.tweak_lsp_kind()
end)

now(function()
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
                border = 'single',
                title = '',
            },
        },
    })
    vim.notify = MiniNotify.make_notify()

    vim.keymap.set('n', '<leader>nh', function()
        MiniNotify.show_history()
    end, { desc = 'Notification history' })
end)

later(function()
    require('mini.extra').setup()
end)

later(function()
    require('mini.ai').setup()
end)

later(function()
    local miniclue = require('mini.clue')
    miniclue.setup({
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
            -- Moving between stuff.
            { mode = 'n', keys = '[' },
            { mode = 'n', keys = ']' },
            { mode = 'n', keys = '<Leader>' },
        },
        clues = {
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
            config = {
                border = 'single',
            },
        },
    })
end)

now_if_args(function()
    require('mini.completion').setup({
        lsp_completion = { source_func = 'omnifunc', auto_setup = false },
    })
    local on_attach = function(args)
        vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    end
    Config.new_autocmd('LspAttach', nil, on_attach, "Set 'omnifunc'")
    vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
end)

later(function()
    require('mini.files').setup()
    vim.keymap.set('n', '<leader>e', function()
        local minifiles = require('mini.files')
        minifiles.open(vim.api.nvim_buf_get_name(0))
        minifiles.reveal_cwd()
    end, { desc = 'Explorer' })
end)

later(function()
    local hipatterns = require('mini.hipatterns')
    local hi_words = MiniExtra.gen_highlighter.words
    hipatterns.setup({
        highlighters = {
            fixme = hi_words({ 'FIXME' }, 'MiniHipatternsFixme'),
            hack = hi_words({ 'HACK' }, 'MiniHipatternsHack'),
            todo = hi_words({ 'TODO' }, 'MiniHipatternsTodo'),
            note = hi_words({ 'NOTE' }, 'MiniHipatternsNote'),

            hex_color = hipatterns.gen_highlighter.hex_color(),
        },
    })
end)

later(function()
    local win_config = function()
        local height = math.floor(0.618 * vim.o.lines)
        local width = math.floor(0.618 * vim.o.columns)
        return {
            anchor = 'NW',
            height = height,
            width = width,
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
            border = 'single',
        }
    end
    require('mini.pick').setup({
        window = { config = win_config },
    })
    vim.ui.select = MiniPick.ui_select

    vim.keymap.set('n', '<leader>f', function()
        MiniPick.builtin.files()
    end, { desc = 'Find file' })
    vim.keymap.set('n', '<leader>r', function()
        MiniExtra.pickers.oldfiles({ current_dir = true })
    end, { desc = 'Find recent files' })
    vim.keymap.set('n', '<leader>b', function()
        MiniPick.builtin.buffers({ include_current = false })
    end, { desc = 'Find buffer' })
    vim.keymap.set('n', '<leader>/', function()
        MiniPick.builtin.grep_live()
    end, { desc = 'Grep' })
    vim.keymap.set('n', '<leader>ph', function()
        MiniPick.builtin.help()
    end, { desc = 'Find help page' })
    vim.keymap.set('n', '<leader>pr', function()
        MiniPick.builtin.resume()
    end, { desc = 'Resume last picker' })
    vim.keymap.set('n', '<leader>s', function()
        MiniExtra.pickers.lsp({ scope = 'document_symbol' })
    end, { desc = 'LSP Symbols (buffer)' })
    vim.keymap.set('n', '<leader>S', function()
        MiniExtra.pickers.lsp({ scope = 'workspace_symbol' })
    end, { desc = 'LSP Symbols' })
    vim.keymap.set('n', 'gd', function()
        MiniExtra.pickers.lsp({ scope = 'definition' })
    end, { desc = 'LSP Definition' })
    vim.keymap.set('n', 'grr', function()
        MiniExtra.pickers.lsp({ scope = 'references' })
    end, { desc = 'LSP References' })
    vim.keymap.set('n', '<leader>d', function()
        MiniExtra.pickers.diagnostic({ scope = 'current' })
    end, { desc = 'Diagnostics (buffer)' })
    vim.keymap.set('n', '<leader>D', function()
        MiniExtra.pickers.diagnostic({ scope = 'all' })
    end, { desc = 'Diagnostics' })
    vim.keymap.set('n', '<leader>pk', function()
        MiniExtra.pickers.keymaps()
    end, { desc = 'Keymaps' })
    vim.keymap.set('n', '<leader>pq', function()
        MiniExtra.pickers.list({ scope = 'quickfix' })
    end, { desc = 'Quickfixes' })
    vim.keymap.set('n', '<leader>j', function()
        MiniExtra.pickers.list({ scope = 'jump' })
    end, { desc = 'Jumplist' })
    vim.keymap.set('n', '<leader>pc', function()
        MiniExtra.pickers.hl_groups()
    end, { desc = 'Highlights' })
    vim.keymap.set('n', '<leader>pk', function()
        MiniExtra.pickers.keymaps()
    end, { desc = 'Keymaps' })
end)

later(function()
    require('mini.pairs').setup()
end)

later(function()
    require('mini.surround').setup({
        mappings = {
            add = 'gsa',
            delete = 'gsd',
            replace = 'gsr',
            find = '',
            find_left = '',
            highlight = '',
            update_n_lines = '',
        },
    })
end)

later(function()
    require('mini.diff').setup({
        view = {
            style = 'sign',
            signs = { add = '┃', change = '┃', delete = '_' },
        },
    })
end)

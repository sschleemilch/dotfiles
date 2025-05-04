MiniDeps.now(function()
  MiniDeps.add('folke/snacks.nvim')
  require('snacks').setup({
    input = {},
    indent = {
      indent = {
        char = '╎',
      },
      scope = {
        char = '╎',
      },
    },
    picker = {
      prompt = ' ❯ ',
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
          },
        },
      },
      sources = {
        recent = {
          filter = {
            cwd = true,
          },
        },
        buffers = {
          current = false,
        },
      },
      layout = {
        layout = {
          backdrop = false,
          box = 'horizontal',
          width = 0.7,
          min_width = 120,
          height = 0.7,
          {
            box = 'vertical',
            border = 'single',
            title = '{source} {live}',
            title_pos = 'center',
            { win = 'input', height = 1, border = 'bottom' },
            { win = 'list', border = 'none' },
          },
          { win = 'preview', border = 'single', width = 0.5 },
        },
      },
    },
    styles = {
      notification = {
        border = 'single',
      },
      input = {
        border = 'single',
      },
      notification_history = {
        border = 'single',
      },
    },
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          {
            icon = ' ',
            key = 'f',
            desc = 'find file',
            action = ":lua Snacks.dashboard.pick('files')",
          },
          {
            icon = ' ',
            key = 'r',
            desc = 'Recent Files',
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          { icon = '', key = 'e', desc = 'Explorer', action = ":lua require('mini.files').open()" },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          {
            icon = ' ',
            key = 'g',
            desc = 'Find Text',
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
      },
    },
  })
  vim.keymap.set('n', '<leader>bd', function()
    Snacks.bufdelete()
  end, { desc = 'Delete buffer' })
  vim.keymap.set('n', '<leader>nh', function()
    Snacks.notifier.show_history()
  end, { desc = 'Notification history' })
  vim.keymap.set('n', '<leader><leader>', function()
    Snacks.picker.files()
  end, { desc = 'Find file' })
  vim.keymap.set('n', '<leader>,', function()
    Snacks.picker.buffers()
  end, { desc = 'Find buffer' })
  vim.keymap.set('n', '<leader>/', function()
    Snacks.picker.grep()
  end, { desc = 'Grep' })
  vim.keymap.set('n', '<leader>fr', function()
    Snacks.picker.recent()
  end, { desc = 'Find recent file' })
  vim.keymap.set('n', '<leader>fh', function()
    Snacks.picker.help()
  end, { desc = 'Find help page' })
  vim.keymap.set('n', '<leader>fq', function()
    Snacks.picker.qflist()
  end, { desc = 'Quickfixes' })
  vim.keymap.set('n', '<leader>fs', function()
    Snacks.picker.lsp_symbols()
  end, { desc = 'LSP Symbols' })
  vim.keymap.set('n', '<leader>fd', function()
    Snacks.picker.diagnostics_buffer()
  end, { desc = 'Diagnostics (buffer)' })
  vim.keymap.set('n', '<leader>fD', function()
    Snacks.picker.diagnostics()
  end, { desc = 'Diagnostics' })
  vim.keymap.set('n', '<leader>gd', function()
    Snacks.picker.lsp_definitions()
  end, { desc = 'Goto LSP Definition' })
  vim.keymap.set('n', '<leader>grr', function()
    Snacks.picker.lsp_references()
  end, { desc = 'Goto LSP references' })
end)

MiniDeps.later(function()
  Snacks.toggle.diagnostics():map('<leader>td')
  Snacks.toggle.indent():map('<leader>ti')
  Snacks.toggle.words():map('<leader>tw')
  Snacks.toggle.dim():map('<leader>tD')
end)

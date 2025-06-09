return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    statuscolumn = {},
    input = {},
    picker = {
      prompt = Icons.arrows.right .. ' ',
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
          min_height = 15,
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
    bigfile = {},
    notifier = {},
    quickfile = {},
    words = {},
  },
  keys = {
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },
    {
      '<leader>nh',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Notification history',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>fx',
      function()
        Snacks.picker()
      end,
      desc = 'Picker',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent',
    },
    {
      '<leader>fq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>fs',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'LSP Symbols',
    },
    {
      '<leader>fd',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Diagnostics Buffer',
    },
    {
      '<leader>fD',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Diagnostics Workspace',
    },
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      'grr',
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = 'References',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Create some toggle mappings
        Snacks.toggle.diagnostics():map('<leader>ud')
        Snacks.toggle.indent():map('<leader>ui')
        Snacks.toggle.words():map('<leader>uw')
        Snacks.toggle.dim():map('<leader>uD')
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionRename',
      callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
      end,
    })

    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd('LspProgress', {
      group = augroup('lsp_progress'),
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= 'table' then
          return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ('%3d%% %s%s'):format(
                value.kind == 'end' and 100 or value.percentage or 100,
                value.title or '',
                value.message and (' **%s**'):format(value.message) or ''
              ),
              done = value.kind == 'end',
            }
            break
          end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
          return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        vim.notify(table.concat(msg, '\n'), vim.log.levels.INFO, {
          id = 'lsp_progress',
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and ' '
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
}

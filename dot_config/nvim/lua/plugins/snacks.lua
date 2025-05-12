return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    statuscolumn = {},
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
    dashboard = {
      enabled = true,
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 3 },
        { section = 'startup' },
      },
      preset = {
        header = [[
    _   __                _         
   / | / /__  ____ _   __(_)___ ___ 
  /  |/ / _ \/ __ \ | / / / __ `__ \
 / /|  /  __/ /_/ / |/ / / / / / / /
/_/ |_/\___/\____/|___/_/_/ /_/ /_/
]],
        keys = {
          {
            icon = ' ',
            key = 'f',
            desc = 'Find file',
            action = ":lua Snacks.dashboard.pick('files')",
          },
          {
            icon = ' ',
            key = 'r',
            desc = 'Recent Files',
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          { icon = '', key = 'e', desc = 'Explorer', action = ":lua require('mini.files').open()" },
          {
            icon = ' ',
            key = 'g',
            desc = 'Find Text',
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
        },
      },
    },
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
      '<leader>fh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help Pages',
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
    {
      'gri',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = 'Goto Implementation',
    },
    {
      'gy',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = 'Goto T[y]pe Definition',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Create some toggle mappings
        Snacks.toggle.diagnostics():map('<leader>td')
        Snacks.toggle.indent():map('<leader>ti')
        Snacks.toggle.words():map('<leader>tw')
        Snacks.toggle.dim():map('<leader>tD')
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
              msg = ('[%3d%%] %s%s'):format(
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

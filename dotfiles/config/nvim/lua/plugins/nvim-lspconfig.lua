return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason.nvim',
    },
    lazy = false,
    enabled = true,
    opts = function()
      local icons = require('icons')
      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = false,
          update_in_insert = false,
          virtual_text = {
            spacing = 2,
            source = 'if_many',
            prefix = '',
          },
          -- virtual_lines = {
          --   current_line = true,
          -- },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
            },
          },
        },
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        servers = {
          lua_ls = {},
          pyright = {},
          ruff = {},
          dockerls = {},
          gopls = {},
          ts_ls = {},
          jsonls = {},
          yamlls = {},
          astro = {},
          ltex = {},
          buf_ls = {},
          marksman = {},
        },
      }
      return ret
    end,
    ---@param opts PluginLspOpts
    config = function(_, opts)
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local capabilities =
        vim.tbl_deep_extend('force', {}, require('blink.cmp').get_lsp_capabilities() or {}, opts.capabilities or {})

      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        require('lspconfig')[server].setup(server_opts)
      end

      for server, _ in pairs(servers) do
        setup(server)
      end
    end,
  },
}

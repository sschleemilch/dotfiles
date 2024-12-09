return {
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = { 'mason.nvim' },
    config = function()
      local icons = require('icons')
      for type, icon in pairs(icons.diagnostics) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl })
      end
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lspconfig = require('lspconfig')

      local border = {
        { '╭', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '╮', 'FloatBorder' },
        { '│', 'FloatBorder' },
        { '╯', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '╰', 'FloatBorder' },
        { '│', 'FloatBorder' },
      }

      -- LSP settings (for overriding per client)
      local handlers = {
        ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      }

      lspconfig.pyright.setup {
        capabilities = capabilities,
        handlers = handlers,
      }
      lspconfig.ruff.setup {
        capabilities = capabilities,
      }
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim', 'Snacks', 'MiniIcons' },
            },
          },
        },
        capabilities = capabilities,
      }
      lspconfig.dockerls.setup {
        capabilities = capabilities,
      }
      lspconfig.gopls.setup {
        capabilities = capabilities,
      }
      lspconfig.ts_ls.setup {
        capabilities = capabilities,
      }
      lspconfig.jsonls.setup {
        capabilities = capabilities,
      }
      lspconfig.yamlls.setup {
        capabilities = capabilities,
      }
      lspconfig.astro.setup {
        capabilities = capabilities,
      }
      lspconfig.ltex.setup {
        capabilities = capabilities,
      }
      lspconfig.buf_ls.setup {
        capabilities = capabilities,
      }
    end,
    keys = {
      { '<leader>cl', '<cmd>LspInfo<cr>', desc = 'Lsp Info' },
      { 'gd', vim.lsp.buf.definition, desc = 'Goto Definition' },
      { 'gr', vim.lsp.buf.references, desc = 'References', nowait = true },
      { 'gI', vim.lsp.buf.implementation, desc = 'Goto Implementation' },
      { 'gy', vim.lsp.buf.type_definition, desc = 'Goto T[y]pe Definition' },
      { 'gD', vim.lsp.buf.declaration, desc = 'Goto Declaration' },
      { '<F3>', vim.lsp.buf.format, desc = 'Format' },
      { 'K', vim.lsp.buf.hover, desc = 'Hover' },
      { 'gK', vim.lsp.buf.signature_help, desc = 'Signature Help' },
      { '<c-k>', vim.lsp.buf.signature_help, mode = 'i', desc = 'Signature Help' },
      { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code Action', mode = { 'n', 'v' } },
      -- { '<leader>cc', vim.lsp.codelens.run, desc = 'Run Codelens', mode = { 'n', 'v' } },
      { '<leader>cr', vim.lsp.buf.rename, desc = 'Rename' },
    },
  },
}

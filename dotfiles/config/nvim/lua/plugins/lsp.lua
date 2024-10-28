return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = { 'mason.nvim' },
    config = function()
      local navic = require('nvim-navic')
      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end
      end

      local lspconfig = require('lspconfig')
      lspconfig.pyright.setup {
        on_attach = on_attach
      }
      lspconfig.ruff.setup {}
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
            },
          },
        },
        on_attach = on_attach,
      }
      lspconfig.dockerls.setup {}
      lspconfig.gopls.setup {
        on_attach = on_attach
      }
      lspconfig.ts_ls.setup {
        on_attach = on_attach
      }
      lspconfig.jsonls.setup {
        on_attach = on_attach
      }
      lspconfig.yamlls.setup {
        on_attach = on_attach
      }
      lspconfig.astro.setup {
        on_attach = on_attach
      }
      lspconfig.ltex.setup {
        on_attach = on_attach
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
      {
        '<leader>cC',
        vim.lsp.codelens.refresh,
        desc = 'Refresh & Display Codelens',
        mode = { 'n' },
      },
    },
  },
}

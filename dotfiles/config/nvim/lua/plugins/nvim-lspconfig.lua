return {
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = { 'mason.nvim' },
    config = function()
      local lspconfig = require('lspconfig')
      local icons = require('icons')
      for type, icon in pairs(icons.diagnostics) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl })
      end
      local capabilities = require('blink.cmp').get_lsp_capabilities()

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

      lspconfig.basedpyright.setup {
        capabilities = capabilities,
        handlers = handlers,
      }
      lspconfig.ruff.setup {
        capabilities = capabilities,
      }
      lspconfig.lua_ls.setup {
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
      { 'gD', vim.lsp.buf.declaration, desc = 'Goto Declaration' },
      { '<F3>', vim.lsp.buf.format, desc = 'Format' },
      { 'K', vim.lsp.buf.hover, desc = 'Hover' },
      { '<c-k>', vim.lsp.buf.signature_help, mode = 'i', desc = 'Signature Help' },
      { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code Action', mode = { 'n', 'v' } },
      { '<leader>cr', vim.lsp.buf.rename, desc = 'Rename' },
    },
  },
}

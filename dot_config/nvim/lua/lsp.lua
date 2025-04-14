local icons = require('icons')

vim.diagnostic.config {
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
}

local lsps = {
  "lua_ls",
  "pyright",
  "ruff",
  "dockerls",
  "gopls",
  "ts_ls",
  "jsonls",
  "yamlls",
  "astro",
  "ltex",
  "buf_ls",
  "marksman",
}

vim.lsp.enable(lsps)

MiniDeps.later(function()
  MiniDeps.add('williamboman/mason.nvim')
  require('mason').setup({ ui = { width = 1, height = 1 } })
  ensure_installed = {
    'stylua',
    'shfmt',
    'basedpyright',
    'ruff',
    'lua-language-server',
    'dockerfile-language-server',
    'gopls',
    'typescript-language-server',
    'astro-language-server',
    'json-lsp',
    'prettier',
    'yaml-language-server',
    'ltex-ls',
    'goimports',
    'gofumpt',
    'buf',
    'marksman',
  }
  local mr = require('mason-registry')
  mr.refresh(function()
    for _, tool in ipairs(ensure_installed) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end)
end)

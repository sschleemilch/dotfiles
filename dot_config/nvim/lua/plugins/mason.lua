require('mason').setup({
    ui = {
        backdrop = 100,
    },
})
local ensure_installed = {
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
    'ltex-ls-plus',
    'goimports',
    'gofumpt',
    'buf',
    'marksman',
    'graphql-language-service-cli',
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

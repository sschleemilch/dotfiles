return {
  'SmiteshP/nvim-navic',
  opts = function()
    local MiniIcons = require('mini.icons')
    return {
      lsp = {
        auto_attach = true,
      },
      highlight = true,
      depth_limit = 5,
      icons = {
        Array = MiniIcons.get('lsp', 'array') .. ' ',
        Boolean = MiniIcons.get('lsp', 'boolean') .. ' ',
        Class = MiniIcons.get('lsp', 'class') .. ' ',
        Constant = MiniIcons.get('lsp', 'constant') .. ' ',
        Constructor = MiniIcons.get('lsp', 'constructor') .. ' ',
        Enum = MiniIcons.get('lsp', 'enum') .. ' ',
        EnumMember = MiniIcons.get('lsp', 'enummember') .. ' ',
        Event = MiniIcons.get('lsp', 'event') .. ' ',
        Field = MiniIcons.get('lsp', 'field') .. ' ',
        File = MiniIcons.get('lsp', 'file') .. ' ',
        Function = MiniIcons.get('lsp', 'function') .. ' ',
        Interface = MiniIcons.get('lsp', 'interface') .. ' ',
        Key = MiniIcons.get('lsp', 'key') .. ' ',
        Method = MiniIcons.get('lsp', 'method') .. ' ',
        Module = MiniIcons.get('lsp', 'module') .. ' ',
        Namespace = MiniIcons.get('lsp', 'namespace') .. ' ',
        Null = MiniIcons.get('lsp', 'null') .. ' ',
        Number = MiniIcons.get('lsp', 'number') .. ' ',
        Object = MiniIcons.get('lsp', 'object') .. ' ',
        Operator = MiniIcons.get('lsp', 'operator') .. ' ',
        Package = MiniIcons.get('lsp', 'package') .. ' ',
        Property = MiniIcons.get('lsp', 'property') .. ' ',
        String = MiniIcons.get('lsp', 'string') .. ' ',
        TypeParameter = MiniIcons.get('lsp', 'typeparameter') .. ' ',
        Variable = MiniIcons.get('lsp', 'variable') .. ' ',
      },
    }
  end,
}

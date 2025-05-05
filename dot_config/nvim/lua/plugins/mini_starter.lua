MiniDeps.now(function()
  local starter = require('mini.starter')
  starter.setup({
    evaluate_single = true,
    items = {
      { name = 'Files', action = 'lua Snacks.picker.files()', section = '' },
      { name = 'Recent', action = 'lua Snacks.picker.recent()', section = '' },
      { name = 'Grep', action = 'lua Snacks.picker.grep()', section = '' },
      { name = 'Explorer', action = 'lua MiniFiles.open()', section = '' },
      { name = 'Quit', action = 'qall', section = '' },
    },
    footer = '',
    content_hooks = {
      starter.gen_hook.adding_bullet(Icons.separators.block .. ' '),
      starter.gen_hook.aligning('center', 'center'),
    },
  })
end)

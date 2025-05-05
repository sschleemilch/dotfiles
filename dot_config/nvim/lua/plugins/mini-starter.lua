MiniDeps.now(function()
  local starter = require('mini.starter')
  starter.setup({
    evaluate_single = true,
    items = {
      { name = 'Files', action = 'Pick files', section = '' },
      { name = 'Recent', action = 'Pick oldfiles current_dir=true', section = '' },
      { name = 'Grep', action = 'Pick grep_live', section = '' },
      { name = 'Explorer', action = 'lua MiniFiles.open()', section = '' },
      { name = 'Update', action = 'DepsUpdate', section = '' },
      { name = 'Help', action = 'Pick help', section = '' },
      { name = 'Quit', action = 'qall', section = '' },
    },
    header = [[
    _   __                _
   / | / /__  ____ _   __(_)___ ___
  /  |/ / _ \/ __ \ | / / / __ `__ \
 / /|  /  __/ /_/ / |/ / / / / / / /
/_/ |_/\___/\____/|___/_/_/ /_/ /_/
    ]],
    footer = '',
    content_hooks = {
      starter.gen_hook.adding_bullet(Icons.separators.block .. ' '),
      starter.gen_hook.aligning('center', 'center'),
    },
  })
end)

return {
  {
    'folke/todo-comments.nvim',
    lazy = false,
    opts = {},
    keys = {
      {
        '<leader>ft',
        function()
          Snacks.picker.todo_comments()
        end,
        desc = 'Todo',
      },
    },
  },
}

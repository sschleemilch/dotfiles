return {
  'echasnovski/mini.tabline',
  version = false,
  opts = {
    format = function(buf_id, label)
      local suffix = vim.bo[buf_id].modified and '󰏫' or ''
      return MiniTabline.default_format(buf_id, label) .. suffix
    end,
  },
  enabled = true,
}

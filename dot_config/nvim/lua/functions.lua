_G.close_other_buffers = function()
  local current_bufnr = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  for _, bufnr in ipairs(buffers) do
    if bufnr ~= current_bufnr and vim.api.nvim_buf_is_loaded(bufnr) then
      vim.api.nvim_buf_delete(bufnr, {})
    end
  end
end

_G.augroup = function(name)
  return vim.api.nvim_create_augroup('sschleemilch/' .. name, { clear = true })
end

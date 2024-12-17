local M = {}
function M.update()
  if vim.bo.buftype ~= '' then
    return ''
  end
  local file = vim.fn.expand('%:t')
  if vim.bo.modified then
    file = file .. ' '
  end
  if vim.bo.readonly then
    file = file .. ' '
  end
  local path = vim.fs.normalize(vim.fn.expand('%:.:h'))
  if path == '.' then
    path = ''
  end
  if path ~= '' then
    path = string.gsub(path, '/', ' > ') .. ' > '
  end
  vim.wo.winbar = '%#Comment#%= ' .. path .. '%#Normal#' .. file .. '%='
end

return M

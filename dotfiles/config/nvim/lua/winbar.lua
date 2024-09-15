local M = {}
function M.render()
  return '%#Slimline# ' .. require('nvim-navic').get_location() .. '%#Slimline#'
end

vim.o.winbar = "%!v:lua.require'winbar'.render()"

return M

local augroup = vim.api.nvim_create_augroup("zenline", { clear = true })

vim.api.nvim_create_autocmd("User", {
  group = augroup,
  pattern = "GitSignsUpdate",
  callback = function()
    require("statusline").refresh()
  end
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  group = augroup,
  callback = function()
    require("statusline").refresh()
  end,
})
vim.api.nvim_create_autocmd("Colorscheme", {
  group = augroup,
  callback = function()
    require("statusline").hl_cache = {}
  end,
})

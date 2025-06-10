local M = {}
---@return string
function M.render()
    local abs_path = vim.fs.normalize(vim.fn.expand('%:p') --[[@as string]])

    -- No special styling for diff views.
    if vim.startswith(abs_path, 'diffview') then
        return string.format('%%#Winbar#%s', abs_path)
    end

    local separator = '%#WinbarSeparator#' .. ' -> '

    local path, filename = vim.fn.fnamemodify(abs_path, ':.:h'), vim.fn.fnamemodify(abs_path, ':t')
    local dir_icon, dir_hl = MiniIcons.get('directory', path)

    if path == '.' then
        path = ''
    else
        path = path .. separator
    end

    local MiniIcons = require('mini.icons')
    local prefix = string.format('%%#%s#%s %%#Winbar#%s', dir_hl, dir_icon, separator)

    local file_icon, file_hl = MiniIcons.get('file', abs_path)

    return table.concat({
        ' ',
        prefix,
        table.concat(
            vim.iter(vim.split(path, '/'))
                :map(function(segment)
                    return string.format('%%#Winbar#%s', segment)
                end)
                :totable(),
            separator
        ),
        string.format('%%#%s#%s %%#Normal#%s', file_hl, file_icon, filename),
    })
end

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    group = augroup('winbar'),
    desc = 'Attach winbar',
    callback = function(args)
        if
            not vim.api.nvim_win_get_config(0).zindex -- Not a floating window
            and vim.bo[args.buf].buftype == '' -- Normal buffer
            and vim.api.nvim_buf_get_name(args.buf) ~= '' -- Has a file name
            and not vim.wo[0].diff -- Not in diff mode
        then
            vim.wo.winbar = "%{%v:lua.require'winbar'.render()%}"
        end
    end,
})

return M

-- Cache for the last known buffer diagnostics
local last_buffer_diagnostics = {}

---@param diagnostic vim.Diagnostic
---@return {ERROR: integer, WARN: integer, INFO: integer, HINT: integer}
local function count_diagnostics(diagnostic)
    local count = {
        ERROR = 0,
        WARN = 0,
        INFO = 0,
        HINT = 0,
    }
    for _, diag in ipairs(diagnostic) do
        local sev = vim.diagnostic.severity[diag.severity]
        count[sev] = count[sev] + 1
    end
    return count
end

---@param buffer_count integer
---@param workspace_count integer
---@param prefix string
---@param hl_suffix string
---@return string
local function render_component(buffer_count, workspace_count, prefix, hl_suffix)
    local ret = ''
    if buffer_count > 0 or workspace_count > 0 then
        ret = ret .. string.format('%%#DiagnosticVirtualText%s# %s: ', hl_suffix, prefix)
        if buffer_count > 0 then
            ret = ret .. string.format('%d', buffer_count)
        end
        if buffer_count ~= workspace_count then
            ret = ret .. string.format('(%d)', workspace_count)
        end
        ret = ret .. ' '
    end
    return ret
end

---@param buf_nr integer
---@param diagnostics vim.Diagnostic[]
local function update_winbar(buf_nr, diagnostics)
    if
        not vim.api.nvim_win_get_config(0).zindex -- Not a floating window
        and vim.bo[buf_nr].buftype == '' -- Normal buffer
        and vim.api.nvim_buf_get_name(buf_nr) ~= '' -- Has a file name
        and not vim.wo[0].diff -- Not in diff mode
        and vim.api.nvim_get_mode().mode ~= 'i' -- Not in insert mode
    then
        local buffer_count = count_diagnostics(diagnostics)
        local workspace_count = count_diagnostics(vim.diagnostic.get(nil))
        local content = table.concat({
            '%=',
            render_component(buffer_count.ERROR, workspace_count.ERROR, 'E', 'Error'),
            render_component(buffer_count.WARN, workspace_count.WARN, 'W', 'Warn'),
            render_component(buffer_count.INFO, workspace_count.INFO, 'I', 'Info'),
            render_component(buffer_count.HINT, workspace_count.HINT, 'H', 'Hint'),
        }, '')
        content = content .. '%#WinBar# '
        vim.wo.winbar = content
    end
end

vim.api.nvim_create_autocmd({ 'ModeChanged', 'BufEnter' }, {
    group = augroup('winbar/attach'),
    desc = 'Attach winbar',
    callback = function()
        local buf_nr = vim.api.nvim_get_current_buf()
        -- Use cached diagnostics if available, otherwise get fresh ones
        local diagnostics = last_buffer_diagnostics[buf_nr] or vim.diagnostic.get(buf_nr)
        update_winbar(buf_nr, diagnostics)
    end,
})

vim.api.nvim_create_autocmd('DiagnosticChanged', {
    group = augroup('winbar/diagnostics'),
    callback = function(args)
        -- Store the latest diagnostics for this buffer
        last_buffer_diagnostics[args.buf] = args.data.diagnostics
        update_winbar(args.buf, args.data.diagnostics)
    end,
})

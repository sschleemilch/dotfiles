local diagnostic_hls = {
    [vim.diagnostic.severity.ERROR] = '%#DiagnosticError#',
    [vim.diagnostic.severity.WARN] = '%#DiagnosticWarn#',
    [vim.diagnostic.severity.INFO] = '%#DiagnosticInfo#',
    [vim.diagnostic.severity.HINT] = '%#DiagnosticHint#',
}

local user_signs = vim.tbl_get(vim.diagnostic.config() --[[@as vim.diagnostic.Opts]], 'signs', 'text') or {}
local signs = vim.tbl_extend('keep', user_signs, { 'E', 'W', 'I', 'H' })

vim.o.showmode = false

local separator = ' ▪ '

local mode_hl_normal = vim.api.nvim_get_hl(0, { name = 'MiniStatuslineModeNormal', link = false })
local mode_hl_visual = vim.api.nvim_get_hl(0, { name = 'MiniStatuslineModeVisual', link = false })
local mode_hl_insert = vim.api.nvim_get_hl(0, { name = 'MiniStatuslineModeInsert', link = false })
local mode_hl_replace = vim.api.nvim_get_hl(0, { name = 'MiniStatuslineModeReplace', link = false })
local mode_hl_command = vim.api.nvim_get_hl(0, { name = 'MiniStatuslineModeCommand', link = false })
local mode_hl_other = vim.api.nvim_get_hl(0, { name = 'MiniStatuslineModeOther', link = false })
local mode_hl_inactive = vim.api.nvim_get_hl(0, { name = 'StatusLineNC', link = false })
local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })

vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormalSep', { fg = mode_hl_normal.bg })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsertSep', { fg = mode_hl_insert.bg })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisualSep', { fg = mode_hl_visual.bg })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeReplaceSep', { fg = mode_hl_replace.bg })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommandSep', { fg = mode_hl_command.bg })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeOtherSep', { fg = mode_hl_other.bg })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeInactive', { bg = mode_hl_inactive.fg, fg = normal.bg, bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeInactiveSep', { fg = mode_hl_inactive.bg })

-- Note that: \19 = ^S and \22 = ^V.
local mode_map = {
    ['n']   = { display = 'NOR', hl = 'MiniStatuslineModeNormal', sep = 'MiniStatuslineModeNormalSep' },
    ['v']   = { display = 'VIS', hl = 'MiniStatuslineModeVisual', sep = 'MiniStatuslineModeVisualSep' },
    ['V']   = { display = 'V-L', hl = 'MiniStatuslineModeVisual', sep = 'MiniStatuslineModeVisualSep' },
    ['\22'] = { display = 'V-B', hl = 'MiniStatuslineModeVisual', sep = 'MiniStatuslineModeVisualSep' },
    ['s']   = { display = 'SEL', hl = 'MiniStatuslineModeVisual', sep = 'MiniStatuslineModeVisualSep' },
    ['S']   = { display = 'S-L', hl = 'MiniStatuslineModeVisual', sep = 'MiniStatuslineModeVisualSep' },
    ['\19'] = { display = 'S-B', hl = 'MiniStatuslineModeVisual', sep = 'MiniStatuslineModeVisualSep' },
    ['i']   = { display = 'INS', hl = 'MiniStatuslineModeInsert', sep = 'MiniStatuslineModeInsertSep' },
    ['R']   = { display = 'REP', hl = 'MiniStatuslineModeReplace', sep = 'MiniStatuslineModeReplaceSep' },
    ['c']   = { display = 'CMD', hl = 'MiniStatuslineModeCommand', sep = 'MiniStatuslineModeCommandSep' },
    ['r']   = { display = 'PRO', hl = 'MiniStatuslineModeOther', sep = 'MiniStatuslineModeOtherSep' },
    ['!']   = { display = 'SHE', hl = 'MiniStatuslineModeOther', sep = 'MiniStatuslineModeOtherSep' },
    ['t']   = { display = 'TER', hl = 'MiniStatuslineModeOther', sep = 'MiniStatuslineModeOtherSep' },
}
local mode_map_unknown = { display = 'OTH', hl = 'MiniStatuslineModeOther', sep = 'MiniStatuslineModeOtherSep' }

-- Caches the complete mode string to spare `string.format` calls entirely
--- @type table<string, table<string, string>>
local mode_cache = { active = {}, inactive = {} }

-- Caches the diagnostic counts for a given buffer
--- @type table<integer, table>
local diagnostics_cache = {}

-- Tracks attached LSP clients for buffer IDs
-- Using Lsp* and BufferEnter events to update
--- @type table<integer, string>
local lsp_clients = {}

-- A map that can be used to change how LSP servers are displayed
-- LSP Servers can also be hidden by setting it to false
--- E.g. { ['tsserver'] = 'TS', ['pyright'] = 'Python', ['GitHub Copilot'] = false }
local map_lsps = {}

--- @param mode string
--- @param active boolean
--- @return string
local function mode_component(mode, active)
    local cache = active and mode_cache.active or mode_cache.inactive
    if cache[mode] then
        return cache[mode]
    end

    local current = mode_map[mode] or mode_map_unknown
    local hl = active and current.hl or 'MiniStatuslineModeInactive'
    local hl_sep = active and current.sep or 'MiniStatuslineModeInactiveSep'

    local result = string.format('%%#%s#%%#%s#%s%%#%s#%%* ', hl_sep, hl, current.display, hl_sep)
    cache[mode] = result
    return result
end

local track_lsp = vim.schedule_wrap(function(buf)
    if not vim.api.nvim_buf_is_valid(buf) then
        lsp_clients[buf] = nil
        return
    end
    local attached_clients = vim.lsp.get_clients({ bufnr = buf })

    local names = vim.iter(attached_clients)
        :filter(function(client) return map_lsps[client.name] ~= false end)
        :map(function(client)
            return map_lsps[client.name] or client.name:gsub('language.server', 'ls')
        end)
        :totable()
    if #names > 0 then
        lsp_clients[buf] = table.concat(names, ', ')
    else
        lsp_clients[buf] = nil
    end
end)

Config.new_autocmd({ 'LspAttach', 'LspDetach', 'BufEnter' }, '*', function(data)
    track_lsp(data.buf)
end, 'Track LSP Clients')

Config.new_autocmd('DiagnosticChanged', '*', function(data)
    diagnostics_cache[data.buf] = nil
end, 'Invalidate diagnostic cache')

Config.new_autocmd({ 'BufDelete', 'BufWipeout' }, '*', function(data)
    lsp_clients[data.buf] = nil
    diagnostics_cache[data.buf] = nil
end, 'Prune statusline caches')

for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
        track_lsp(buf)
    end
end

--- @param bufnr integer
--- @return  string
local function lsp_clients_component(bufnr)
    local clients = lsp_clients[bufnr]
    return clients and (clients .. separator) or ''
end

--- @param bufnr integer
--- @param mode string
--- @param active boolean
--- @return string
local function diagnostic_component(bufnr, mode, active)
    -- Cache is invalidated by DiagnosticChanged; insert mode preserves stale
    -- counts intentionally to avoid noise while typing.
    if mode ~= 'i' and not diagnostics_cache[bufnr] then
        diagnostics_cache[bufnr] = vim.diagnostic.count(bufnr)
    end
    local counts = diagnostics_cache[bufnr] or {}

    local parts = {}
    for severity, count in pairs(counts) do
        parts[#parts + 1] = string.format('%s%s:%s%s',
            active and diagnostic_hls[severity] or '',
            signs[severity],
            count,
            active and '%*' or '')
    end
    local result_str = table.concat(parts, ' ')

    return result_str .. (result_str ~= '' and separator or '')
end

--- @param filetype string
--- @param active boolean
--- @return string
local function filetype_component(filetype, active)
    if filetype == '' then
        return ''
    end
    local icon, hl = MiniIcons.get('filetype', filetype) --luacheck: ignore
    if active then
        return string.format('%%#%s#%s %s ', hl, icon, filetype)
    end
    return string.format('%s %s ', icon, filetype)
end

---@param active integer
_G.statusline = function(active)
    local bufnr = vim.api.nvim_get_current_buf()
    local is_active = active == 1
    local mode = vim.fn.mode()
    local busy = vim.o.busy
    return table.concat({
        mode_component(mode, is_active),
        '%t %H%W%M%R',
        '%=',
        (busy and busy > 0 and '◐ ') or '',
        diagnostic_component(bufnr, mode, is_active),
        lsp_clients_component(bufnr),
        filetype_component(vim.bo[bufnr].filetype, is_active),
    })
end

vim.go.statusline =
'%{%(nvim_get_current_win()==#g:actual_curwin || &laststatus==3) ? v:lua.statusline(1) : v:lua.statusline(0)%}'

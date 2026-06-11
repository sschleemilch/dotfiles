local diagnostic_hls = {
    [vim.diagnostic.severity.ERROR] = '%#DiagnosticError#',
    [vim.diagnostic.severity.WARN] = '%#DiagnosticWarn#',
    [vim.diagnostic.severity.INFO] = '%#DiagnosticInfo#',
    [vim.diagnostic.severity.HINT] = '%#DiagnosticHint#',
}

local user_signs = vim.tbl_get(vim.diagnostic.config() --[[@as vim.diagnostic.Opts]], 'signs', 'text') or {}
local signs = vim.tbl_extend('keep', user_signs, { 'E', 'W', 'I', 'H' })

vim.o.showmode = false

-- local separator = ' ▪ '
local separator = '  '

-- Note that: \19 = ^S and \22 = ^V.
local mode_map = {
    ['n'] = { display = 'NOR', hl = 'Type' },
    ['v'] = { display = 'VIS', hl = 'Define' },
    ['V'] = { display = 'V-L', hl = 'Define' },
    ['\22'] = { display = 'V-B', hl = 'Define' },
    ['s'] = { display = 'SEL', hl = 'Define' },
    ['S'] = { display = 'S-L', hl = 'Define' },
    ['\19'] = { display = 'S-B', hl = 'Define' },
    ['i'] = { display = 'INS', hl = 'Function' },
    ['R'] = { display = 'REP', hl = 'Statement' },
    ['c'] = { display = 'CMD', hl = 'String' },
    ['r'] = { display = 'PRO', hl = 'Error' },
    ['!'] = { display = 'SHE', hl = 'Error' },
    ['t'] = { display = 'TER', hl = 'Error' },
}
local mode_map_unknown = { display = 'OTH', hl = 'Error' }

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
    local hl = active and current.hl or ''

    local result = string.format('%%#%s#%s%%*', hl, current.display)
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
        :filter(function(client)
            return map_lsps[client.name] ~= false
        end)
        :map(function(client)
            return map_lsps[client.name] or client.name:gsub('language.server', 'ls')
        end)
        :join(', ')
    lsp_clients[buf] = names ~= '' and names or nil
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
    local prefix_hls = active and diagnostic_hls or {}
    local suffix = active and '%*' or ''
    for severity, count in pairs(counts) do
        parts[#parts + 1] = string.format('%s%s:%s%s', prefix_hls[severity] or '', signs[severity], count, suffix)
    end
    local result_str = table.concat(parts, ' ')

    return result_str
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
        return string.format('%%#%s#%s %s', hl, icon, filetype)
    end
    return string.format('%s %s', icon, filetype)
end

---@param active integer
_G.statusline = function(active)
    local bufnr = vim.api.nvim_get_current_buf()
    local is_active = active == 1
    local mode = vim.fn.mode()
    local busy = vim.o.busy

    local left = mode_component(mode, is_active) .. separator .. '%t%H%W%M%R'

    local right = vim.iter({
        (busy and busy > 0 and '◐') or '',
        diagnostic_component(bufnr, mode, is_active),
        lsp_clients[bufnr] or '',
        filetype_component(vim.bo[bufnr].filetype, is_active),
    })
        :filter(function(s)
            return s ~= ''
        end)
        :join(separator)

    return left .. '%=' .. right
end

vim.go.statusline =
    '%{%(nvim_get_current_win()==#g:actual_curwin || &laststatus==3) ? v:lua.statusline(1) : v:lua.statusline(0)%}'

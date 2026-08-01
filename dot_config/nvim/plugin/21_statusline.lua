local user_signs = vim.tbl_get(vim.diagnostic.config() --[[@as vim.diagnostic.Opts]], 'signs', 'text') or {}
local signs = vim.tbl_extend('keep', user_signs, { 'E', 'W', 'I', 'H' })

vim.o.showmode = false

-- local separator = ' ▪ '
local separator = ' '

local hl_normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
local hl_statusline = vim.api.nvim_get_hl(0, { name = 'StatusLine', link = false })
local hl_statusline_nc = vim.api.nvim_get_hl(0, { name = 'StatusLineNC', link = false })

--- @class hl
--- @field content string
--- @field sep string

---@type hl
local hl_content_active = { content = 'StatusLineActive', sep = 'StatusLineActiveSep' }
---@type hl
local hl_content_inactive = { content = 'StatusLineInactive', sep = 'StatusLineInactiveSep' }
vim.api.nvim_set_hl(0, hl_content_active.content, { fg = hl_normal.bg, bg = hl_statusline.fg })
vim.api.nvim_set_hl(0, hl_content_active.sep, { fg = hl_statusline.fg, bg = 'NONE' })
vim.api.nvim_set_hl(0, hl_content_inactive.content, { fg = hl_normal.bg, bg = hl_statusline_nc.fg })
vim.api.nvim_set_hl(0, hl_content_inactive.sep, { fg = hl_statusline_nc.fg, bg = 'NONE' })

--- @param name string
--- @return hl
local function create_diagnostic_hl(name)
    local h = 'StatusLine' .. name
    local h_sep = h .. 'Sep'

    local ref = vim.api.nvim_get_hl(0, { name = name, link = false })

    vim.api.nvim_set_hl(0, h, { bg = ref.fg, fg = hl_normal.bg })
    vim.api.nvim_set_hl(0, h_sep, { bg = 'NONE', fg = ref.fg })

    return { content = h, sep = h_sep }
end

local diagnostic_hls = {
    [vim.diagnostic.severity.ERROR] = create_diagnostic_hl('DiagnosticError'),
    [vim.diagnostic.severity.WARN] = create_diagnostic_hl('DiagnosticWarn'),
    [vim.diagnostic.severity.INFO] = create_diagnostic_hl('DiagnosticInfo'),
    [vim.diagnostic.severity.HINT] = create_diagnostic_hl('DiagnosticHint'),
}

--- @class mode_hls
--- @field normal hl
--- @field insert hl
--- @field command hl
--- @field replace hl
--- @field visual hl
--- @field other hl
--- @field inactive hl

--- @param name string
--- @return hl
local function create_mode_sep_hl(name)
    local sep_hl_name = name .. 'Sep'
    local h = vim.api.nvim_get_hl(0, { name = name, link = false })
    vim.api.nvim_set_hl(0, sep_hl_name, { fg = h.bg, bg = 'NONE' })
    return { content = name, sep = sep_hl_name }
end

---@param content string
---@param highlight hl
---@return string
local function render_component(content, highlight)
    return string.format('%%#%s#%%#%s#%s%%#%s#', highlight.sep, highlight.content, content, highlight.sep)
end

---@type mode_hls
local hls_mode = {
    normal = create_mode_sep_hl('MiniStatuslineModeNormal'),
    insert = create_mode_sep_hl('MiniStatuslineModeInsert'),
    command = create_mode_sep_hl('MiniStatuslineModeCommand'),
    replace = create_mode_sep_hl('MiniStatuslineModeReplace'),
    visual = create_mode_sep_hl('MiniStatuslineModeVisual'),
    other = create_mode_sep_hl('MiniStatuslineModeOther'),
    inactive = hl_content_inactive,
}

-- Note that: \19 = ^S and \22 = ^V.
local mode_map = {
    ['n'] = { display = 'NOR', hl = hls_mode.normal },
    ['v'] = { display = 'VIS', hl = hls_mode.visual },
    ['V'] = { display = 'V-L', hl = hls_mode.visual },
    ['\22'] = { display = 'V-B', hl = hls_mode.visual },
    ['s'] = { display = 'SEL', hl = hls_mode.visual },
    ['S'] = { display = 'S-L', hl = hls_mode.visual },
    ['\19'] = { display = 'S-B', hl = hls_mode.visual },
    ['i'] = { display = 'INS', hl = hls_mode.insert },
    ['R'] = { display = 'REP', hl = hls_mode.replace },
    ['c'] = { display = 'CMD', hl = hls_mode.command },
    ['r'] = { display = 'PRO', hl = hls_mode.other },
    ['!'] = { display = 'SHE', hl = hls_mode.other },
    ['t'] = { display = 'TER', hl = hls_mode.other },
}
local mode_map_unknown = { display = 'OTH', hl = hls_mode.other }

-- Caches the complete mode string to spare `string.format` calls entirely
--- @type table<string, table<string, string>>
local mode_component_cache = { active = {}, inactive = {} }

-- Caches the diagnostic counts for a given buffer
--- @type table<integer, table>
local diagnostics_cache = {}
local diagnostics_dirty = {}
local file_component_cache = {}

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
    local cache = active and mode_component_cache.active or mode_component_cache.inactive
    if cache[mode] then
        return cache[mode]
    end

    local current = mode_map[mode] or mode_map_unknown
    local result = render_component(current.display, active and current.hl or hls_mode.inactive)

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
    -- Keep the last known counts while editing, but refresh immediately for
    -- other buffers and modes.
    if data.buf == vim.api.nvim_get_current_buf() and vim.fn.mode() == 'i' then
        diagnostics_dirty[data.buf] = true
    else
        diagnostics_cache[data.buf] = nil
        diagnostics_dirty[data.buf] = nil
    end
end, 'Invalidate diagnostic cache')

Config.new_autocmd({ 'BufDelete', 'BufWipeout' }, '*', function(data)
    lsp_clients[data.buf] = nil
    diagnostics_cache[data.buf] = nil
    diagnostics_dirty[data.buf] = nil
    file_component_cache[data.buf] = nil
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
    if not diagnostics_cache[bufnr] or (mode ~= 'i' and diagnostics_dirty[bufnr]) then
        diagnostics_cache[bufnr] = vim.diagnostic.count(bufnr)
        diagnostics_dirty[bufnr] = nil
    end
    local counts = diagnostics_cache[bufnr] or {}

    local parts = {}
    for _, severity in ipairs({
        vim.diagnostic.severity.ERROR,
        vim.diagnostic.severity.WARN,
        vim.diagnostic.severity.INFO,
        vim.diagnostic.severity.HINT,
    }) do
        local count = counts[severity]
        if count then
            parts[#parts + 1] = render_component(
                string.format('%s:%s', signs[severity], count),
                active and diagnostic_hls[severity] or hl_content_inactive
            )
        end
    end

    local result_str = table.concat(parts, ' ')

    return result_str
end

local filetype_hls_cache = {}
local filetype_component_cache = {}

--- @param filetype string
--- @param active boolean
--- @return string
local function filetype_component(filetype, active)
    if filetype == '' then
        return ''
    end
    local cached = filetype_component_cache[filetype]
    if cached then
        return cached[active and 'active' or 'inactive']
    end

    local icon, hl_sep = MiniIcons.get('filetype', filetype)
    local hl = hl_sep .. 'Content'
    if filetype_hls_cache[hl] == nil then
        local h = vim.api.nvim_get_hl(0, { name = hl_sep, link = false })
        vim.api.nvim_set_hl(0, hl, { fg = hl_normal.bg, bg = h.fg })
        filetype_hls_cache[hl] = hl
    end

    cached = {
        active = render_component(icon .. ' ' .. filetype, { content = hl, sep = hl_sep }),
        inactive = render_component(icon .. ' ' .. filetype, hl_content_inactive),
    }

    filetype_component_cache[filetype] = cached
    return cached[active and 'active' or 'inactive']
end

---@param bufnr integer
---@param active boolean
local function file_component(bufnr, active)
    if vim.bo[bufnr].buftype ~= '' then
        return ''
    end

    local modified = vim.bo[bufnr].modified
    local readonly = vim.bo[bufnr].readonly
    local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':t')

    if file == '' then
        return ''
    end

    local cached = file_component_cache[bufnr]
    if cached and cached.file == file and cached.modified == modified and cached.readonly == readonly then
        return cached[active and 'active' or 'inactive']
    end

    if modified then
        file = file .. '+'
    end
    if readonly then
        file = file .. '!'
    end

    cached = {
        file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':t'),
        modified = modified,
        readonly = readonly,
        active = render_component(file, hl_content_active),
        inactive = render_component(file, hl_content_inactive),
    }
    file_component_cache[bufnr] = cached
    return cached[active and 'active' or 'inactive']
end

---@param buf integer
---@param active boolean
local function lsp_component(buf, active)
    local clients = lsp_clients[buf] or ''
    if clients == '' then
        return ''
    end
    return render_component(clients, active and hl_content_active or hl_content_inactive)
end

---@param active integer
_G.statusline = function(active)
    local winid = tonumber(vim.g.statusline_winid) or vim.api.nvim_get_current_win()
    if not vim.api.nvim_win_is_valid(winid) then
        winid = vim.api.nvim_get_current_win()
    end
    local bufnr = vim.api.nvim_win_get_buf(winid)
    local is_active = active == 1
    local mode = vim.fn.mode()
    local busy = vim.o.busy

    local left = mode_component(mode, is_active) .. separator .. file_component(bufnr, is_active)

    local right = vim.iter({
        (busy and busy > 0 and '◐') or '',
        diagnostic_component(bufnr, mode, is_active),
        lsp_component(bufnr, is_active),
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

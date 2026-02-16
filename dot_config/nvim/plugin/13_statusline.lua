local hl_normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
local hl_comment = vim.api.nvim_get_hl(0, { name = 'Comment', link = false })
local hl_mode_inactive = 'StatuslineModeInactive'
vim.api.nvim_set_hl(0, hl_mode_inactive, { bg = hl_comment.fg, fg = hl_normal.bg })

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

-- Caches the complete mode string to spare `string.format` calls entirely
--- @type table<string, string>
local mode_cache = {}

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
    local cache_key = mode .. (active and '+' or '')
    if mode_cache[cache_key] then
        return mode_cache[cache_key]
    end

    -- Note that: \19 = ^S and \22 = ^V.
    local map = {
        ['n'] = { display = 'NOR', hl = 'MiniStatuslineModeNormal' },
        ['v'] = { display = 'VIS', hl = 'MiniStatuslineModeVisual' },
        ['V'] = { display = 'V-L', hl = 'MiniStatuslineModeVisual' },
        ['\22'] = { display = 'V-B', hl = 'MiniStatuslineModeVisual' },
        ['s'] = { display = 'SEL', hl = 'MiniStatuslineModeVisual' },
        ['S'] = { display = 'S-L', hl = 'MiniStatuslineModeVisual' },
        ['\19'] = { display = 'S-B', hl = 'MiniStatuslineModeVisual' },
        ['i'] = { display = 'INS', hl = 'MiniStatuslineModeInsert' },
        ['R'] = { display = 'REP', hl = 'MiniStatuslineModeReplace' },
        ['c'] = { display = 'CMD', hl = 'MiniStatuslineModeCommand' },
        ['r'] = { display = 'PRO', hl = 'MiniStatuslineModeCommand' },
        ['!'] = { display = 'SHE', hl = 'MiniStatuslineModeCommand' },
        ['t'] = { display = 'TER', hl = 'MiniStatuslineModeCommand' },
    }
    local current = map[mode] or { display = 'OTH', hl = 'MiniStatuslineModeOther' }
    local hl = active and current.hl or hl_mode_inactive

    local result = string.format('%%#%s# %s %%* ', hl, current.display)
    mode_cache[cache_key] = result
    return result
end

local track_lsp = vim.schedule_wrap(function(buf)
    if not vim.api.nvim_buf_is_valid(buf) then
        lsp_clients[buf] = nil
        return
    end
    local attached_clients = vim.lsp.get_clients({ bufnr = buf })

    local it = vim.iter(attached_clients)
    it:map(function(client)
        if map_lsps[client.name] == false then
            return nil
        end
        local name = map_lsps[client.name] or client.name:gsub('language.server', 'ls')
        return name
    end)
    local names = it:totable()
    if #names > 0 then
        lsp_clients[buf] = string.format('%s', table.concat(names, ','))
    else
        lsp_clients[buf] = nil
    end
end)

Config.new_autocmd({ 'LspAttach', 'LspDetach', 'BufEnter' }, '*', function(data)
    track_lsp(data.buf)
end, 'Track LSP Clients')

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
    local counts
    if mode == 'i' then
        counts = diagnostics_cache[bufnr] or {}
    else
        counts = vim.diagnostic.count(bufnr)
    end

    diagnostics_cache[bufnr] = counts

    local result_str = vim.iter(pairs(counts))
        :map(function(severity, count)
            return ('%s%s:%s%s'):format(
                active and diagnostic_hls[severity] or '',
                signs[severity],
                count,
                active and '%*' or ''
            )
        end)
        :join(' ')

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
    filetype = icon .. ' ' .. filetype
    if active then
        filetype = '%#' .. hl .. '#' .. filetype
    end
    return filetype .. ' '
end

---@param active integer
_G.statusline = function(active)
    local bufnr = vim.api.nvim_get_current_buf()
    local is_active = active == 1
    local mode = vim.fn.mode()
    return table.concat({
        mode_component(mode, is_active),
        '%t %H%W%M%R',
        '%=',
        (vim.o.busy and vim.o.busy > 0 and '◐ ') or '',
        diagnostic_component(bufnr, mode, is_active),
        lsp_clients_component(bufnr),
        filetype_component(vim.bo.filetype, is_active),
    })
end

vim.go.statusline =
    '%{%(nvim_get_current_win()==#g:actual_curwin || &laststatus==3) ? v:lua.statusline(1) : v:lua.statusline(0)%}'

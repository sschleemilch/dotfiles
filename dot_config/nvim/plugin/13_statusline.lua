local hl_normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
local hl_comment = vim.api.nvim_get_hl(0, { name = 'Comment', link = false })
local hl_mode_inactive = 'StatuslineModeInactive'
vim.api.nvim_set_hl(0, hl_mode_inactive, { bg = hl_comment.fg, fg = hl_normal.bg })

vim.o.showmode = false

local separator = ' ▪ '

-- Caches the complete mode string to spare `string.format` calls entirely
local mode_cache = {}

-- Tracks attached LSP clients for buffer IDs
-- Using Lsp* and BufferEnter events to update
--- @type table<integer, string>
local lsp_clients = {}

-- A map that can be used to change how LSP servers are displayed
-- LSP Servers can also be hidden by setting it to false
--- E.g. { ['tsserver'] = 'TS', ['pyright'] = 'Python', ['GitHub Copilot'] = false }
local map_lsps = {}

---@param active boolean
---@return string
local function mode_component(active)
    local mode = vim.fn.mode()

    local cache_key = mode .. (active and '+' or '-')
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

local track_lsp = vim.schedule_wrap(function(data)
    if not vim.api.nvim_buf_is_valid(data.buf) then
        lsp_clients[data.buf] = nil
        return
    end
    local attached_clients = vim.lsp.get_clients({ bufnr = data.buf })

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
        lsp_clients[data.buf] = string.format('%s', table.concat(names, ','))
    else
        lsp_clients[data.buf] = nil
    end
end)

vim.api.nvim_create_autocmd(
    { 'LspAttach', 'LspDetach', 'BufEnter' },
    { group = augroup('track_lsp'), pattern = '*', callback = track_lsp, desc = 'Track LSP Clients' }
)

--- @return  string
local function lsp_clients_component()
    local clients = lsp_clients[vim.api.nvim_get_current_buf()]
    return clients and (clients .. separator) or ''
end

--- @return string
local function diagnostic_component()
    local status = (pcall(require, 'vim.diagnostic') and vim.diagnostic.status()) or ''
    return status ~= '' and (status .. separator) or ''
end

---@param active integer
_G.statusline = function(active)
    return table.concat({
        mode_component(active == 1),
        '%t %H%W%M%R',
        '%=',
        (vim.o.busy and vim.o.busy > 0 and '◐ ') or '',
        diagnostic_component(),
        lsp_clients_component(),
        '%(%Y %)',
    })
end

vim.go.statusline =
    '%{%(nvim_get_current_win()==#g:actual_curwin || &laststatus==3) ? v:lua.statusline(1) : v:lua.statusline(0)%}'

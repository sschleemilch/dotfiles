local hls = {
    inactive = 'StlInactive',
    ref = {
        normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false }),
        comment = vim.api.nvim_get_hl(0, { name = 'Comment', link = false }),
    },
}
vim.api.nvim_set_hl(0, hls.inactive, { bg = hls.ref.comment.fg, fg = hls.ref.normal.bg })

vim.o.showmode = false

---@param active boolean
---@return string
local function mode_component(active)
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
    local current = map[vim.fn.mode()] or { display = 'OTH', hl = 'MiniStatuslineModeOther' }
    local hl = active and current.hl or hls.inactive

    return string.format('%%#%s# %s ', hl, current.display)
end

---@param active integer
_G.statusline = function(active)
    local is_active = active == 1

    return table.concat({
        mode_component(is_active),
        is_active and '%#StatusLine#' or '%#StatusLineNC#',
        ' %t %H%W%M%R',
        '%=',
        "%{% &busy > 0 ? '◐ ' : '' %}",
        "%(%{luaeval('(pcall(require, ''vim.diagnostic'') and vim.diagnostic.status()) or '''' ')} %)",
        '%(%Y %)',
        '%(%{&fileencoding} %)',
        '%(%{&fileformat} %)',
        '%7.(%c%V%) ',
    })
end

vim.go.statusline =
    '%{%(nvim_get_current_win()==#g:actual_curwin || &laststatus==3) ? v:lua.statusline(1) : v:lua.statusline(0)%}'

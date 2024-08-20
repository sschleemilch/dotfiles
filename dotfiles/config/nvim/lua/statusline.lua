-- Don"t show the command that produced the quickfix list.
vim.g.qf_disable_statusline = 1

-- Show the mode in my custom component instead.
vim.o.showmode = false

local icons = require("icons")

local augroup = vim.api.nvim_create_augroup("zenline", { clear = true })

local M = {}

local config = {
  bold = false,
  verbose_mode = false,
  hl = {
    normal = {
      name = "ZenlineNormal",
      base = "Normal"
    },
    passive = {
      name = "ZenlinePassive",
      base = "Comment"
    }
  },
  zen = true,
  sep = {
    mode = {
      left = nil,
      right = icons.separators.triangle_lower_left
    },
    progress = {
      left = icons.separators.triangle_lower_right,
      right = nil
    }
  }
}


---@type table<string, boolean>
M.hls = {}
---@param hl string
---@param base string?
---@param reverse boolean?
---@param bold boolean?
function M.get_or_create_hl(hl, base, reverse, bold)
  if not M.hls[hl] then
    local hl_ref = vim.api.nvim_get_hl(0, { name = base })
    local fg = hl_ref.fg or "fg"
    local bg = hl_ref.bg or "bg"
    if reverse then
      local tmp = fg
      fg = bg
      bg = tmp
    end
    vim.api.nvim_set_hl(0, hl, { bg = bg, fg = fg, bold = hl_ref.bold or bold })
    M.hls[hl] = true
  end

  return hl
end

---@param mode string
---@return boolean
local function is_normal_mode(mode)
  return mode == "NORMAL"
end

--- Function to get the highlight of a given mode
--- @param mode string
--- @return string
function M.get_mode_hl(mode)
  local hl = config.hl.passive
  if mode == "NORMAL" then
    hl = config.hl.normal
    -- elseif mode:find "PENDING" then
    --   postfix = "Pending"
    -- elseif mode:find "VISUAL" then
    --   postfix = "Visual"
    -- elseif mode:find "INSERT" or mode:find "SELECT" then
    --   postfix = "Insert"
    -- elseif mode:find "COMMAND" or mode:find "TERMINAL" or mode:find "EX" then
    --   postfix = "Command"
  end
  return M.get_or_create_hl(hl.name .. "Mode", hl.base, true, config.bold)
end

--- Helper function to highlight a given content
--- Resets the highlight afterwards
--- @param content string
--- @param hl string?
--- @param sep_left string?
--- @param sep_right string?
--- @return string
function M.highlight_content(content, hl, sep_left, sep_right)
  local rendered = ""
  if sep_left ~= nil then
    rendered = rendered .. string.format("%%#%s#%s", M.get_or_create_hl(hl .. "Sep", hl, true), sep_left)
  end
  rendered = rendered .. string.format("%%#%s#%s", hl, content)
  if sep_right ~= nil then
    rendered = rendered .. string.format("%%#%s#%s", M.get_or_create_hl(hl .. "Sep", hl, true), sep_right)
  end
  rendered = rendered .. "%#" .. M.get_or_create_hl(config.hl.normal.name, config.hl.normal.base) .. "#"
  return rendered
end

--- Function to translate a mode into a string to show
--- @return string
function M.get_mode()
  -- Note that: \19 = ^S and \22 = ^V.
  local mode_map = {
    ["n"] = "NORMAL",
    ["no"] = "OP-PENDING",
    ["nov"] = "OP-PENDING",
    ["noV"] = "OP-PENDING",
    ["no\22"] = "OP-PENDING",
    ["niI"] = "NORMAL",
    ["niR"] = "NORMAL",
    ["niV"] = "NORMAL",
    ["nt"] = "NORMAL",
    ["ntT"] = "NORMAL",
    ["v"] = "VISUAL",
    ["vs"] = "VISUAL",
    ["V"] = "VISUAL",
    ["Vs"] = "VISUAL",
    ["\22"] = "VISUAL",
    ["\22s"] = "VISUAL",
    ["s"] = "SELECT",
    ["S"] = "SELECT",
    ["\19"] = "SELECT",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["ix"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rc"] = "REPLACE",
    ["Rx"] = "REPLACE",
    ["Rv"] = "VIRT REPLACE",
    ["Rvc"] = "VIRT REPLACE",
    ["Rvx"] = "VIRT REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MORE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
  }

  local mode = mode_map[vim.api.nvim_get_mode().mode] or "UNKNOWN"
  return mode
end

--- Mode component
--- @param mode string
--- @return string
function M.mode_component(mode)
  local render = mode
  if config.verbose_mode == false then
    render = string.sub(mode, 1, 1)
  end
  local content = " " .. render .. " "
  return M.highlight_content(content, M.get_mode_hl(mode), config.sep.mode.left, config.sep.mode.right)
end

--- Git component showing branch
--- as well as changed, added and removed lines
--- Using gitsigns for it
--- @param mode string
--- @return string
function M.git_component(mode)
  local status = vim.b.gitsigns_status_dict
  if not status then
    return ""
  end
  if not status.head or status.head == "" then
    return ""
  end

  local render = string.format("%s %s", icons.git.branch, status.head)


  if status.added and status.added > 0 then
    local added_hl = "DiagnosticInfo"
    if config.zen and not is_normal_mode(mode) then
      added_hl = M.get_or_create_hl(config.hl.passive.name, config.hl.passive.base)
    end
    render = render .. M.highlight_content(string.format(" %s%s", icons.git.added, status.added), added_hl)
  end
  if status.removed and status.removed > 0 then
    local removed_hl = "DiagnosticError"
    if config.zen and not is_normal_mode(mode) then
      removed_hl = M.get_or_create_hl(config.hl.passive.name, config.hl.passive.base)
    end
    render = render .. M.highlight_content(string.format(" %s%s", icons.git.removed, status.removed), removed_hl)
  end
  if status.changed and status.changed > 0 then
    local changed_hl = "DiagnosticWarn"
    if config.zen and not is_normal_mode(mode) then
      changed_hl = M.get_or_create_hl(config.hl.passive.name, config.hl.passive.base)
    end
    render = render ..
        M.highlight_content(string.format(" %s%s", icons.git.modified, status.changed), changed_hl)
  end
  local render_hl = M.get_or_create_hl(config.hl.normal.name, config.hl.normal.base)
  if config.zen and not is_normal_mode(mode) then
    render_hl = M.get_or_create_hl(config.hl.passive.name, config.hl.passive.base)
  end
  return M.highlight_content(render, render_hl)
end

--- File path component
--- Highlights the filename in the mode color
--- @param mode string
--- @return string
function M.file_component(mode)
  local path = vim.fs.normalize(vim.fn.expand("%:.:h"))
  if #path == 0 then
    return ""
  end
  path = path .. "/"
  local filename = vim.fn.expand("%:t")
  local content = M.highlight_content(path, M.get_or_create_hl(config.hl.passive.name, config.hl.passive.base))
  local file_hl = config.hl.normal
  if config.zen and not is_normal_mode(mode) then
    file_hl = config.hl.passive
  end
  content = content ..
      M.highlight_content(filename, M.get_or_create_hl(file_hl.name .. "Filename", file_hl.base, false, config.bold))
  local mod_hl = M.get_or_create_hl(config.hl.normal.name, config.hl.normal.base)
  if config.zen and not is_normal_mode(mode) then
    mod_hl = M.get_or_create_hl(config.hl.passive.name, config.hl.passive.base)
  end
  content = content .. " " .. M.highlight_content("%m%r", mod_hl)
  return content
end

local last_diagnostic_component = ""
--- Diagnostics component
--- @param mode string
--- @return string
function M.diagnostics_component(mode)
  -- Lazy uses diagnostic icons, but those aren"t errors per se.
  if vim.bo.filetype == "lazy" then
    return ""
  end

  local hl_inactive = M.get_or_create_hl(config.hl.passive.name, config.hl.passive.base)

  -- Use the last computed value if in insert mode.
  if vim.startswith(vim.api.nvim_get_mode().mode, "i") then
    local result = last_diagnostic_component
    if config.zen then
      result = string.gsub(result, "#Diagnostic.[a-zA-Z]+#", string.format("#%s#", config.hl.passive.name))
    end
    return result
  end

  local counts = vim.iter(vim.diagnostic.get(0)):fold({
    ERROR = 0,
    WARN = 0,
    HINT = 0,
    INFO = 0,
  }, function(acc, diagnostic)
    local severity = vim.diagnostic.severity[diagnostic.severity]
    acc[severity] = acc[severity] + 1
    return acc
  end)

  local parts = vim.iter(counts)
      :map(function(severity, count)
        if count == 0 then
          return nil
        end

        local hl = "Diagnostic" .. severity:sub(1, 1) .. severity:sub(2):lower()
        if config.zen and not is_normal_mode(mode) then
          hl = hl_inactive
        end
        return string.format("%%#%s#%s%d", hl, icons.diagnostics[severity], count)
      end)
      :totable()

  last_diagnostic_component = table.concat(parts, " ")
  return last_diagnostic_component
end

--- Filetype component
--- Uses mini.icons for icons
--- @param mode string
--- @return string
function M.filetype_component(mode)
  local MiniIcons = require("mini.icons")

  local filetype = vim.bo.filetype
  if filetype == "" then
    filetype = "[No Name]"
  end
  local icon, icon_hl = MiniIcons.get("filetype", filetype)
  local filetype_hl = "Normal"
  if config.zen and not is_normal_mode(mode) then
    icon_hl = M.get_or_create_hl(config.hl.passive.name, config.hl.passive.base)
    filetype_hl = M.get_or_create_hl(config.hl.passive.name, config.hl.passive.base)
  end

  return string.format("%%#%s#%s %%#%s#%s", icon_hl, icon, filetype_hl, filetype)
end

--- File progress component
--- @return string
function M.progress_component(mode)
  local cur = vim.fn.line(".")
  local total = vim.fn.line("$")
  local content = ""
  if cur == 1 then
    content = "Top"
  elseif cur == total then
    content = "Bot"
  else
    content = string.format("%2d%%%%", math.floor(cur / total * 100))
  end
  content = string.format(" %s / %s ", content, total)
  return M.highlight_content(content, M.get_mode_hl(mode), config.sep.progress.left, config.sep.progress.right)
end

--- Lsp component
--- Shows attached lsp clients
--- @return string
function M.lsp_component()
  local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
  if #attached_clients == 0 then
    return ""
  end
  local it = vim.iter(attached_clients)
  it:map(function(client)
    local name = client.name:gsub("language.server", "ls")
    return name
  end)
  local names = it:totable()
  local content = string.format("{%s}", table.concat(names, ","))
  return M.highlight_content(content, M.get_or_create_hl(config.hl.passive.name, config.hl.passive.base))
end

--- Renders the statusline.
---@return string
function M.render()
  local mode = M.get_mode()

  local stl = table.concat {
    M.mode_component(mode),
    " ",
    M.file_component(mode),
    "  ",
    M.git_component(mode),
    "%=",
    M.diagnostics_component(mode),
    "  ",
    M.filetype_component(mode),
    " ",
    M.lsp_component(),
    "  ",
    M.progress_component(mode),
  }
  return stl
end

--- Refreshes the line
--- To be called e.g. from autocommands
function M.refresh()
  vim.cmd.redrawstatus()
end

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
    require("statusline").hls = {}
  end,
})


vim.o.statusline = "%!v:lua.require'statusline'.render()"

return M

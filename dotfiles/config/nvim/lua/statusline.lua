-- Don"t show the command that produced the quickfix list.
vim.g.qf_disable_statusline = 1

-- Show the mode in my custom component instead.
vim.o.showmode = false

local icons = require("icons")

local augroup = vim.api.nvim_create_augroup("zenline", { clear = true })

local M = {}

local config = {
  bold = false,
  verbose_mode = true,
  sep = {
    left = icons.separators.circle_left,
    right = icons.separators.circle_right
  },
  hl = {
    modes = {
      normal = {
        name = "Normal",
        base = "Type",
      },
      insert = {
        name = "Insert",
        base = "Function"
      },
      pending = {
        name = "Pending",
        base = "Boolean"
      },
      visual = {
        name = "Visual",
        base = "Keyword"
      },
      command = {
        name = "Command",
        base = "String"
      },
    },
    base = "Normal",
    primary = {
      name = "Primary",
      base = "Normal"
    },
    secondary = {
      name = "Secondary",
      base = "Comment"
    }
  },
}

M.hls = {
  base = nil,
  primary = {
    text = nil,
    sep = nil,
    sep_transition = nil
  },
  secondary = {
    text = nil,
    sep = nil
  }
}

function M.create_hls()
    M.hls.base = M.get_or_create_hl("", config.hl.base)

    M.hls.primary.text = M.get_or_create_hl(config.hl.primary.name, config.hl.primary.base, true, config.bold)
    M.hls.primary.sep = M.get_or_create_hl(config.hl.primary.name .. "Sep", config.hl.primary.base)
    M.hls.primary.sep_transition = M.get_or_create_hl(config.hl.primary.name .. "SepTransition", config.hl.primary.base, false, false, config.hl.secondary.base)

    M.hls.secondary.text = M.get_or_create_hl(config.hl.secondary.name, config.hl.secondary.base, true, false)
end

---@type table<string, boolean>
M.hl_cache = {}
---@param hl string
---@param base string?
---@param bg_from string?
---@param reverse boolean?
---@param bold boolean?
function M.get_or_create_hl(hl, base, reverse, bold, bg_from)
  local basename = "Zenline"
  if hl:sub(1, #basename) ~= basename then
    hl = basename .. hl
  end

  if not M.hl_cache[hl] then
    local hl_ref = vim.api.nvim_get_hl(0, { name = base })
    local hl_bg_ref = vim.api.nvim_get_hl(0, { name = bg_from })
    local fg = hl_ref.fg or "fg"
    local bg = hl_bg_ref.fg or hl_ref.bg or "bg"
    if reverse then
      local tmp = fg
      fg = bg
      bg = tmp
    end
    vim.api.nvim_set_hl(0, hl, { bg = bg, fg = fg, bold = hl_ref.bold or bold })
    M.hl_cache[hl] = true
  end
  return hl
end

--- Function to get the highlight of a given mode
--- @param mode string
--- @return string
function M.get_mode_hl(mode)
  local hl = config.hl.secondary
  if mode == "NORMAL" then
    hl = config.hl.modes.normal
  elseif mode:find "PENDING" then
    hl = config.hl.modes.pending or hl
  elseif mode:find "VISUAL" then
    hl = config.hl.modes.visual or hl
  elseif mode:find "INSERT" or mode:find "SELECT" then
    hl = config.hl.modes.insert or hl
  elseif mode:find "COMMAND" or mode:find "TERMINAL" or mode:find "EX" then
    hl = config.hl.modes.command or hl
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
  if content == nil then
    return ""
  end
  local rendered = ""
  if sep_left ~= nil then
    rendered = rendered .. string.format("%%#%s#%s", M.get_or_create_hl(hl .. "Sep", hl, true), sep_left)
  end
  rendered = rendered .. string.format("%%#%s#%s", hl, content)
  if sep_right ~= nil then
    rendered = rendered .. string.format("%%#%s#%s", M.get_or_create_hl(hl .. "Sep", hl, true), sep_right)
  end
  rendered = rendered .. "%#" .. M.hls.base .. "#"
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
  return M.highlight_content(content, M.get_mode_hl(mode), config.sep.left, config.sep.right)
end

--- Git component showing branch
--- as well as changed, added and removed lines
--- Using gitsigns for it
--- @return string
function M.git_component()
  local status = vim.b.gitsigns_status_dict
  if not status then
    return ""
  end
  if not status.head or status.head == "" then
    return ""
  end

  local added = status.added and status.added > 0
  local removed = status.removed and status.removed > 0
  local changed = status.changed and status.changed > 0
  local modifications = added or removed or changed


  local branch = string.format("%s %s", icons.git.branch, status.head)
  branch = M.highlight_content(branch, M.hls.primary.text, config.sep.left)
  local branch_hl_right_sep = M.hls.primary.sep
  if modifications then
    branch_hl_right_sep = M.hls.primary.sep_transition
  end
  branch = branch .. M.highlight_content(config.sep.right, branch_hl_right_sep)

  local mods = ""
  if modifications then
    if added then
      mods = mods .. string.format(" %s%s", icons.git.added, status.added)
    end
    if changed then
      mods = mods .. string.format(" %s%s", icons.git.modified, status.changed)
    end
    if removed then
      mods = mods .. string.format(" %s%s", icons.git.removed, status.removed)
    end
    mods = M.highlight_content(mods, M.hls.secondary.text, nil, config.sep.right)
  end
  return branch .. mods
end

--- File path component
--- Highlights the filename in the mode color
--- @return string
function M.file_component()
  local file = M.highlight_content(" " .. vim.fn.expand("%:t") .. " %m%r", M.hls.primary.text, config.sep.left)
  file = file .. M.highlight_content(config.sep.right, M.hls.primary.sep_transition)

  local path = vim.fs.normalize(vim.fn.expand("%:.:h"))
  if #path == 0 then
    return ""
  end
  path = M.highlight_content(" " .. path, M.hls.secondary.text, nil, config.sep.right)

  return file .. path
end

local last_diagnostic_component = ""
--- Diagnostics component
--- @return string
function M.diagnostics_component()
  -- Lazy uses diagnostic icons, but those aren"t errors per se.
  if vim.bo.filetype == "lazy" then
    return ""
  end

  -- Use the last computed value if in insert mode.
  if vim.startswith(vim.api.nvim_get_mode().mode, "i") then
    return last_diagnostic_component
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

        return string.format("%s%d", icons.diagnostics[severity], count)
      end)
      :totable()

  last_diagnostic_component = table.concat(parts, " ")
  if last_diagnostic_component == "" then
    return ""
  end
  last_diagnostic_component = M.highlight_content(" " .. last_diagnostic_component .. " ",
    M.hls.primary.text, config.sep.left, config.sep.right)
  return last_diagnostic_component
end

--- Filetype and attached LSPs component
function M.filetype_lsp_component()
  local filetype = vim.bo.filetype
  if filetype == "" then
    filetype = "[No Name]"
  end
  local MiniIcons = require("mini.icons")
  local icon = MiniIcons.get("filetype", filetype)
  filetype = M.highlight_content(" " .. icon .. " " .. filetype .. " ", M.hls.primary.text, nil, config.sep.right)

  local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
  local it = vim.iter(attached_clients)
  it:map(function(client)
    local name = client.name:gsub("language.server", "ls")
    return name
  end)
  local names = it:totable()
  local lsp_clients = string.format("%s", table.concat(names, ","))

  local filetype_hl_sep_left = M.hls.primary.sep
  if #attached_clients > 0 then
    filetype_hl_sep_left = M.hls.primary.sep_transition
  end
  filetype = M.highlight_content(config.sep.left, filetype_hl_sep_left) .. filetype
  lsp_clients = M.highlight_content(" " .. lsp_clients .. " ", M.hls.secondary.text, config.sep.left)

  local result = filetype
  if #attached_clients > 0 then
    result = lsp_clients .. result
  end
  return result
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
  return M.highlight_content(content, M.get_mode_hl(mode), config.sep.left, config.sep.right)
end

--- Renders the statusline.
---@return string
function M.render()
  M.create_hls()
  local mode = M.get_mode()
  local stl = table.concat {
    M.mode_component(mode),
    " ",
    M.file_component(),
    " ",
    M.git_component(),
    "%=",
    M.diagnostics_component(),
    " ",
    M.filetype_lsp_component(),
    " ",
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
    require("statusline").hl_cache = {}
  end,
})


vim.o.statusline = "%!v:lua.require'statusline'.render()"

return M

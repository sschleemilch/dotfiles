local icons = require("icons")

local augroup = vim.api.nvim_create_augroup("sschlatusline", { clear = true })

local M = {}


-- Don"t show the command that produced the quickfix list.
vim.g.qf_disable_statusline = 1

-- Show the mode in my custom component instead.
vim.o.showmode = false


local hl_base = "Schlatusline"

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
    vim.api.nvim_set_hl(0, hl, { bg = bg, fg = fg, bold = hl_ref.bold or bold})
    M.hls[hl] = true
  end

  return hl
end


--- Function to get the highlight of a given mode
--- @param mode string
--- @param add string?
--- @return string
function M.get_mode_hl(mode, add)
  -- Build the hl group name
  local postfix = "Other"
  local base = "Normal"
  if mode == "NORMAL" then
    postfix = "Normal"
    base = "Comment"
  elseif mode:find "PENDING" then
    postfix = "Pending"
  elseif mode:find "VISUAL" then
    postfix = "Visual"
  elseif mode:find "INSERT" or mode:find "SELECT" then
    postfix = "Insert"
  elseif mode:find "COMMAND" or mode:find "TERMINAL" or mode:find "EX" then
    postfix = "Command"
  end
  local hl = hl_base .. "Mode" .. postfix
  if add then
    hl = hl .. add
  end
  return M.get_or_create_hl(hl, base, true, true)
end

--- Helper function to highlight a given content
--- Resets the highlight afterwards
--- @param content string
--- @param hl string?
--- @param sep_left string?
--- @param sep_right string?
--- @return string
function M.highlight_content(content, hl, sep_left, sep_right)
  if hl == nil then
    hl = hl_base
  end
  local rendered = ""
  if sep_left ~= nil then
    rendered = rendered .. string.format("%%#%s#%s", M.get_or_create_hl(hl .. "Sep", hl, true), sep_left)
  end
  rendered = rendered .. string.format("%%#%s#%s", hl, content)
  if sep_right ~= nil then
    rendered = rendered .. string.format("%%#%s#%s", M.get_or_create_hl(hl .. "Sep", hl, true), sep_right)
  end
  rendered = rendered .. "%#" .. hl_base .. "#"
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
  local content = " " .. mode .. " "
  return M.highlight_content(content, M.get_mode_hl(mode), nil, icons.separators.triangle_lower_left)
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

  local render = string.format("%s %s", icons.git.branch, status.head)
  if status.added and status.added > 0 then
    render = render .. M.highlight_content(string.format(" %s%s", icons.git.added, status.added), "DiagnosticInfo")
  end
  if status.removed and status.removed > 0 then
    render = render .. M.highlight_content(string.format(" %s%s", icons.git.removed, status.removed), "DiagnosticError")
  end
  if status.changed and status.changed > 0 then
    render = render ..
        M.highlight_content(string.format(" %s%s", icons.git.modified, status.changed), "DiagnosticWarn")
  end
  return M.highlight_content(render)
end

--- File path component
--- Highlights the filename in the mode color
--- @return string
function M.file_component(mode)
  local path = vim.fs.normalize(vim.fn.expand("%:.:h"))
  if #path == 0 then
    return ""
  end
  path = path .. "/"
  local filename = vim.fn.expand("%:t")
  local content = M.highlight_content(path, hl_base)
  local mode_hl = M.get_mode_hl(mode)
  content = content .. M.highlight_content(filename, M.get_or_create_hl(mode_hl .. "Filename", mode_hl, true))
  content = content .. " " .. M.highlight_content("%m%r", hl_base)
  return content
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

        local hl = "Diagnostic" .. severity:sub(1, 1) .. severity:sub(2):lower()
        return string.format("%%#%s#%s%d", hl, icons.diagnostics[severity], count)
      end)
      :totable()

  last_diagnostic_component = table.concat(parts, " ")
  return last_diagnostic_component
end

--- Filetype component
--- Uses mini.icons for icons
--- @return string
function M.filetype_component()
  local MiniIcons = require("mini.icons")

  local filetype = vim.bo.filetype
  if filetype == "" then
    filetype = "[No Name]"
  end
  local icon, icon_hl = MiniIcons.get("filetype", filetype)

  return string.format("%%#%s#%s %%#%s#%s", icon_hl, icon, M.get_or_create_hl(hl_base, hl_base), filetype)
end

--- File position component
---@return string
function M.position_component(mode)
  local content = "%4l:%-3c"
  return M.highlight_content(content, M.get_mode_hl(mode), icons.separators.triangle_lower_right)
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
  content = string.format(" %s / %s ",content, total)
  return M.highlight_content(content, M.get_mode_hl(mode), icons.separators.triangle_lower_right)
end



---@type table<string, string?>
local lsp_progress = {
  client = nil,
  kind = nil,
  title = nil,
  percentage = nil,
  message = nil,
}

--- Autocommand to fill the progress_status
vim.api.nvim_create_autocmd("LspProgress", {
  group = augroup,
  desc = "Update LSP progress in statusline",
  pattern = { "begin", "report", "end" },
  callback = function(args)
    -- This should in theory never happen, but I've seen weird errors.
    if not args.data then
      return
    end

    lsp_progress = {
      client = vim.lsp.get_client_by_id(args.data.client_id).name,
      kind = args.data.params.value.kind,
      message = args.data.params.value.message,
      percentage = args.data.params.value.percentage,
      title = args.data.params.value.title,
    }

    if lsp_progress.kind == "end" then
      lsp_progress.title = nil
      -- Wait a bit before clearing the status.
      vim.defer_fn(function()
        vim.cmd.redrawstatus()
      end, 3000)
    else
      vim.cmd.redrawstatus()
    end
  end,
})

--- Attached lsp component
--- Is included in lsp_progress_component
--- @return string
function M.attached_lsps_component()
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
  return M.highlight_content(content, M.get_or_create_hl(hl_base .. "Lsp", "Comment"))
end

--- Lsp progress component
--- Either shows attached lsps or a spinning icon
--- while the lsp is initializing
--- @return string
function M.lsp_component()
  if not lsp_progress.client or not lsp_progress.title then
    return M.attached_lsps_component()
  end

  local content = string.format("{%s}", icons.misc.spinner)
  return M.highlight_content(content, M.get_or_create_hl(hl_base .. "Lsp", "Comment"))
end

--- Renders the statusline.
---@return string
function M.render()
  ---@param components string[]
  ---@return string
  local function concat_components(components)
    return vim.iter(components):skip(1):fold(components[1], function(acc, component)
      return #component > 0 and string.format("%s%%#%s#%s", acc, hl_base, component) or acc
    end)
  end

  local mode = M.get_mode()

  return table.concat {
    concat_components {
      M.mode_component(mode),
      " ",
      M.file_component(mode),
      " ",
      M.git_component(),
    },
    "%=",
    concat_components {
      M.diagnostics_component(),
      "  ",
      M.filetype_component(),
      " ",
      M.lsp_component(),
      "  ",
      M.progress_component(mode),
    },
  }
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

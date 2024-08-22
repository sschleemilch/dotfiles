local hl = require("statusline.highlights")
local components = require("statusline.components")
local config     = require("statusline.config")
local M = {}

--- Renders the statusline.
---@return string
function M.render()
  hl.create()
  local mode = components.get_mode()
  local sep = " "
  if config.sep.left == nil and config.sep.right == nil then
    sep = ""
  end
  local stl = table.concat {
    hl.highlight_content(sep, hl.hls.base),
    components.mode(mode),
    sep,
    components.path(),
    sep,
    components.git(),
    "%=",
    components.diagnostics(),
    sep,
    components.filetype_lsp(),
    sep,
    components.progress(mode),
    sep
  }
  return stl
end

function M.setup()
  require("statusline.autocommands")
  vim.g.qf_disable_statusline = 1
  vim.o.showmode = false
  vim.o.statusline = "%!v:lua.require'statusline'.render()"
end

--- Refreshes the line
--- To be called e.g. from autocommands
function M.refresh()
  vim.cmd.redrawstatus()
end

return M

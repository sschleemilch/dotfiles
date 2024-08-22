local icons = require("icons")

local M = {
  bold = true,
  verbose_mode = false,
  sep = {
    left = icons.separators.circle_left,
    right = icons.separators.circle_right
  },
  hl = {
    modes = {
      normal = "Type",
      insert = "Function",
      pending = "Boolean",
      visual = "Keyword",
      command = "String",
    },
    base = "Normal",
    primary = "Normal",
    secondary = "Comment",
  },
}

return M

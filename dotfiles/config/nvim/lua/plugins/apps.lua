return {
  {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes"
            },
          }
        },
      },
    },
  },
}
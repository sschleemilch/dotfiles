return {
  {
    "echasnovski/mini.files",
    version = false,
    config = true,
    keys = {
      {
        "<leader>em",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>eM",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    }
  },
  -- search/replace in multiple files
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      headerMaxWidth = 80
    },
    cmd = "GrugFar",
    config = true,
    mode = { "n", "v" },
    keys = {
      {
        "<leader>sr",
        "<cmd>GrugFar<cr>",
        desc = "Replace in files (Grug-far)",
      },
    },
  },
  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    event = "VeryLazy",
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice =
                vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>bD",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
    },
  },
  { "christoomey/vim-tmux-navigator" },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = {
      winopts = {
        height = 0.5,
        width = 0.85,
        border = "none",
        preview = {
          hidden = "hidden",
        },
      },
      oldfiles = {
        cwd_only = true,
      },
      fzf_opts = {
        ["--padding"] = "1,2,2,2",
      },
    },
    keys = {
      { "<leader><leader>", "<cmd>FzfLua files<cr>",                desc = "Files" },
      { "<leader>ff",       "<cmd>FzfLua files<cr>",                desc = "Buffers" },
      { "<leader>,",        "<cmd>FzfLua buffers<cr>",              desc = "Buffers" },
      { "<leader>fb",       "<cmd>FzfLua buffers<cr>",              desc = "Buffers" },
      { "<leader>/",        "<cmd>FzfLua live_grep<cr>",            desc = "Grep" },
      { "<leader>fr",       "<cmd>FzfLua oldfiles<cr>",             desc = "Files recent" },
      { "<leader>fh",       "<cmd>FzfLua helptags<cr>",             desc = "Help" },
      { "<leader>fq",       "<cmd>FzfLua quickfix<cr>",             desc = "Quickfix" },
      { "<leader>fs",       "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Symbols" },
      { "<leader>fz",       "<cmd>FzfLua<cr>",                      desc = "Fzf" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {},
    keys = {
      { "<leader>ft", "<cmd>TodoQuickFix<cr>", desc = "Todos" },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
  {
    "folke/which-key.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}

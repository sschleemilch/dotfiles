return {
  {
    'saghen/blink.cmp',
    lazy = false,
    version = 'v0.*',
    opts = {
      keymap = {
        preset = 'default',
      },
      completion = {
        menu = {
          border = 'single',
          draw = {
            columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
            treesitter = { 'lsp' },
          },
        },
        documentation = {
          window = {
            border = 'single',
          },
        },
      },

      signature = {
        enabled = true,
        window = {
          border = 'single',
        },
      },
      appearance = {
        nerd_font_variant = 'normal',
      },
    },
  },
}

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
          border = 'rounded',
          draw = {
            columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
            treesitter = { 'lsp' },
          },
        },
        documentation = {
          window = {
            border = 'rounded',
          },
        },
      },

      signature = {
        enabled = true,
        window = {
          max_height = 1,
          border = 'rounded',
        },
      },
      appearance = {
        nerd_font_variant = 'normal',
      },
    },
  },
}

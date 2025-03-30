return {
  {
    'saghen/blink.cmp',
    lazy = false,
    version = 'v1.*',
    opts = {
      keymap = {
        preset = 'default',
      },
      completion = {
        menu = {
          draw = {
            columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
            treesitter = { 'lsp' },
          },
        },
      },
      signature = {
        enabled = true,
      },
      appearance = {
        nerd_font_variant = 'normal',
      },
    },
  },
}

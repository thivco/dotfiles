return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    version = '*',

    opts = {
      keymap = {
        preset = 'default',
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<Enter>'] = { 'accept', 'fallback' },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      completion = {
        documentation = { auto_show = true },
        menu = {
          auto_show = true,
        },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = 'mono'
        },
        signature = { enabled = true }
      },
      opts_extend = { "sources.default" }
    },
  }
}

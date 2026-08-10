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
        ['<Enter>'] = { 'select_and_accept', 'fallback' },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          cmdline = {
            min_keyword_length = 2,
          }
        }
      },
      completion = {
        trigger = { show_on_keyword = true },
        documentation = { auto_show = true },
        menu = {
          auto_show = true,
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" }
  }
}

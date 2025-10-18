return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    -- List of language servers to configure
    opts = {
      servers = {
        lua_ls = {},
        ts_ls = {},
        vls = {},
        bashls = {},
        html = {},
        emmet = {},
        intelephense = {
          settings = {
            intelephense = {
              diagnostics = {
                undefinedProperties = false,
              },
            },
          },
          cmd = { "intelephense", "--stdio" },
          filetypes = { "php" },
          root_markers = { ".git", "composer.json" },
        },
      }
    },
    config = function(_, opts)
      -- auto format on save
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          if not client then return end

          if not client:supports_method('textDocument/willSaveWaitUntil')
              and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })

      -- DEPRECATED : local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)

        -- lspconfig[server].setup(config)
        -- seems redundant with what's just above
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)

        vim.diagnostic.config({
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.HINT] = "󰠠 ",
              [vim.diagnostic.severity.INFO] = " ",
            },
          },
        })
      end
    end
  }
}

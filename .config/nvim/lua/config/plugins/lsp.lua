return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      'artemave/workspace-diagnostics.nvim',
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
        lua_ls = {
          filetypes = { "lua" },
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        },

        bashls = {
          filetypes = { "sh" },
        },
        hyprls = { filetypes = { "conf" } },
        emmet = {},
        nil_ls = { filetypes = { "nix" } },
        qmlls = { filetypes = { "qml" } },
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
        html = {},
        cssls = {
          filetypes = {
            "css",
            "scss",
            "less",
            -- "vue"
          },
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
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 100 })
              end,
            })
          end
        end,
      })

      -- vim.diagnostic.config({
      -- virtual_lines = true,
      -- })

      --      eslint config if needed, it's nice but it's just the same as the lsp
      --      lspconfig.eslint.setup({
      --        on_attach = function(client, bufnr)
      --          -- optional: auto-fix on save
      --          vim.api.nvim_create_autocmd("BufWritePre", {
      --            buffer = bufnr,
      --            command = "EslintFixAll"
      --          })
      --        end,
      --      })


      for server, config in pairs(opts.servers) do
        vim.lsp.config[server] = config
        vim.lsp.enable(server)
        -- if server == "volar" then
        --   config.root_dir = util.root_pattern("tsconfig.json", "package.json", ".git")
        -- end
        -- config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      end

      local vue_ls          = require("config.lsp.vue_ls")
      local vtsls           = require("config.lsp.vtsls")

      vim.lsp.config.vtsls  = vtsls
      vim.lsp.config.vue_ls = vue_ls

      vim.lsp.enable({ "vtsls" })
      vim.lsp.enable({ "vue_ls" })

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
  }
}

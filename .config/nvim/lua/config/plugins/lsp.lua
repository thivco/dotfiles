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
        lua_ls = {},
        volar = {
          on_attach = function(client, bufnr)
            require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
          end,
          cmd = { "vue-language-server", "--stdio" },
          filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
          --root_dir = require("lspconfig.util").root_pattern("tsconfig.app.json", "tsconfig.json", "package.json", ".git"),

          root_dir = function(fname)
            return vim.lsp.config.util.root_pattern("tsconfig.app.json", "tsconfig.json", "package.json", ".git")(fname)
          end,

          init_options = {
            vue = { hybridMode = false },
            typescript = {
              tsdk = "/nix/store/hl69bzlr5ijvsvjcc1z24qrkxs4xdlyp-typescript-5.8.3/lib/node_modules/typescript/lib/",
            },
          },
          settings = {
            volar = {
              codeLens = { references = true, pugTools = true, scriptSetupTools = true },
              diagnostics = { enable = true },
            },
          },
        },
        bashls = {},
        html = {},
        hyprls = {},
        emmet = {},
        nil_ls = {},
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
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 100 })
              end,
            })
          end
        end,
      })

      vim.diagnostic.config({
        virtual_lines = true,
      })

      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      -- DEPRECATED : local lspconfig = require('lspconfig')

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
        --vim.lsp.config(server, config)
        --vim.lsp.enable(server)
        if server == "volar" then
          config.root_dir = util.root_pattern("tsconfig.json", "package.json", ".git")
        end
        -- seems redundant with what's just above
        --vim.lsp.config[server] = vim.tbl_deep_extend("force", {
        --  capabilities = require("blink.cmp").get_lsp_capabilities(),
        --}, config)
        lspconfig[server].setup(config)
        --config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
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

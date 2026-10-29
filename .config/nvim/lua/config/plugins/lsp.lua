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
        hyprls = {
          -- filetypes = { "conf" }
        },
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
        html = { filetypes = { "html" } },
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
      local has_blink, blink = pcall(require, "blink.cmp")
      local capabilities     = has_blink and blink.get_lsp_capabilities() or {}

      -- opts.servers.vtsls     = require("config.lsp.vtsls")
      -- opts.servers.vue_ls    = require("config.lsp.vue_ls")
      -- opts.servers.pyright   = require("config.lsp.pyright")
      -- opts.servers.rust      = require("config.lsp.rust")

      for _, path in ipairs(vim.api.nvim_get_runtime_file("lua/config/lsp/*.lua", true)) do
        local name = vim.fn.fnamemodify(path, ":t:r")
        local ok, cfg = pcall(require, "config.lsp." .. name)
        if ok then
          opts.servers[name] = cfg
        else
          vim.notify("LSP config '" .. name .. "' failed: " .. tostring(cfg), vim.log.levels.ERROR)
        end
      end

      for server, config in pairs(opts.servers) do
        local base_config = vim.lsp.config[server] or {}

        config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})

        vim.lsp.config[server] = vim.tbl_deep_extend("force", base_config, config)
        vim.lsp.enable(server)
      end

      vim.diagnostic.config({
        virtual_lines = true,
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

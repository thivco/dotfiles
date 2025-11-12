return { {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  branch = "master",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = { "typescript", "javascript", "nix", "php", "vue", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "html", "css", "tsx", "vue", "json" },
      auto_install = true,
      indent = { enable = true },
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      }
    })
  end
} }

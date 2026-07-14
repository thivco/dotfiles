return {
  {
    'stevearc/conform.nvim',
    opts = {},
    enabled = true,
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          php = { "phpcbf" },
          lua = { "stylua" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          -- python = { "ruff_organize_imports", "ruff_format" },
          python = { "autopep8" },
        },
        format_on_save = {
          timeout_ms = 1000,
          lsp_format = "fallback",
          -- lsp_fallback = true,
        },
        formatters = {
          phpcbf = {
            command = "phpcbf",
            args = { "$FILENAME" },
            stdin = false,
          },
          autopep8 = {
            command = "autopep8",
            args = { "-", "--max-line-length", "79" },
            stdin = true,
          },
        },
      })
    end,
  },
}

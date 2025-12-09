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
          typescript = { "prettierd", "prettier", stop_after_first = true }
        },
        format_on_save = {
          timeout_ms = 100,
          lsp_fallback = true,
        },
        formatters = {
          phpcbf = {
            command = "phpcbf",
            args = { "$FILENAME" },
            stdin = false,
          },
        },
      })
    end,
  },
}

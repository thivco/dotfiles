return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "flake8", "mypy" },
      }

      lint.linters.mypy.args = {
        "--hide-error-context",
        "--no-color-output",
        "--show-column-numbers",
        "--show-error-codes",
      }

      local lint_group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = lint_group,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}

return {
  {
    'stevearc/oil.nvim',
    config = function(_, opts)
      require("oil").setup(opts)

      -- Auto-open oil when starting nvim without arguments
      vim.api.nvim_create_autocmd("VimEnter", {
        nested = true,
        callback = function()
          -- Only open oil if we started with no arguments and have an empty buffer
          if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" then
            vim.cmd("Oil")
          end
        end,
      })
    end,
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
      float = {
        padding = 2,
        max_width = 90,
        max_height = 0,
      },
      win_options = {
        signcolumn = "yes",
        statuscolumn = "",
        wrap = true,
        winblend = 0,
      },
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  }
}

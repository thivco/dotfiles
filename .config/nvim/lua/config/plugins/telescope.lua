return { {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
  },
  config = function()
    -- Set up the keybinding for Telescope find_files
    local actions = require("telescope.actions")
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          }
        }
      },
      pickers = {
        find_files = {
          hidden = true,
          theme = "ivy"
        }
      },
      extensions = {
        fzf = {
        }
      }
    }
    --	map('n', '<space>fd', function()
    --	vim.key	require('telescope.builtin').find_files()
    --	vim.keyend, { noremap = true, silent = true })
    --map('n', '<leader>j', '<Cmd>:wq<CR>')
  end,
}
}

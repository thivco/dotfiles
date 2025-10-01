return { {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
  },
  config = function()
    -- Set up the keybinding for Telescope find_files
    require('telescope').setup {
      pickers = {
        find_files = {
          theme = "ivy"
        }
      },
      extensions = {
        fzf = {}
      }
    }
    --	vim.keymap.set('n', '<space>fd', function()
    --	vim.key	require('telescope.builtin').find_files()
    --	vim.keyend, { noremap = true, silent = true })
    local builtin = require("telescope.builtin")
    vim.keymap.set('n', '<space>fd', builtin.find_files)
    vim.keymap.set('n', '<space>fz', builtin.live_grep)
  end,
}
}

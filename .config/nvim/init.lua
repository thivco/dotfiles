print("SVERIGE")
local set = vim.opt
--using set instead of calling the vim.opt every time

set.shiftwidth = 2
set.cursorline = true
set.number = true
set.relativenumber = true

-- declaring leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- vim.lsp.set_log_level("debug")

-- imports
require("config.lazy")
require("config.mini_diagnostics").setup();
-- require("config.highligths").setup();
require("config.keybinds")
require('nvim-autopairs').setup()

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { "*.hl", "hypr*.conf" },
  callback = function(event)
    print(string.format("starting hyprls for %s", vim.inspect(event)))
    vim.lsp.start {
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    }
  end
})

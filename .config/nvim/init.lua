print("SVERIGE")
local set = vim.opt
--using set instead of calling the vim.opt every time

set.shiftwidth = 4
set.tabstop = 4
set.expandtab = true
set.smartindent = true
set.cursorline = true
set.number = true
set.relativenumber = true
set.softtabstop = 4

-- declaring leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- vim.lsp.set_log_level("debug")

-- removed for python column tab issue : did not work tho
-- vim.opt.smartindent = false
vim.opt.cindent = false
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- Stop the colon from triggering indentation re-evaluation
    -- vim.opt_local.indentkeys:remove(":")
    vim.opt_local.indentkeys = "0{,0},0),0],!,^F,o,O"
  end,
})

-- imports
require("config.lazy")
require("config.mini_diagnostics").setup();
-- require("config.highligths").setup();
require("config.keybinds")
require('nvim-autopairs').setup()
vim.cmd("colorscheme kanagawa")

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

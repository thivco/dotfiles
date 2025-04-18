print("testing")
require("config.lazy")
local set = vim.opt
--using set instead of calling the vim.opt every time

set.shiftwidth = 2
set.number = true
set.relativenumber = true



vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

--oil nvim 
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set('n', '<Space><Space>e', ':Oil --float<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space><Space>o', ':Oil --float .<CR>', { noremap = true, silent = true })
require("oil").setup()

require('nvim-autopairs').setup()

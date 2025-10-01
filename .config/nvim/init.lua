print("SVERIGE")
require("config.lazy")
local set = vim.opt
--using set instead of calling the vim.opt every time

set.shiftwidth = 2
set.number = true
set.relativenumber = true

config_path = "~/workshop/lab/dotfiles/.config/nvim/init.lua"


vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

--oil nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set('n', '<Space><Space>e', ':Oil --float<CR>', { noremap = true, silent = true })

-- Create vertical split window
vim.keymap.set("n", "<leader>vv", ":vsplit<CR>")

-- Create horizontal split window
vim.keymap.set("n", "<leader>hh", ":split<CR>")

require('nvim-autopairs').setup()

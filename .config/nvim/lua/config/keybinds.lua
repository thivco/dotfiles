--teesope binds
local map = vim.keymap.set
local builtin = require("telescope.builtin")

map('n', '<leader>fd', builtin.find_files)
map('n', '<leader>fz', builtin.live_grep)

-- other binds
vim.keymap.set("n", "<leader><leader>x", "<cmd>source ~/workshop/lab/dotfiles/.config/nvim/<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

--oil nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set('n', '<leader><leader>e', ':Oil --float<CR>', { noremap = true, silent = true })

-- Create split window
vim.keymap.set("n", "<leader>vv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>hh", ":split<CR>")

-- LSP
map('n', '<leader>di', '<cmd>lua vim.diagnostic.open_float()<CR>')
map('n', '<leader>do', ':DevdocsOpen<CR>')

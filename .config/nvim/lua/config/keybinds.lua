local map = vim.keymap.set
local builtin = require("telescope.builtin")


-- other binds
vim.keymap.set("n", "<leader><leader>x", "<cmd>source ~/workshop/lab/dotfiles/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

--oil nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set('n', '<leader><leader>e', ':Oil <CR>', { noremap = true, silent = true })

-- Create split window
vim.keymap.set("n", "<leader>vv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>hh", ":split<CR>")

-- LSP
map('n', '<leader>di', '<cmd>lua vim.diagnostic.open_float()<CR>')
map('n', '<leader>do', ':DevdocsOpen<CR>')

-- Telescope
map('n', '<leader>fd', builtin.find_files) -- File finder
map('n', '<leader>fz', builtin.live_grep)  -- Fuzzy find in files
map("n", "<leader>fl", builtin.oldfiles)   -- Check recently opened files

-- Navigation
map('n', 'gd', vim.lsp.buf.definition)
map('n', 'gi', vim.lsp.buf.implementation)
map('n', 'K', vim.lsp.buf.hover)
map('n', 'gb', '<C-o>')

-- completion

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

-- imports
require("config.lazy")
require("config.keybinds")
require('nvim-autopairs').setup()

--require('nvim-ts-autotag').setup({
--  opts = {
--    enable_close = true,          -- Auto close tags
--    enable_rename = true,         -- Auto rename pairs of tags
--    enable_close_on_slash = false -- Auto close on trailing </
--  },
--})

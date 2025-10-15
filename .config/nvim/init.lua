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

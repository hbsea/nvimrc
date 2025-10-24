vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.keymap.set("n", "<leader>e", function()
	vim.cmd("edit ~/.config/nvim/init.lua")
  end)
 
  
vim.keymap.set("n", "<leader>et", function()
	vim.cmd("Edit ~/.config/nvim/lua/plugins/treesitter.lua")
  end)

-- PLUGINS
require("config.lazy")

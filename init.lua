vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- vim.opt.clipboard = "unnamedplus"
vim.opt.inccommand = "split"
vim.opt.termguicolors = true
-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
-- make line numbers default
vim.opt.number = true
-- minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 7
-- hightlight current line
vim.opt.cursorline = true
-- keep signcolumn on by default
vim.opt.signcolumn = 'yes'
-- indenting
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- Enable break indent
vim.opt.breakindent = true
-- interval for writing swap file to disk, also used by gitsigns
vim.opt.updatetime = 250
-- save undo history
vim.opt.undofile = true
-- Decrease mapped sequence wait time
-- vim.opt.timeoutlen = 300
-- autoreload
vim.opt.autoread = true


-- fast save file
vim.keymap.set('n', '<leader>w', '<cmd>write!<CR>', { desc = 'Edit my configs' })
-- fast edit config
vim.keymap.set('n', '<leader>e', '<cmd>edit ~/.config/nvim/init.lua<CR>', { desc = 'Edit my configs' })
vim.keymap.set('n', '<leader>ee', function()
    local file = vim.fn.input('Edit file:','~/.config/nvim/lua/plugins/','file')
    local stat = vim.loop.fs_stat(vim.fn.expand(file))
    if stat and stat.type == 'file' then
        vim.cmd('edit ' .. file)
    end
end, { desc = 'Edit my configs' })

-- fast move in c mode
vim.keymap.set('c', '<C-a>', '<Home>', { desc = 'Go to beginning of command line' })
vim.keymap.set('c', '<C-e>', '<End>', { desc = 'Go to end of command line' })
vim.keymap.set('c', '<M-b>', '<S-Left>', { desc = 'Move back a word' })
vim.keymap.set('c', '<Esc>b', '<S-Left>', { desc = 'Move back a word (fallback)' })
vim.keymap.set('c', '<M-f>', '<S-Right>', { desc = 'Move forward a word' })
vim.keymap.set('c', '<Esc>f', '<S-Right>', { desc = 'Move forward a word (fallback)' })
-- emacs style
vim.keymap.set('i', '<C-e>', '<End>', { desc = 'Go to end of line' })
vim.keymap.set('i', '<C-a>', '<Home>', { desc = 'Go to beginning of line' })
-- force-write using sudo
vim.api.nvim_create_user_command('W', function() vim.cmd('w !sudo tee % > /dev/null') vim.cmd('edit!') end, { nargs = 0, desc = 'Force-write using sudo', })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, { pattern = "*", command = "silent! checktime", })

-- comment a line
vim.keymap.set("n", "<C-/>", function() return require('vim._comment').operator() .. '_' end,{ expr = true, desc = 'Toggle comment line' })
vim.keymap.set("n", "<Esc>j", "mz:m+<CR>`z", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>k","mz:m-2<CR>`z", { noremap = true, silent = true })
vim.keymap.set("v", "<Esc>j",":m '>+<CR>`<my`>mzgv`yo`z", { noremap = true, silent = true })
vim.keymap.set("v", "<Esc>k",":m '<-2<CR>`>my`<mzgv`yo`z", { noremap = true, silent = true })


require("config.lazy")
require("config.lsp")
require("config.dap_watches")
-- PLUGINS
-- nvim-tree
-- treesitter
-- lsp
-- dap
-- lint
-- c lint and format is use clangd ,clang-format by the  lsp server default, vim.lsp.buf.format()

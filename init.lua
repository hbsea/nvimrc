vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- =>FILE
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

--=>COMMAND
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
vim.api.nvim_create_user_command('W', function()
  vim.cmd('w !sudo tee % > /dev/null')
  vim.cmd('edit!')
end, {
  nargs = 0,
  desc = 'Force-write using sudo',
})
-- autoreload
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  pattern = "*",
  command = "silent! checktime",
})
-- interval for writing swap file to disk, also used by gitsigns
vim.o.updatetime = 250
-- save undo history
vim.o.undofile = true

-- =>LINE
-- Don't show the mode, since it's already in the status line
vim.o.showmode = false
-- make line numbers default
vim.o.number = true
-- minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 7
-- hightlight current line
vim.o.cursorline = true
-- keep signcolumn on by default
vim.o.signcolumn = 'yes'
-- indenting
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
-- Enable break indent
vim.o.breakindent = true
-- comment a line
local line_rhs = function()
  return require('vim._comment').operator() .. '_'
end
vim.keymap.set("n", "<C-/>", line_rhs,{ expr = true, desc = 'Toggle comment line' })
vim.keymap.set("n", "<Esc>j", "mz:m+<CR>`z", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>k","mz:m-2<CR>`z", { noremap = true, silent = true })
vim.keymap.set("v", "<Esc>j",":m '>+<CR>`<my`>mzgv`yo`z", { noremap = true, silent = true })
vim.keymap.set("v", "<Esc>k",":m '<-2<CR>`>my`<mzgv`yo`z", { noremap = true, silent = true })


-- =>SEARCH
-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
vim.keymap.set("n", "<leader><CR>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-- =>PLUGINS
require("config.lazy")
require("config.dap_watches")
require("config.lsp")
-- nvim-tree
-- lsp
vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.config('*', {
capabilities = {
  textDocument = {
    semanticTokens = {
      multilineTokenSupport = true,
    }
  }
},
root_markers = { '.git' },
})


-- dap
-- vim.fn.sign_define("DapBreakpoint", { text = "🔴" })

-- c lint and format is use clangd ,clang-format by the  lsp server default, vim.lsp.buf.format()
-- lint
-- format






vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- FILE
-- autoreload
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  pattern = "*",
  command = "silent! checktime",
})
-- interval for writing swap file to disk, also used by gitsigns
vim.o.updatetime = 250
-- Save undo history
vim.o.undofile = true

-- LINE
-- Make line numbers default
vim.o.number = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 7
-- hightlight current line
vim.o.cursorline = true
-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- SEARCH
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- indenting
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- PLUGINS
require("config.lazy")
-- theme
vim.cmd[[colorscheme tokyonight-night]]
-- lsp
vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
-- dap
vim.fn.sign_define("DapBreakpoint", { text = "🔴" })

-- c lint and format is use clangd ,clang-format by the  lsp server default, vim.lsp.buf.format()
-- lint
-- format






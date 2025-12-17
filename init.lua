vim.g.mapleader = ","
vim.g.maplocalleader = ","


-- vim.opt.makeprg = "sh -c 'cmake --build build --target clean && cmake --build build --target run-qemu'"
vim.opt.makeprg = "bear -- make"
vim.opt.errorformat = "%f:%l:%c: %trror: %m"

vim.opt.mouse = "a"
vim.opt.ttyfast = true
vim.opt.lazyredraw = false
vim.opt.clipboard = "unnamedplus"
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
-- Provides tab-completion for all file-related tasks
vim.opt.path:append { "**" }


-- fast save file
vim.keymap.set('n', '<leader>w', '<cmd>write!<CR>', { desc = 'Edit my configs' })
-- fast edit config
vim.keymap.set('n', '<leader>e', '<cmd>edit ~/.config/nvim/init.lua<CR>', { desc = 'Edit my configs' })
vim.keymap.set('n', '<leader>ee', function()
    local file = vim.fn.input('Edit file:','~/.config/nvim/lua/plugins/','file')
---@diagnostic disable-next-line: undefined-field
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
vim.keymap.set("n", "<C-_>", function () return require('vim._comment').operator() .. '_' end,{ expr = true, desc = 'Toggle comment line' })
vim.keymap.set("n", "<C-j>", "mz:m+<CR>`z", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>","mz:m-2<CR>`z", { noremap = true, silent = true })
vim.keymap.set("v", "<C-j>",":m '>+<CR>`<my`>mzgv`yo`z", { noremap = true, silent = true })
vim.keymap.set("v", "<C-k>",":m '<-2<CR>`>my`<mzgv`yo`z", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>b", function()
    vim.cmd("silent make clean")
    -- vim.cmd("silent make")
    vim.cmd("make")
    -- vim.cmd("NvimTreeClose")
    vim.cmd("botright vsplit")
    vim.cmd("vertical resize " .. math.floor(vim.o.columns / 2.5))
    local cmd = [[bash -c 'qemu-system-aarch64 -M raspi4b -S -s -nographic -kernel build/kernel8.img']]
    vim.cmd("terminal " .. cmd)
    vim.cmd("normal! G")
    vim.cmd("wincmd p")
    vim.cmd("botright 8split")
    local cmdlldb=[[bash -c 'lldb -s .lldb']]
    vim.cmd("terminal " .. cmdlldb)
    vim.cmd("startinsert")
    vim.cmd("autocmd TermClose * lua Close_Qemu_when_lldb_exits()")
end, { noremap = true, silent = true })

function Close_Qemu_when_lldb_exits()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(buf)
        local bt = vim.bo[buf].buftype
        if name:match("qemu%-system%-aarch64")
            or name == ""
            or bt == "nofile"
            or bt == "terminal"
        then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
    vim.cmd("only")
    vim.defer_fn(function()
        if not pcall(vim.cmd.NvimTreeOpen) then
            vim.cmd("NvimTreeToggle")
        end
        vim.cmd("wincmd p")
    end, 100)
end

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
local fzf_config = require("fzf-lua.config")  -- fzf-lua 配置
local trouble_actions = require("trouble.sources.fzf").actions  -- trouble.nvim fzf 源的 actions
fzf_config.defaults.actions.files["ctrl-t"] = trouble_actions.open

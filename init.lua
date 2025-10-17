-- Make line numbers default
vim.o.number = true


-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 7


require("config.lazy")
vim.lsp.enable("clangd")


function CompileRun()
  if vim.bo.modified then
    vim.cmd("write")
  end

  if vim.bo.filetype == "sh" then
    vim.cmd("!time python3 %")
  else
    vim.fn.system("tmux split-window -l 30 'lldb -s .lldbinit'")
    vim.cmd("make")
  end
end
vim.keymap.set("n", "<F5>", CompileRun, { noremap = true, silent = true })



local dap = require('dap')

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb',
}
-- 配置 C/C++ target
dap.configurations.c = {
  {
    name = "Debug Remote Kernel",
    type = "lldb",       -- 使用上面定义的 adapter
    request = "attach",
    program = vim.fn.getcwd() .. "/build/kernel8.elf",  -- ELF 文件路径
    cwd = '${workspaceFolder}',
    stopOnEntry = false,   -- 启动后停在入口
    runInTerminal = true,
    initCommands = {
	    -- "target create build/kernal8.elf",
	    "gdb-remote 1234",
	    "continue",
    },
  },
}

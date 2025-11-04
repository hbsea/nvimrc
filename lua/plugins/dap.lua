return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
  },
  opts = {},

  keys = {
	  { "<leader>du", function()
            vim.cmd("NvimTreeClose")
            require("dapui").toggle()
            vim.cmd("wincmd p")
        end, desc = "toggle dap-ui", },
	  { "<F9>", function() require("persistent-breakpoints.api").toggle_breakpoint() end, desc = "Debug: toggle break(mark)", },
	  { "<F10>", function() require("dap").step_into() end, desc = "Debug: step into", },
      { "<F6>", function() require("dap").step_out() end, desc = "Step Out" },
	  { "<F11>", function() require("dap").step_over() end, desc = "Debug: step over", },
	  { "<leader>dq", function() require("dap").terminate() end, desc = "Debug: terminate", },
	  { "<F5>", function() require("dap").continue() end,desc = "Dap continue",},
	  { "<leader>b", function()
              vim.cmd("NvimTreeClose")
              vim.cmd("botright 8split")
              local cmd = [[bash -c 'cmake -S . build && cmake --build build --target run-qemu && qemu-system-aarch64 -M raspi4b -S -s -nographic -kernel build/kernel8.img']]
              vim.cmd("terminal " .. cmd)
              vim.cmd("normal! G")
              vim.cmd("wincmd p")
              require("dapui").open()
              require("dap").continue()
          end, desc = "Build Task",
       },
  },

  config = function()
	local dap = require 'dap'
	local dapui = require 'dapui'

    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
        vim.cmd("only")
        vim.cmd("NvimTreeOpen")
        vim.cmd("wincmd p")
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local name = vim.api.nvim_buf_get_name(buf)
            if name:match("qemu%-system%-aarch64") or name:match("cmake") then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end

    dap.adapters.codelldb = {
      type = 'executable',
      command = '/home/any/codelldb/extension/adapter/codelldb',
        args = {
        "--settings",
        vim.json.encode({
          showDisassembly = "never",
        }),
      },
    }

    -- https://github.com/vadimcn/codelldb/blob/master/MANUAL.md
    dap.configurations.c = {
      {
        name = "Debug Remote Kernel",
        type = "codelldb",       --使用上面定义的 adapter
        request = "attach",
        targetCreateCommands = {"target create ${workspaceFolder}/build/kernel8.elf"},
        processCreateCommands = {"gdb-remote localhost:1234"},
        postRunCommands = {"continue"},
      },
    }
    dap.configurations.asm=dap.configurations.c
    dap.configurations.lua=dap.configurations.c

	dapui.setup {
		icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        layouts = { {
            elements = { {
              id = "scopes",
              size = 0.4
            }, {
              id = "breakpoints",
              size = 0.2
            }, {
              id = "stacks",
              size = 0.2
            }, {
              id = "watches",
              size = 0.2
            } },
            position = "left",
            size = 45
          -- }, {
          --   elements = { {
          --     id = "repl",
          --     size = 1
          --   }, {
          --     id = "console",
          --     size = 0.5
          --   }
          --   },
          --   position = "bottom",
          --   size = 12
      } },
	}


  end
}

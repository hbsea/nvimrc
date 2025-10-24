return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
  },
  opts = {},

  keys = {
	  { "<leader>du", function() require("dapui").toggle() end, desc = "toggle dap-ui", },
	  { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: toggle break(mark)", },
	  { "<F6>", function() require("dap").run_last() end, desc = "Debug: step over", },
	  { "<F10>", function() require("dap").step_into() end, desc = "Debug: step into", },
	  { "<F11>", function() require("dap").step_over() end, desc = "Debug: step over", },
	  { "<leader>dq", function() require("dap").terminate() end, desc = "Debug: terminate", },
	  { "<F5>", function() 

            local partial = ""
            local build_result = vim.fn.system("cmake --build build --target run-qemu 2>&1")

            vim.fn.jobstart({ "qemu-system-aarch64", "-M","raspi4b","-S", "-s", "-nographic", "-kernel", "build/kernel8.img", }, {
              stdout_buffered = false,
              pty = true,
              on_stdout = function(_, data)
                if not data then return end
                for _, chunk in ipairs(data) do
                      chunk = chunk:gsub("\r\n", "\n"):gsub("\r", "\n")
                      partial = partial .. chunk
                      for line in partial:gmatch("(.-)\n") do
                        if line ~= "" then
                          require("dap.repl").append(line)
                        end
                      end

                      if partial:match("\n$") then
                            partial = ""
                      else
                        partial = partial:match("([^\n]*)$")
                      end
                end
                  end,
                  on_stderr = function(_, data)
                    if data then
                      for _, line in ipairs(data) do
                          require("dap.repl").append(line)
                      end
                    end
                  end,
                })

          require("dap").continue() 
          end, desc = "Debug: start/continue", 
       },
  },

  config = function()
	local dap = require 'dap'
	local dapui = require 'dapui'

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
      -- {
      --   name = 'standar Launch',
      --   type = 'codelldb',
      --   request = 'launch',
      --   program = function()
      --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/a.out', 'file')
      --   end,
      --   cwd = '${workspaceFolder}',
      --   stopOnEntry = false,
      --   },
      {
        name = "Debug Remote Kernel",
        type = "codelldb",       --使用上面定义的 adapter
        request = "attach",
        cwd = '${workspaceFolder}',
        stopOnEntry = false,   -- 启动后停在入口
        targetCreateCommands = {"target create ${workspaceFolder}/build/kernel8.elf"},
        processCreateCommands = {"gdb-remote localhost:1234"},
      },
    }
    dap.configurations.asm=dap.configurations.c



	dapui.setup {
		icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
		controls = {
			icons = {
				pause = '⏸',
				play = '▶️',
				step_into = '⤵️',
				step_over = '⏩',
				step_out = '⤴️',
				step_back = '↩️',
				run_last = '⏭️',
				terminate = '⏹',
				disconnect = '⏏️',
			},
		},
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
            size = 40
          }, {
            elements = { {
              id = "repl",
              size = 1
            }, 
            -- {
            --   id = "console",
            --   size = 0.5
            -- }
            },
            position = "bottom",
            size = 12
      } },
	}


  end
}

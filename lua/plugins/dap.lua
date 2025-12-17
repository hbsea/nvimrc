return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },
    opts = {},

    keys = {
        -- { "<leader>du", function()
        --     vim.cmd("NvimTreeClose")
        --     require("dapui").toggle()
        --     vim.cmd("wincmd p")
        -- end, desc = "toggle dap-ui", },
        -- { "<leader>db", function() require("persistent-breakpoints.api").toggle_breakpoint() end, desc = "Debug: toggle break(mark)", },
        -- { "<F10>", function() require("dap").step_into({ granularity = "instruction" }) end, desc = "Debug: step into", },
        -- { "<F6>", function() require("dap").step_out() end, desc = "Step Out" },
        -- { "<F11>", function() require("dap").step_over() end, desc = "Debug: step over", },
        -- { "<leader>dq", function() require("dap").terminate() end, desc = "Debug: terminate", },
        -- { "<F5>", function() require("dap").continue() end,desc = "Dap continue",},
        -- { "<leader>b", function()
        --     vim.cmd("silent make")
        --     vim.cmd("NvimTreeClose")
        --     vim.cmd("botright 48vsplit")
        --     local cmd = [[bash -c 'qemu-system-aarch64 -M raspi4b -S -s -nographic -kernel build/kernel8.img']]
        --     vim.cmd("terminal " .. cmd)
        --     vim.cmd("normal! G")
        --     vim.cmd("wincmd p")
        --     vim.cmd("botright 8split")
        --     local cmdlldb=[[bash -c 'lldb']]
        --     vim.cmd("terminal " .. cmdlldb)
        --     -- require("dapui").open()
        --     -- require("dap").continue()
        -- end, desc = "Build Task",
        -- },
    },

    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'
        local saved_buf = nil
        dap.listeners.before.event_initialized.save_current_buf = function()
            saved_buf = vim.api.nvim_get_current_buf()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
            if saved_buf and vim.api.nvim_buf_is_valid(saved_buf) then
                vim.api.nvim_set_current_buf(saved_buf)
            end
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                local name = vim.api.nvim_buf_get_name(buf)
                local bt = vim.bo[buf].buftype
                if name:match("qemu%-system%-aarch64")
                    or name:match("cmake")
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

        dap.adapters.codelldb = {
            type = 'executable',
            command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
            args = {
                "--settings",
                vim.json.encode({
                    -- showDisassembly = "never",
                    showDisassembly = "always",
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
                -- postRunCommands = {"continue"},
                initCommands = function()
                    return { "settings set frame-format hex" }
                end
            },
        }
        dap.configurations.asm=dap.configurations.c
        dap.configurations.lua=dap.configurations.c
        dap.configurations.cpp=dap.configurations.c

        dapui.setup({
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
        })


    end
}

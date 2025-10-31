return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        require("nvim-treesitter.configs").setup {
            indent = { enable = true },
            highlight = { enable = true },
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim 
                    lookahead = true, 
                    keymaps = { 
                        ["ia"] = "@assignment.inner",
                        ["asl"] = "@assignment.lhs",
                        ["aas"] = "@assignment.outer",
                        ["asr"] = "@assignment.rhs",
                        ["iat"] = "@attribute.inner",
                        ["aat"] = "@attribute.outer",
                        ["ib"] = "@block.inner",
                        ["ab"] = "@block.outer",
                        ["ic"] = "@call.inner",
                        ["ac"] = "@call.outer",
                        ["icl"] = "@class.inner",
                        ["acl"] = "@class.outer",
                        ["i/"] = "@comment.inner",
                        ["a/"] = "@comment.outer",
                        ["iif"] = "@conditional.inner",
                        ["aif"] = "@conditional.outer",
                        ["ifr"] = "@frame.inner",
                        ["afr"] = "@frame.outer",
                        ["if"] = "@function.inner",
                        ["af"] = "@function.outer",
                        ["il"] = "@loop.inner",
                        ["al"] = "@loop.outer",
                        ["an"] = "@number.inner",
                        ["ip"] = "@parameter.inner",
                        ["ap"] = "@parameter.outer",
                        ["ig"] = "@regex.inner",
                        ["ag"] = "@regex.outer",
                        ["ir"] = "@return.inner",
                        ["ar"] = "@return.outer",
                        ["is"] = "@scopename.inner",
                        ["as"] = "@statement.outer", 
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                      ['@parameter.outer'] = 'v', -- charwise
                      ['@function.outer'] = 'V', -- linewise
                      ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true or false
                    include_surrounding_whitespace = false,
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = { query = "@class.outer", desc = "Next class start" },
                --
                -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
                ["]o"] = "@loop.*",
                -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                --
                -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
                ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
              },
              goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
              },
              goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
              },
              goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
              },
              -- Below will go to either the start or the end, whichever is closer.
              -- Use if you want more granular movements
              -- Make it even more gradual by adding multiple queries and regex.
              goto_next = {
                ["]d"] = "@conditional.outer",
              },
              goto_previous = {
                ["[d"] = "@conditional.outer",
              }
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>A"] = "@parameter.inner",
                },
            }, 
            lsp_interop = {
              enable = true,
              border = 'none',
              floating_preview_opts = {},
              peek_definition_code = {
                ["<leader>df"] = "@function.outer",
                ["<leader>dF"] = "@class.outer",
              },
            },
        },
    }
        local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

        -- Repeat movement with ; and ,
        -- ensure ; goes forward and , goes backward regardless of the last direction
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    end,
}

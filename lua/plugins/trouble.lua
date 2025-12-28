return {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
        {
            "<leader>xn",
            "<cmd>Trouble qflist next<cr><cmd>Trouble qflist jump<cr>",
            desc = "Quickfix Next (Trouble)",
        },
        {
            "<leader>xp",
            "<cmd>Trouble qflist prev<cr><cmd>Trouble qflist jump<cr>",
            desc = "Quickfix Prev (Trouble)",
        },
    },
}

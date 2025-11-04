return {
    {
    'nvim-lualine/lualine.nvim',
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require('lualine').setup({
            options = {
                    theme = 'solarized_dark',
                    -- theme = 'auto',
                    icons_enabled = false,
                  },
        })
    end
    },{
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        vim.cmd.colorscheme("solarized-osaka")
        vim.api.nvim_set_hl(0, "Include", { fg = "#859900" })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "#586e75"})
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#8ad1ca", bold = true})
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#073642" })
    end,
    }, {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function ()
        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "IdentH", { fg = "#586e75" })
            vim.api.nvim_set_hl(0, "ScopeH", { fg = "#93a1a1" })
        end)
        require("ibl").setup({
              indent = {
                char = "│",
                tab_char = "│",
                highlight = "IdentH",
              },
              scope = {highlight = "ScopeH"},
        })
    end
}

}

return {
    'nvim-lualine/lualine.nvim',
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require('lualine').setup({
            options = {
                    theme = 'auto',  
                    icons_enabled = true,
                  },
        })
    end
}

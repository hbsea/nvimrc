
-- plugins/telescope.lua:
return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
          vim.keymap.set('n', '<leader>ft', function() require('telescope.builtin').find_files() end, { desc = "Find Files" })
          -- vim.keymap.set('n', '<leader>fb', function() require('fzf-lua').buffers() end, { desc = "Find Buffers" })
      end
    }

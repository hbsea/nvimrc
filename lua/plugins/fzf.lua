return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  opts = {},
  config = function()
      vim.keymap.set('n', '<leader>ff', function() require('fzf-lua').files() end, { desc = "Find Files" })
      vim.keymap.set('n', '<leader>fb', function() require('fzf-lua').buffers() end, { desc = "Find Buffers" })
  end
}

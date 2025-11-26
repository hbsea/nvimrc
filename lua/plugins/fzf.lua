return {
  "ibhagwan/fzf-lua",
  opts = {},
  config = function()
      vim.keymap.set('n', '<leader>f', function() require('fzf-lua').files() end, { desc = "Find Files" })
      vim.keymap.set('n', '<leader>p', function() require('fzf-lua').buffers() end, { desc = "Find Buffers" })
      vim.keymap.set("n", "<leader>g", function() require("fzf-lua").live_grep() end, { desc = "Live Grep" })
  end
}

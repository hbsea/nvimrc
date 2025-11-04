return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true
    require("nvim-tree").setup({
        filters = {
                dotfiles = true,
            },
        view = {
                -- width = 20,
            },
        update_focused_file = {
            enable = true,
            update_root = false,
          },
        renderer = {
            indent_markers = {
              enable = true,
              inline_arrows = true,
              icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
              },
            },
            icons = {
              show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = true,  -- 如果不需要 git 图标
              },
              glyphs = {
                    git = {
                      deleted = "",
                    }
              }
            },
        },
    })
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            vim.cmd("NvimTreeOpen")
            vim.cmd("wincmd p")
      end,
    })
    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
          vim.cmd("quit")
        end
      end,
    })
    end
}

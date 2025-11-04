vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- Unset 'formatexpr'
    -- vim.bo[args.buf].formatexpr = nil
    -- Unset 'omnifunc'
    -- vim.bo[args.buf].omnifunc = nil
    -- Unmap K
    -- vim.keymap.del('n', 'K', { buffer = args.buf })
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    if client.name == "clangd" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})
vim.diagnostic.config({
  virtual_text = {severity = vim.diagnostic.severity.ERROR,},
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

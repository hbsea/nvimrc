local dapui = require("dapui")
local watch_file = vim.fn.stdpath("data") .. "/dap_watches.json"

-- 保存 watch expressions
local function save_watches()
  local watches = dapui.elements.watches.get()
  local data = {}
  for _, expr in ipairs(watches) do
    table.insert(data, expr.expression)
  end
  local json = vim.fn.json_encode(data)
  vim.fn.writefile({ json }, watch_file)
end

-- 恢复 watch expressions
local function load_watches()
  if vim.fn.filereadable(watch_file) == 0 then
    return
  end
  local content = vim.fn.readfile(watch_file)
  local ok, data = pcall(vim.fn.json_decode, table.concat(content))
  if ok and type(data) == "table" then
    for _, expr in ipairs(data) do
      dapui.elements.watches.add(expr)
    end
  end
end

-- 自动加载 / 保存
vim.api.nvim_create_autocmd("VimEnter", {
  callback = load_watches,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = save_watches,
})


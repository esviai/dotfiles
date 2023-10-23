local map = require 'main.map'

vim.opt_local.autoindent = true
vim.opt_local.smartindent = true

function Insert_xdebug()
  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos) .. 'xdebug_break();' .. line:sub(pos + 1)
  vim.api.nvim_set_current_line(nline)
end

map("n", "<leader>ds", "<cmd>lua Insert_xdebug()<cr>")

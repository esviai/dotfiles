color = "tokyonight"
vim.cmd.colorscheme(color)

vim.api.nvim_set_hl(0, "Normal", { bg = 'none' })      -- Make normal text transparent
vim.api.nvim_set_hl(0, "NormalNC", { bg = 'none' })    -- Make normal text in non-current windows transparent
vim.api.nvim_set_hl(0, "NormalFloat", { bg = 'none' }) -- Make normal text in non-current windows transparent

vim.cmd.lang('en_US.UTF-8')                            -- set utf8 and en_US as standart

local o = vim.o
local api = vim.api

-- tab stuff
o.expandtab = true
o.shiftround = true
o.shiftwidth = 2
o.softtabstop = 2
o.tabstop = 2
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "php",
--   callback = function()
--     vim.opt_local.shiftwidth = 4
--     vim.opt_local.tabstop = 4
--   end
-- })

-- indent
o.autoindent = true
o.smartindent = true

-- disable backup and swap
o.backup = false
o.writebackup = false
o.swapfile = false

-- searching
o.hlsearch = false  -- disable search hightlight
o.incsearch = true
o.ignorecase = true -- case insensitive searc
o.smartcase = true  -- unless capital letters are involved

-- number column
o.number = true
o.relativenumber = true
o.numberwidth = 3

-- sign column
o.signcolumn = 'yes'
-- o.colorcolumn = 100

-- scrolling
o.scrolloff = 7
o.sidescrolloff = 15
o.sidescroll = 7

-- natural split
o.splitbelow = true
o.splitright = true

-- key press wait time
o.timeoutlen = 300
o.ttimeoutlen = 0

o.autoread = true -- auto read when file is changed from outside
o.backspace = 'eol,start,indent'
o.hidden = true
o.lazyredraw = true    -- don't redraw while executing macros
o.termguicolors = true -- enable highlight groups
-- o.wildmenu = true
o.wrap = true

-- highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  pattern = "*",
  group = yankGrp,
})

local befSaveGrp = vim.api.nvim_create_augroup("BeforeSave", { clear = true })
-- delete trailing white space on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
  group = befSaveGrp,
})
-- format on save
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   group = befSaveGrp,
--   callback = function()
--     vim.lsp.buf.format()
--   end,
-- })

-- go to last loc when opening a buffer
api.nvim_create_autocmd("BufReadPost", {
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]]
})

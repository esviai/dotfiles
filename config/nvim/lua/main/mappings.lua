local map = require "main.map"

vim.g.mapleader = ","

map("n", "<leader>w", ":w!<cr>") -- faster saving
map("n", "J", "mzJ`z")           -- fix cursor position when doing "J"
map("", "0", "^")                -- 0 as first non-blank character

-- ignore common typos
map("n", "Q", "<nop>")
map("n", "q:", "<nop>")

-- copy paste experience
map("x", "<leader>p", [["_dP]])         -- replace and keep your pasted selection
map({ "n", "v" }, "<leader>y", [["+y]]) -- copy to clipboard
map("n", "<leader>Y", [["+Y]])          -- copy line to clipboard

-- buffer movements
map("", "<leader>l", vim.cmd.bnext)
map("", "<leader>h", vim.cmd.bprevious)
map("", "<leader>bd", vim.cmd.bd)
map("", "<leader>ba", ":bufdo bd <cr>")

-- window movements
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

-- move selected lines around
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in the middle of the screen when moving the page up and down
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- keep search result in the middle of the screen
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map('', '*', '<Plug>(asterisk-z*)zz')
map('', '#', '<Plug>(asterisk-z#)zz')

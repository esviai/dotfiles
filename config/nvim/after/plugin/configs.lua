-- add default options to key mapping
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  -- vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  vim.keymap.set(mode, lhs, rhs, options)
end

---------------------------------------------------------------------
-- copilot
---------------------------------------------------------------------
-- require("copilot").setup()
-- require("copilot").setup({
--   panel = {
--     keymap = {
--       open = "<leader>c"
--     }
--   }
-- })
-- map("n", "<leader>cc", require("copilot.panel").open)

---------------------------------------------------------------------
-- fugitive
---------------------------------------------------------------------
map("n", "<leader>gs", vim.cmd.Git);

---------------------------------------------------------------------
-- lsp-zero
---------------------------------------------------------------------
local lsp = require('lsp-zero')

lsp.preset('recommended')

-- Configure lua language server for neovim
-- lsp.nvim_workspace()

-- local cmp = require('cmp')
-- local cmp_select = { behavior = cmp.SelectBehavior.Select}
-- local cmp_mappings = lsp.defaults.cmp_mappings({
-- })

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

-- format before save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
lsp.on_attach(function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
end)

lsp.setup()

-- vim.diagnostic.config({
--   virtual_text = true
-- })

---------------------------------------------------------------------
-- nvim-autopairs
---------------------------------------------------------------------
-- add spaces between parentheses
-- https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#add-spaces-between-parentheses
local npairs = require 'nvim-autopairs'
local Rule   = require 'nvim-autopairs.rule'

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
  Rule(' ', ' ')
      :with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({
          brackets[1][1] .. brackets[1][2],
          brackets[2][1] .. brackets[2][2],
          brackets[3][1] .. brackets[3][2],
        }, pair)
      end)
}
for _, bracket in pairs(brackets) do
  npairs.add_rules {
    Rule(bracket[1] .. ' ', ' ' .. bracket[2])
        :with_pair(function() return false end)
        :with_move(function(opts)
          return opts.prev_char:match('.%' .. bracket[2]) ~= nil
        end)
        :use_key(bracket[2])
  }
end

---------------------------------------------------------------------
-- nvim-treesitter
---------------------------------------------------------------------
require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "dockerfile",
    "go",
    "help",
    "javascript",
    "lua",
    "markdown",
    "php",
    "rust",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    -- 	local max_filesize = 100 * 1024 -- 100 KB
    -- 	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    -- 	if ok and stats and stats.size > max_filesize then
    -- 		return true
    -- 	end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

---------------------------------------------------------------------
-- nvim-tree
---------------------------------------------------------------------
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup()

map("n", "<leader>nt", vim.cmd.NvimTreeToggle)

---------------------------------------------------------------------
-- telescope
---------------------------------------------------------------------
require('telescope').setup()

local builtin = require("telescope.builtin")
-- local actions = require("telescope.actions")
map("n", "<leader>f", builtin.find_files)
map("n", "<leader>fg", builtin.git_files)
map("n", "<leader>fc", builtin.git_bcommits)
map("n", "<leader>a", builtin.live_grep)
map("n", "<leader>aw", builtin.grep_string)
map("n", "<leader>r", builtin.command_history)
map("n", ";", function()
  builtin.buffers({
    sort_lastused = true,
    mappings = {
      n = {
        ["d"] = "delete_buffer",
      },
    },
  })
end)

---------------------------------------------------------------------
-- tokyonight
---------------------------------------------------------------------
require("tokyonight").setup({
  style = "night",
})

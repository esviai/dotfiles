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
map({ "n", "v" }, "<leader>gb", ":GBrowse! <cr>");

---------------------------------------------------------------------
-- vim-rhubarb
---------------------------------------------------------------------
vim.cmd([[ command! -nargs=1 Browse silent exec '!open "<args>"' ]])

---------------------------------------------------------------------
-- nvim-ufo
---------------------------------------------------------------------
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`.
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require('ufo').setup()

---------------------------------------------------------------------
-- lsp-zero
---------------------------------------------------------------------
local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  vim.keymap.set('n', 'tr', '<cmd>Telescope lsp_references<cr>', { buffer = true })
  vim.keymap.set('n', 'ti', '<cmd>Telescope lsp_implementations<cr>', { buffer = true })
  vim.keymap.set('n', 'td', '<cmd>Telescope diagnostics<cr>', { buffer = true })

  -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#always-use-the-active-servers
  -- it'll use all active server with no order guaranteed, so it's best to activate if we only have one server per file
  -- it's a synchronous funtion
  lsp.buffer_autoformat()
end)

lsp.set_server_config({
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
    }
  }
})

-- require('lspconfig').phpactor.setup({
--   -- single_file_support = false,
-- })

-- Fix Undefined global 'vim'
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

-- disable log because it gets too big
vim.lsp.set_log_level("off")

lsp.setup()

vim.diagnostic.config({
  virtual_text = false
})

---------------------------------------------------------------------
-- cmp
---------------------------------------------------------------------
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'luasnip' },
  },
  mapping = {
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  },
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
})
-- -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- lsp.on_attach(function(client, bufnr)
--   -- format before save
--   -- I copied this before there's supported autoformat
--   -- if client.supports_method("textDocument/formatting") then
--   --   vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--   --   vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   --     group = augroup,
--   --     buffer = bufnr,
--   --     callback = function()
--   --       vim.lsp.buf.format()
--   --     end,
--   --   })
--   -- end
-- end)

---------------------------------------------------------------------
-- nvim-autopairs
---------------------------------------------------------------------
-- add spaces between parentheses
-- https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#add-spaces-between-parentheses
local npairs   = require 'nvim-autopairs'
local Rule     = require 'nvim-autopairs.rule'

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
    disable = { "php" },

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

-- This is a minimal viable solution that will achieve the auto close functionality.
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd "quit"
    end
  end
})

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

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
-- cmp
---------------------------------------------------------------------
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local ts_utils = require("nvim-treesitter.ts_utils")

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    { name = 'copilot' },
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'luasnip' },
  },
  mapping = {
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({
      select = false,
      -- behavior = cmp.ConfirmBehavior.Replace,
    }),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  },
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
})

local ts_node_func_parens_disabled = {
  -- ecma
  named_imports = true,
  -- rust
  use_declaration = true,
}

local default_handler = cmp_autopairs.filetypes["*"]["("].handler
cmp_autopairs.filetypes["*"]["("].handler = function(char, item, bufnr, rules, commit_character)
  local node_type = ts_utils.get_node_at_cursor():type()
  if ts_node_func_parens_disabled[node_type] then
    if item.data then
      item.data.funcParensDisabled = true
    else
      char = ""
    end
  end
  default_handler(char, item, bufnr, rules, commit_character)
end

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done({
    sh = false,
  })
)

---------------------------------------------------------------------
-- copilot
---------------------------------------------------------------------
require('copilot').setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

---------------------------------------------------------------------
-- lsp-zero
---------------------------------------------------------------------
local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr }
  lsp.default_keymaps({ buffer = bufnr })
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  map('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  -- map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  -- map({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  -- map('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)

  -- I'm letting it be different to show another way to write command
  map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  map("x", "<leader>ca", function() vim.lsp.buf.range_code_action() end, opts)
  map("n", "<leader>cl", function() vim.lsp.codelens.run() end, opts)

  map('n', 'tr', '<cmd>Telescope lsp_references<cr>', { buffer = true })
  map('n', 'ti', '<cmd>Telescope lsp_implementations<cr>', { buffer = true })
  map('n', 'td', '<cmd>Telescope diagnostics<cr>', { buffer = true })

  -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#always-use-the-active-servers
  -- it'll use all active server with no order guaranteed, so it's best to activate if we only have one server per file
  -- it's a synchronous funtion
  lsp.buffer_autoformat()
end)

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

-- Fix Undefined global 'vim'
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

-- automatically add unimported package
lspconfig.gopls.setup {
  settings = {
    gopls = {
      -- will fill the function with parameter placeholders
      usePlaceholders = true,
    },
  },
}

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- disable log because it gets too big
vim.lsp.set_log_level('off')

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})

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
-- nvim-tree
---------------------------------------------------------------------
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require('nvim-tree').setup()

map('n', '<leader>nt', vim.cmd.NvimTreeToggle)

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
-- telescope
---------------------------------------------------------------------
local builtin = require('telescope.builtin')
-- local actions = require('telescope.actions')
map('n', '<leader>f', builtin.find_files)
map('n', '<leader>fg', builtin.git_files)
map('n', '<leader>fc', builtin.git_bcommits)
map('n', '<leader>a', builtin.live_grep)
map('n', '<leader>aw', builtin.grep_string)
map('n', '<leader>r', builtin.command_history)
map('n', ';', function()
  builtin.buffers({
    sort_lastused = true,
    mappings = {
      n = {
        ['d'] = 'delete_buffer',
      },
    },
  })
end)

---------------------------------------------------------------------
-- vim-fugitive
---------------------------------------------------------------------
map('n', '<leader>gs', vim.cmd.Git);
map({ 'n', 'v' }, '<leader>gb', ':GBrowse! <cr>');

---------------------------------------------------------------------
-- vim-rhubarb
---------------------------------------------------------------------
vim.cmd([[ command! -nargs=1 Browse silent exec '!open '<args>'' ]])

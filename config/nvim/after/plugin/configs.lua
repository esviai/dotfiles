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
  -- preselect = 'item',
  preselect = cmp.PreselectMode.None,
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
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

map('n', 'ct', '<cmd>Copilot toggle<cr>', { buffer = true })
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
  map('n', 'tl', '<cmd>Telescope diagnostics<cr>', { buffer = true })

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

-- don't use intelephense as formatter
lspconfig.intelephense.setup {
  settings = {
    intelephense = {
      format = {
        enable = false,
      },
    },
  },
}

require 'lspconfig'.tsserver.setup {}

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
map('n', '<leader>nf', vim.cmd.NvimTreeFindFile)

-- auto close nvim-tree if it's the last window
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd "quit"
    end
  end
})

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
local telescope = require('telescope')
local actions = require('telescope.actions')
local action_layout = require("telescope.actions.layout")
local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions
local lga_actions = require('telescope-live-grep-args.actions')
local lga_shortcuts = require('telescope-live-grep-args.shortcuts')

-- filter grep results with telescope file browser
-- https://github.com/nvim-telescope/telescope.nvim/issues/2201#issuecomment-1284691502
local ts_select_dir_for_grep = function(prompt_bufnr)
  local action_state = require("telescope.actions.state")
  local fb = require("telescope").extensions.file_browser
  -- change the below line to liver_grep_args when used
  -- local live_grep = require("telescope.builtin").live_grep
  local live_grep = require("telescope").extensions.live_grep_args.live_grep_args
  -- local live_grep = require("telescope").extension.live_grep_args.live_grep
  local current_line = action_state.get_current_line()

  fb.file_browser({
    files = false,
    depth = false,
    attach_mappings = function(prompt_bufnr)
      require("telescope.actions").select_default:replace(function()
        local entry_path = action_state.get_selected_entry().Path
        local dir = entry_path:is_dir() and entry_path or entry_path:parent()
        local relative = dir:make_relative(vim.fn.getcwd())
        local absolute = dir:absolute()

        live_grep({
          results_title = relative .. "/",
          cwd = absolute,
          default_text = current_line,
        })
      end)

      return true
    end,
  })
end

telescope.setup({
  defaults = {
    -- wrap_results = true,
    mappings = {
      n = {
        ["<M-p>"] = action_layout.toggle_preview
      },
      i = {
        ["<M-d>"] = actions.delete_buffer + actions.move_to_top,
        ["<M-p>"] = action_layout.toggle_preview,
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
      },
    },
    -- to trim the indentation at the beginning of presented line in the result window
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim" -- add this value
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      case_mode = 'smart_case',
    },
    live_grep_args = {
      mappings = {
        i = {
          ["<C-f>"] = ts_select_dir_for_grep,
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          ["<C-l>"] = lga_actions.quote_prompt({ postfix = " --iglob '!*test*'" }),
        },
        n = {
          ["<C-f>"] = ts_select_dir_for_grep,
          ["<C-l>"] = lga_actions.quote_prompt({ postfix = " --g '!*test*'" }),
        },
      }
    }
  },
})

-- get fzf to load and working with telescope
telescope.load_extension('fzf')
-- get ui-select loaded and working with telescope
telescope.load_extension('ui-select')
telescope.load_extension("file_browser")
telescope.load_extension("live_grep_args")

map('n', ';', function()
  builtin.buffers({
    sort_mru = true,
  })
end)
-- map('n', '<leader>a', builtin.live_grep)
-- map('n', '<leader>a', '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>', { buffer = true })
map('n', '<leader>a', extensions.live_grep_args.live_grep_args)
-- map('n', '<leader>aw', builtin.grep_string)
map('n', '<leader>aw', function()
  lga_shortcuts.grep_word_under_cursor({ quote = false, postfix = "" })
end)
map('n', '<leader>av', lga_shortcuts.grep_visual_selection)
map('n', '<leader>f', builtin.find_files)
map('n', '<leader>fc', builtin.git_bcommits)
map('n', '<leader>fg', builtin.git_files)
map('n', '<leader>fm', builtin.marks)
map('n', '<leader>r', builtin.resume)
map('n', '<leader>rr', builtin.command_history)
map('n', '<leader>tn', builtin.builtin)
map('n', '<leader>fb', '<cmd>Telescope file_browser<cr>', { buffer = true })

---------------------------------------------------------------------
-- vim-fugitive
---------------------------------------------------------------------
map('n', '<leader>gs', vim.cmd.Git);
map({ 'n', 'v' }, '<leader>gb', ':GBrowse! <cr>');

---------------------------------------------------------------------
-- vim-rhubarb
---------------------------------------------------------------------
vim.cmd([[ command! -nargs=1 Browse silent exec '!open '<args>'' ]])

return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {}
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async'
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  'nvim-telescope/telescope-ui-select.nvim',
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').setup({
        extensions = {
          fzf = {
            fuzzy = true,
            case_mode = 'smart_case',
          }
        }
      })

      -- get fzf to load and working with telescope
      require('telescope').load_extension('fzf')
      -- get ui-select loaded and working with telescope
      require('telescope').load_extension('ui-select')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
        autopairs = { enable = true },
        ensure_installed = {
          'dockerfile',
          'go',
          'gomod',
          'javascript',
          'lua',
          'markdown',
          'mermaid',
          'php',
          'vim',
        },
        highlight = {
          enable = true,
          -- Disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },                  -- Required
      { 'hrsh7th/cmp-nvim-lsp' },              -- Required
      { 'hrsh7th/cmp-nvim-lua' },              -- Required
      { 'hrsh7th/cmp-buffer' },                -- Required
      { 'hrsh7th/cmp-path' },                  -- Required
      { 'saadparwaiz1/cmp_luasnip' },
      { 'L3MON4D3/LuaSnip' },                  -- Required
      { 'rafamadriz/friendly-snippets' },      -- Optional
    }
  },
  'wakatime/vim-wakatime',
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true,
        enable_check_bracket_line = false,
        ignored_next_char = "[%w%.]",
      }
    end
  },
}

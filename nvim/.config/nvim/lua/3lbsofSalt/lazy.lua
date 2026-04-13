local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
          terminal = {}, -- Enables the `snacks` provider
        },
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type or field for details
      }

      vim.o.autoread = true -- Required for `opts.events.reload`
    end,
  },
  { "lambdalisue/vim-suda" },
  { 'stevearc/oil.nvim', opts = {}, },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },
  {
    "neanias/everforest-nvim",
    config = function()
      require("everforest").setup()
    end,
  },
  -- nvim-treesitter/playground is archived; :InspectTree (built into nvim 0.9+) replaces it.
  'ThePrimeagen/harpoon',
  'mbbill/undotree',
  'tpope/vim-fugitive',
  { 'neovim/nvim-lspconfig' },
  {
    'williamboman/mason.nvim',
    build = function() pcall(vim.cmd, 'MasonUpdate') end,
  },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  'tpope/vim-surround',
  -- To be used in tandem with "neovim-remote" as per:
  -- https://devpoga.org/blog/2022-07-23_neovim_godot/
  'habamax/vim-godot',
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp"
  },
  'saadparwaiz1/cmp_luasnip',
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      { "<leader>m",
        function() require("which-key").show({ global = false }) end,
        desc = "Jupyter Notebook Commands",
      },
      { "<leader>h",
        function() require("which-key").show({ global = false }) end,
        desc = "Harpoon",
      },
      { "<leader>g",
        function() require("which-key").show({ global = false }) end,
        desc = "Git Commands",
      },
      { "<leader>t",
        function() require("which-key").show({ global = false }) end,
        desc = "Telescope",
      },
      { "<leader>w",
        function() require("which-key").show({ global = false }) end,
        desc = "Pane Management",
      },
    },
  },


  -- Jupyter Notebooks support in nvim
  -- https://github.com/benlubas/molten-nvim/blob/main/docs/Not-So-Quick-Start-Guide.md
  -- Full ipynb notebook setup 
  -- https://github.com/benlubas/molten-nvim/blob/main/docs/Notebook-Setup.md
  -- Wrap in a comment if not set up
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    lazy = false, -- must be eager for remote plugin registration
    cond = function()
      if vim.fn.executable('jupyter') == 0 then
        vim.schedule(function()
          vim.notify("molten-nvim: 'jupyter' not found in PATH, plugin skipped", vim.log.levels.WARN)
        end)
        return false
      end
      return true
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false, -- must be eager to intercept .ipynb on open
    cond = function()
      if vim.fn.executable('jupytext') == 0 then
        vim.schedule(function()
          vim.notify("jupytext.nvim: 'jupytext' not found in PATH, plugin skipped", vim.log.levels.WARN)
        end)
        return false
      end
      return true
    end,
    config = true,
  },
  {
    "quarto-dev/quarto-nvim",
    ft = { 'quarto' },
    event = { 'User MoltenInitPost' },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cond = function()
      if vim.fn.executable('quarto') == 0 then
        vim.schedule(function()
          vim.notify("quarto-nvim: 'quarto' not found in PATH, plugin skipped", vim.log.levels.WARN)
        end)
        return false
      end
      return true
    end,
    config = function()
      require("quarto").setup({
        lspFeatures = {
          enabled = true,
          languages = { "python" },
          chunks = "all",
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          hover = "H",
          definition = "gd",
          rename = "<leader>rn",
          references = "gr",
          format = "<leader>gf",
        },
        codeRunner = {
          enabled = true,
          default_method = "molten",
        },
      })
    end,
  },
  {
    "3rd/image.nvim",
    version = "1.3.0",
    cond = function()
      if vim.fn.executable('ueberzugpp') == 0 then
        vim.schedule(function()
          vim.notify("image.nvim: 'ueberzugpp' not found in PATH, plugin skipped", vim.log.levels.WARN)
        end)
        return false
      end
      return true
    end,
    dependencies = {
      {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- must run before anything else
        opts = {
          rocks = { "magick" },
        },
      },
    },
    config = function()
      require("image").setup({
        backend = "ueberzug",
        integrations = {},
        max_width = 100,
        max_height = 12,
        max_height_window_percentage = math.huge,
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      })
    end,
  }

});

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
  { "lambdalisue/vim-suda" },
  { 'stevearc/oil.nvim', opts = {}, },
  {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.2',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
  },
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup({
        -- Your config here
      })
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
  { "nvim-mini/mini.icons", opts = {} }, -- icons in which-key (glyphs come from ghostty's built-in Nerd Font symbols)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- Keymaps get their labels from each map's `desc`; this only names the prefix groups.
    opts = {
      spec = {
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Harpoon" },
        { "<leader>m", group = "Molten / Jupyter" },
        { "<leader>t", group = "Telescope" },
        { "<leader>v", group = "LSP" },
        { "<leader>w", group = "Windows" },
      },
    },
    keys = {
      { "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer-local keymaps",
      },
    },
  },


  -- Jupyter Notebooks support in nvim
  -- https://github.com/benlubas/molten-nvim/blob/main/docs/Not-So-Quick-Start-Guide.md
  -- Full ipynb notebook setup 
  -- https://github.com/benlubas/molten-nvim/blob/main/docs/Notebook-Setup.md
  -- Wrap in a comment if not set up
  {
    "3rd/image.nvim",
    version = "1.5.1", -- >=1.4.0 needed for the `processor` option
    build = false, -- don't let lazy build the magick luarock from the rockspec; we use the ImageMagick CLI
    config = function()
      require("image").setup({
        backend = "kitty",
        processor = "magick_cli",
        max_width = 100,
        max_height = 12,
        max_height_window_percentage = math.huge,
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      })
    end,
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    -- Options only; keymaps live in after/plugin/molten.lua
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false -- don't pop a float after every run
      vim.g.molten_virt_text_output = true  -- show output as virtual text under the cell
    end,
  },
  {
    -- Opens .ipynb files as markdown (```python fences) so quarto's runner can execute them
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
    opts = {
      style = "markdown",
      output_extension = "md",
      force_ft = "markdown",
    },
  },
  {
    "quarto-dev/quarto-nvim",
    ft = { 'quarto', 'markdown' },
    event = { 'User MoltenInitPost' },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    -- No cond on the quarto CLI: it's only needed for :QuartoPreview, not the cell runner.
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

});

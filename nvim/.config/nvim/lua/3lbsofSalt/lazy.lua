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

-- For molten support
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks51/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks51/share/lua/5.1/?.lua;"

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  install = {
    missing = false
  },
  {
    'stevearc/oil.nvim',
    opts = {},
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-treesitter/nvim-treesitter',
  },
  {
	  "neanias/everforest-nvim",
	  config = function()
		  require("everforest").setup()
	  end,
  },
  'nvim-treesitter/playground',
  'ThePrimeagen/harpoon',
  'mbbill/undotree',
  'tpope/vim-fugitive',
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp"
      }
    }
  },
  'MaxMEllon/vim-jsx-pretty',
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  -- To be used in tandem with "neovim-remote" as per:
  -- https://devpoga.org/blog/2022-07-23_neovim_godot/
  'habamax/vim-godot',
  'tpope/vim-surround',
  -- Great article on using luasnip: https://www.ejmastnak.com/tutorials/vim-latex/luasnip/
  -- Remember it must be used in conjunction with lsp-zero
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp"
  },
  'saadparwaiz1/cmp_luasnip',
  'lervag/vimtex',
  'epwalsh/obsidian.nvim',
  --[[ For Molten Support ]]
  {
    'benlubas/molten-nvim',
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_output_win_max_height = 12
    end,
    dependencies = { '3rd/image.nvim' }
  },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    "3rd/image.nvim",
    opts = {
      backend = "ueberzug", -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
  {
    "GCBallesteros/jupytext.nvim",
    config = true
  }
})

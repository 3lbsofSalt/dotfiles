vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use({
	  "neanias/everforest-nvim",
	  -- Optional; default configuration will be used if setup isn't called.
	  config = function()
		  require("everforest").setup()
	  end,
  })

end)

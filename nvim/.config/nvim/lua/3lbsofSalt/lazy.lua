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
        tag = '0.1.4',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'nvim-treesitter/nvim-treesitter', },
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
        dependencies = {
            {
                "GCBallesteros/jupytext.nvim",
                config = true,
                -- Depending on your nvim distro or config you may need to make the loading not lazy
                -- lazy=false,
            },
            {
                "quarto-dev/quarto-nvim",
                dependencies = {
                    "jmbuhr/otter.nvim",
                    "nvim-treesitter/nvim-treesitter",
                },
                config = function() 
                    require("quarto").setup({
                        debug = true,
                        lspFeatures = {
                            -- NOTE: put whatever languages you want here:
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
                            -- NOTE: setup your own keymaps:
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
                end
            },
            {
                "3rd/image.nvim",
                version = "1.3.0",
                dependencies = {
                    {
                        "vhyrro/luarocks.nvim",
                        priority = 1001, -- this plugin needs to run before anything else
                        opts = {
                            rocks = { "magick" },
                        },
                    },
                },
                config = function()
                    require("image").setup({
                        backend = "kitty",
                        integrations = {}, -- do whatever you want with image.nvim's integrations
                        max_width = 100, -- tweak to preference
                        max_height = 12, -- ^
                        max_height_window_percentage = math.huge, -- this is necessary for a good experience
                        max_width_window_percentage = math.huge,
                        window_overlap_clear_enabled = true,
                        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
                    })
                end

            }
        }
    }
});

require("obsidian").setup({
  workspaces = {
    {
      name = 'brain',
      path = '~/brain'
    }

  },

  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
  },
});

vim.keymap.set("n", "<leader>os", ":ObsidianQuickSwitch<CR>");
vim.keymap.set("n", "<leader>oo", ":ObsidianOpen<CR>");

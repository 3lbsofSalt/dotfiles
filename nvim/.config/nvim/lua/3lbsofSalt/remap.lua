vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("n", "<leader>wv", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>ws", vim.cmd.split)
vim.keymap.set("n", "<leader>wh", function() vim.cmd([[ wincmd h ]]) end)
vim.keymap.set("n", "<leader>wl", function() vim.cmd([[ wincmd l ]]) end)
vim.keymap.set("n", "<leader>wj", function() vim.cmd([[ wincmd j ]]) end)
vim.keymap.set("n", "<leader>wk", function() vim.cmd([[ wincmd k ]]) end)

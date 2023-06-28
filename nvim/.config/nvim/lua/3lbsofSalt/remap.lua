vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("n", "k", "gk");
vim.keymap.set("n", "gk", "k");
vim.keymap.set("n", "j", "gj");
vim.keymap.set("n", "gj", "j");

vim.keymap.set("n", "<leader>wv", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>ws", vim.cmd.split)
vim.keymap.set("n", "<leader>wh", function() vim.cmd([[ wincmd h ]]) end)
vim.keymap.set("n", "<leader>wl", function() vim.cmd([[ wincmd l ]]) end)
vim.keymap.set("n", "<leader>wj", function() vim.cmd([[ wincmd j ]]) end)
vim.keymap.set("n", "<leader>wk", function() vim.cmd([[ wincmd k ]]) end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") DOESN'T WORK YET!!! LEARN TMUX

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

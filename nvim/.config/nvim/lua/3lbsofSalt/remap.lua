vim.keymap.set("n", "<leader>e", ":Oil<CR>")

vim.keymap.set("n", "k", "gk");
vim.keymap.set("n", "gk", "k");
vim.keymap.set("n", "j", "gj");
vim.keymap.set("n", "gj", "j");

vim.keymap.set("n", "<leader>wv", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>ws", vim.cmd.split)
vim.keymap.set("n", "<leader>wh", function() vim.cmd([[ wincmd h ]]) end)
vim.keymap.set("n", "<leader>wH", function() vim.cmd([[ wincmd H ]]) end)
vim.keymap.set("n", "<leader>wl", function() vim.cmd([[ wincmd l ]]) end)
vim.keymap.set("n", "<leader>wL", function() vim.cmd([[ wincmd L ]]) end)
vim.keymap.set("n", "<leader>wj", function() vim.cmd([[ wincmd j ]]) end)
vim.keymap.set("n", "<leader>wJ", function() vim.cmd([[ wincmd J ]]) end)
vim.keymap.set("n", "<leader>wk", function() vim.cmd([[ wincmd k ]]) end)
vim.keymap.set("n", "<leader>wK", function() vim.cmd([[ wincmd K ]]) end)
vim.keymap.set("n", "<leader>w=", function() vim.cmd([[ wincmd = ]]) end)

-- Allows you to move selected lines around in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep your cursor in the same place after a line join
vim.keymap.set("n", "J", "mzJ`z")

-- Center Screen when scrolling with <C-d> and <C-u>
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Copy/paste using system register
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Deletion into the system register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")


-- Setup a find and replace(substitute) with the word underneath the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Exit Terminal Mode
vim.keymap.set("t", "<leader>q", [[<C-\><C-n>]])

vim.api.nvim_create_user_command('W', function() vim.cmd(":SudaWrite") end, {});

local map = vim.keymap.set

map("n", "<leader>e", ":Oil<CR>", { desc = "File explorer (Oil)" })

-- Move by visual (wrapped) lines; g-prefixed versions move by real lines
map("n", "k", "gk");
map("n", "gk", "k");
map("n", "j", "gj");
map("n", "gj", "j");

-- Windows
map("n", "<leader>wv", vim.cmd.vsplit, { desc = "Split vertical" })
map("n", "<leader>ws", vim.cmd.split, { desc = "Split horizontal" })
map("n", "<leader>wh", function() vim.cmd([[ wincmd h ]]) end, { desc = "Focus left" })
map("n", "<leader>wH", function() vim.cmd([[ wincmd H ]]) end, { desc = "Move window far left" })
map("n", "<leader>wl", function() vim.cmd([[ wincmd l ]]) end, { desc = "Focus right" })
map("n", "<leader>wL", function() vim.cmd([[ wincmd L ]]) end, { desc = "Move window far right" })
map("n", "<leader>wj", function() vim.cmd([[ wincmd j ]]) end, { desc = "Focus down" })
map("n", "<leader>wJ", function() vim.cmd([[ wincmd J ]]) end, { desc = "Move window to bottom" })
map("n", "<leader>wk", function() vim.cmd([[ wincmd k ]]) end, { desc = "Focus up" })
map("n", "<leader>wK", function() vim.cmd([[ wincmd K ]]) end, { desc = "Move window to top" })
map("n", "<leader>w=", function() vim.cmd([[ wincmd = ]]) end, { desc = "Equalize sizes" })

-- Allows you to move selected lines around in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep your cursor in the same place after a line join
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- Center Screen when scrolling with <C-d> and <C-u>
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Copy/paste using system register
map("x", "<leader>p", "\"_dP", { desc = "Paste over (keep register)" })
map("n", "<leader>y", "\"+y", { desc = "Yank to system clipboard" })
map("v", "<leader>y", "\"+y", { desc = "Yank to system clipboard" })
map("n", "<leader>Y", "\"+Y", { desc = "Yank line to system clipboard" })

-- Delete without clobbering any register
map("n", "<leader>d", "\"_d", { desc = "Delete (no register)" })
map("v", "<leader>d", "\"_d", { desc = "Delete (no register)" })

-- Setup a find and replace(substitute) with the word underneath the cursor
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word under cursor" })

-- Make the current file executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "chmod +x file" })

-- Exit Terminal Mode
map("t", "<leader>q", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

vim.api.nvim_create_user_command('W', function() vim.cmd(":SudaWrite") end, {});

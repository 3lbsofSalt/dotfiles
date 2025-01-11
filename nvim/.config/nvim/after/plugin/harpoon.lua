local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Add File to Harpoon"})
vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu, { desc = "Show Harpooned Files"})

vim.keymap.set("n", "<leader>hn", ui.nav_next, { desc = "Next Harpooned File"})
vim.keymap.set("n", "<leader>hp", ui.nav_prev, { desc = "Previous Harpooned File"})

vim.keymap.set("n", "<leader>hq", function() ui.nav_file(1) end, { desc = "Goto File 1"})
vim.keymap.set("n", "<leader>hw", function() ui.nav_file(2) end, { desc = "Goto File 2"})
vim.keymap.set("n", "<leader>hf", function() ui.nav_file(3) end, { desc = "Goto File 3"})
vim.keymap.set("n", "<leader>hp", function() ui.nav_file(4) end, { desc = "Goto File 3"})

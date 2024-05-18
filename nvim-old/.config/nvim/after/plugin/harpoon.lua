local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>hn", ui.nav_next)
vim.keymap.set("n", "<leader>hp", ui.nav_prev)

vim.keymap.set("n", "<leader>hq", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>hw", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>hf", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>hp", function() ui.nav_file(4) end)

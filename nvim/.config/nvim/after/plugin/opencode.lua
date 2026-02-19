vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
vim.keymap.set({ "n", "x" }, "<leader>ox", function() require("opencode").select() end, { desc = "Execute opencode action…" })
vim.keymap.set({ "n", "t" }, "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "<leader>or", function() return require("opencode").operator("@this ") end, { desc = "Add range to opencode", expr = true })
vim.keymap.set("n", "<leader>ol", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

vim.keymap.set("n", "<leader>oj", function() require("opencode").command("session.half.page.up") end, { desc = "Scroll opencode up" })
vim.keymap.set("n", "<leader>ok", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

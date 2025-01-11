vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })
vim.keymap.set("n", "<leader>ga", function() 
  vim.cmd [[ :Git add . ]] 
  print("Added Files")
end, { desc = "Add Files in Project"});
vim.keymap.set("n", "<leader>gc", function() vim.cmd [[ :Git commit ]] end, { desc = "Commit Changes"});
vim.keymap.set("n", "<leader>gp", function() vim.cmd [[ :Git push ]] end, { desc = "Push Changes to Remote"});
vim.keymap.set("n", "<leader>gd", function() vim.cmd [[ :Git pull ]] end, { desc = "Pull Changes from Remote"}); -- pull (down)

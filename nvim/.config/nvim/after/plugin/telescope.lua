local builtin = require('telescope.builtin')
-- pf - Project find
vim.keymap.set('n', '<leader>tf', builtin.find_files, { desc = "Find files without respect to gitignore"})

-- if the current working directory is a git repo then search
-- git defined files, otherwise search all to prevent error
if vim.fn.isdirectory('.git') ~= 0 then
  vim.keymap.set('n', '<leader><leader>', builtin.git_files, { desc="Fuzzy Find Files "})
else
  vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc="Fuzzy Find Files"})
end

vim.keymap.set('n', '<leader>tg', builtin.git_files, { desc="Fuzy Find Files w/out gitignored Files"})
vim.keymap.set('n', '<leader>tS', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, { desc = "Grep and Search Remaining Files"})
vim.keymap.set('n', '<leader>ts', builtin.live_grep, { desc="Live Grep"});

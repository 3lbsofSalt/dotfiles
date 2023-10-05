local builtin = require('telescope.builtin')
-- pf - Project find
vim.keymap.set('n', '<leader>tf', builtin.find_files, {})

-- if the current working directory is a git repo then search
-- git defined files, otherwise search all to prevent error
if vim.fn.isdirectory('.git') ~= 0 then
  vim.keymap.set('n', '<leader><leader>', builtin.git_files, {})
else
  vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
end

vim.keymap.set('n', '<leader>tg', builtin.git_files, {})
vim.keymap.set('n', '<leader>tS', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>ts', builtin.live_grep);

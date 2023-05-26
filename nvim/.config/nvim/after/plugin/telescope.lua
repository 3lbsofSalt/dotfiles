local builtin = require('telescope.builtin')
-- pf - Project find
vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
vim.keymap.set('n', '<leader><leader>', builtin.git_files, {})
vim.keymap.set('n', '<leader>tg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ts', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

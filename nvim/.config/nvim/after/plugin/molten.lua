vim.g.molten_image_provider = "image.nvim"
-- vim.g.molten_output_win_max_height = 20
vim.g.molten_virt_text_output = true
vim.g.molten_virt_lines_off_by_1 = true
vim.g.molten_auto_open_output = false
-- vim.g.molten_wrap_output = true

vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = false })
vim.keymap.set("n", "<leader>me", ":MoltenEvaluateOperator<CR>", { desc = "Evaluate Operator", silent = true })
vim.keymap.set("n", "<leader>mo", ":noautocmd MoltenEnterOutput<CR>", { desc = "Open Output Window", silent = true })

vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>", { desc = "Close Output Window", silent = true })
vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "Delete Cell", silent = true })
vim.keymap.set("n", "<leader>ms", ":MoltenImagePopup<CR>", { desc = "Open Image in Cell Output"})

-- if you work with html outputs:
vim.keymap.set("n", "<leader>mx", ":MoltenOpenInBrowser<CR>", { desc = "Open Output in Browser", silent = true })

require("jupytext").setup({
    style = "markdown",
    output_extension = "md",
    force_ft = "markdown"
})


vim.api.nvim_create_autocmd("User", {
    pattern = "MoltenInitPost",
    callback = function()
        require"otter".activate();
        local runner = require("quarto.runner")

        vim.keymap.set("n", "<leader>mr", runner.run_cell,  { desc = "Run Cell", silent = true })
        vim.keymap.set("n", "<leader>ma", runner.run_all,   { desc = "Run All Cells", silent = true })
        vim.keymap.set("n", "<leader>ml", runner.run_line,  { desc = "Run Line", silent = true })
        vim.keymap.set("v", "<leader>mr",  runner.run_range, { desc = "Run Visual Range", silent = true })

        vim.keymap.set("n", "<leader>mR", function()
            runner.run_all(true)
        end, { desc = "run all cells of all languages", silent = true })
    end
})

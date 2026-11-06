-- Molten (Jupyter kernels in nvim) keymaps. Options live in the molten spec in lua/3lbsofSalt/lazy.lua.
--
-- Two workflows:
--   * .py files with `# %%` cell markers (primary): cells are run directly through molten.
--   * .ipynb notebooks: jupytext opens them as markdown with ```python fences, and quarto's
--     runner (via otter) runs those fences. <leader>mc / <leader>ma switch to the quarto runner
--     in those buffers after :MoltenInit.

-- Molten is a Python remote plugin, so there's no lua module to probe; check the command instead.
if vim.fn.exists(":MoltenInit") == 0 then return end

local map = vim.keymap.set
local CELL = "^# %%"

local function is_blank(s, e)
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, s - 1, e, false)) do
    if line:match("%S") then return false end
  end
  return true
end

local function run_range(s, e)
  if e >= s and not is_blank(s, e) then vim.fn.MoltenEvaluateRange(s, e) end
end

-- Run the `# %%` cell under the cursor
local function run_cell()
  local s = vim.fn.search(CELL, "bcnW") + 1
  local e = vim.fn.search(CELL, "nW")
  e = (e == 0) and vim.fn.line("$") or e - 1
  run_range(s, e)
end

-- Add a new cell below the current cell, or if no cell is found, at the end of the file
local function add_new_cell_below()
  local next = vim.fn.search(CELL, "nW")
  local row = (next == 0) and vim.api.nvim_buf_line_count(0) or next - 1
  vim.api.nvim_buf_set_lines(0, row, row, false, { "# %%", "" })
  vim.api.nvim_win_set_cursor(0, { row + 2, 0 })
end

-- Run every `# %%` cell top to bottom (including any code above the first marker)
local function run_all_cells()
  local s = 1
  for lnum, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    if vim.fn.match(line, CELL) == 0 then
      run_range(s, lnum - 1)
      s = lnum + 1
    end
  end
  run_range(s, vim.fn.line("$"))
end

-- Kernel
map("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Init kernel" })

-- Running code
map("n", "<leader>mc", run_cell, { desc = "Run # %% cell" })
map("n", "<leader>ma", run_all_cells, { desc = "Run all # %% cells" })
map("n", "<leader>ml", ":MoltenEvaluateLine<CR>", { desc = "Run line", silent = true })
map("n", "<leader>me", ":MoltenEvaluateOperator<CR>", { desc = "Run operator (e.g. <leader>meip)", silent = true })
map("v", "<leader>mr", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Run selection", silent = true })
map("n", "<leader>mr", ":MoltenReevaluateCell<CR>", { desc = "Re-run molten cell", silent = true })

-- Output
map("n", "<leader>mo", ":noautocmd MoltenEnterOutput<CR>", { desc = "Enter output window", silent = true })
map("n", "<leader>mh", ":MoltenHideOutput<CR>", { desc = "Hide output window", silent = true })
map("n", "<leader>mn", add_new_cell_below, { desc = "Add new molten cell below cursor", silent = true })
map("n", "<leader>md", ":MoltenDelete<CR>", { desc = "Delete molten cell", silent = true })
map("n", "<leader>ms", ":MoltenImagePopup<CR>", { desc = "Show output image", silent = true })
map("n", "<leader>mx", ":MoltenOpenInBrowser<CR>", { desc = "Open HTML output in browser", silent = true })

-- Notebooks (.ipynb opened as markdown by jupytext): use quarto's runner for ```python fences.
-- lazy.lua loads quarto on this same MoltenInitPost event.
vim.api.nvim_create_autocmd("User", {
  pattern = "MoltenInitPost",
  callback = function()
    if vim.bo.filetype ~= "markdown" and vim.bo.filetype ~= "quarto" then return end
    local ok, runner = pcall(require, "quarto.runner")
    if not ok then
      vim.notify("quarto-nvim not loaded; notebook cell runner unavailable", vim.log.levels.WARN)
      return
    end
    require("otter").activate()

    local opts = function(desc) return { buffer = true, silent = true, desc = desc } end
    map("n", "<leader>mc", runner.run_cell, opts("Run notebook cell"))
    map("n", "<leader>ma", runner.run_all, opts("Run all notebook cells"))
    map("n", "<leader>ml", runner.run_line, opts("Run line"))
    map("v", "<leader>mr", runner.run_range, opts("Run selection"))
  end,
})

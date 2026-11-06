local ok, ts = pcall(require, 'nvim-treesitter')
if not ok then return end

local parsers = {
  -- Core
  "lua", "vim", "vimdoc", "query",
  -- Languages in use (mirrors LSP setup)
  "c", "rust", "go",
  "javascript", "typescript", "tsx", "vue",
  "python",
  "java",
  "haskell", "ocaml",
  -- Markup / config (generally useful everywhere)
  "markdown", "markdown_inline",
  "css",
  "json", "yaml", "toml",
  "bash",
}

-- Ensure parsers are installed (no-op if already present)
ts.install(parsers)

-- Enable treesitter highlighting for all filetypes that have a working parser.
-- html is excluded: its parser produces noisy/incorrect highlights.
vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    if ev.match == 'html' then return end
    pcall(vim.treesitter.start)
  end,
})

-- Treesitter-based indentation (experimental).
-- python: unreliable indentation queries.
-- vue: indent queries are nearly empty and snap the cursor to column 0 in script blocks.
local no_ts_indent = { python = true, vue = true, html = true }
vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    if no_ts_indent[ev.match] then return end
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

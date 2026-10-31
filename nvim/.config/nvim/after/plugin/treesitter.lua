-- nvim-treesitter is on the `main` branch, which dropped the old configs.setup{ensure_installed, highlight, indent}
-- API. Now it only installs parsers; highlighting/indent are started per buffer with Neovim's built-in treesitter.
-- Requires the `tree-sitter` CLI.
local ok, ts = pcall(require, 'nvim-treesitter')
if not ok then return end

-- Installs anything missing (async; no-op for parsers already installed)
ts.install({
  -- Core
  "lua", "vim", "vimdoc", "query",
  -- Languages in use (mirrors LSP setup)
  "c", "rust", "go",
  "javascript", "typescript", "tsx", "vue",
  "python",
  "java",
  "haskell", "ocaml",
  "latex",
  -- Markup / config. markdown + markdown_inline are what highlight ```python blocks in notebooks
  "markdown", "markdown_inline",
  "css",
  "json", "yaml", "toml",
  "bash",
})

local skip = { html = true }        -- never use treesitter for html
local no_ts_indent = { python = true } -- treesitter indent is unreliable for python; use built-in

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("3lbsofSalt_treesitter", { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang or skip[lang] then return end

    -- Like the old auto_install: fetch a parser the first time a supported filetype is opened
    if not vim.treesitter.language.add(lang) then
      if vim.tbl_contains(ts.get_available(), lang) then ts.install({ lang }) end
      return
    end

    vim.treesitter.start(args.buf, lang)
    if not no_ts_indent[lang] then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

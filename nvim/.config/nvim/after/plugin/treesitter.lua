local ok, configs = pcall(require, 'nvim-treesitter.config')
if not ok then return end

configs.setup {
  ensure_installed = {
    -- Core
    "lua", "vim", "vimdoc", "query",
    -- Languages in use (mirrors LSP setup)
    "c", "rust", "go",
    "javascript", "typescript", "tsx", "vue",
    "python",
    "java",
    "haskell", "ocaml",
    "latex",
    -- Markup / config (generally useful everywhere)
    "markdown", "markdown_inline", -- both required; markdown_inline handles inline spans
    "html", "css",
    "json", "yaml", "toml",
    "bash",
  },

  sync_install = false,

  -- auto_install downloads parsers on first open for any language not listed
  -- above. Requires the tree-sitter CLI to be installed locally.
  auto_install = true,

  -- Prevent html from being auto-installed AND disable its highlight so that
  -- treesitter doesn't apply to html even if the parser is already on disk.
  ignore_install = { "html" },

  highlight = {
    enable = true,
    disable = { "html" },

    -- Run regex highlighting alongside treesitter for markdown so that
    -- conceal / syntax-based plugins (e.g. vim-markdown) still work.
    additional_vim_regex_highlighting = { "markdown" },
  },

  indent = {
    enable = true,
    -- treesitter indent is unreliable for python; fall back to built-in
    disable = { "python" },
  },
}

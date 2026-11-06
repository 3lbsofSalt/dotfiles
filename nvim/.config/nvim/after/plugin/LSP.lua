require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'ltex',
        'pyright',
        'rust_analyzer',
        'vue_ls',
        'vtsls',
    },
    -- Disable automatic enabling so we control exactly which servers start below.
    automatic_enable = false,
})

-- Keybindings applied whenever any LSP attaches
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local function opts(desc) return { buffer = event.buf, remap = false, desc = desc } end
        -- [d / ]d (prev/next diagnostic) are Neovim built-in defaults
        vim.keymap.set('n', 'gd',          vim.lsp.buf.definition,       opts("Go to definition"))
        vim.keymap.set('n', 'K',           vim.lsp.buf.hover,            opts("Hover docs"))
        vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts("Workspace symbols"))
        vim.keymap.set('n', '<leader>vd',  vim.diagnostic.open_float,    opts("Line diagnostics"))
        vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action,      opts("Code action"))
        vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references,       opts("References"))
        vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename,           opts("Rename symbol"))
        vim.keymap.set('n', '<C-h>',       vim.lsp.buf.signature_help,   opts("Signature help"))
    end,
})

-- Server-specific configs (must be called before vim.lsp.enable)

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'require' },
      },
    },
  },
})

-- If working in a complex C package with many compile flags, run `bear -- {compile command}`
-- to generate compile_commands.json so clangd understands the include graph.
vim.lsp.config('clangd', {
  filetypes = { 'c' },
})

vim.lsp.config('ltex', {
  settings = {
    ltex = {
      completionEnabled = true,
    },
  },
})

-- cssls requires snippet support to be advertised in capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config('cssls', {
  capabilities = capabilities,
})

vim.lsp.config('hls', {
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
})

vim.lsp.config('pyright', {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = 'basic',
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
            },
        },
      },
    },
  },
})

-- Vue / TypeScript setup
-- https://github.com/vuejs/language-tools/wiki/Neovim
local vue_language_server_path = vim.fn.expand('$MASON/packages')
.. '/vue-language-server/node_modules/@vue/language-server'
local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = { vue_plugin },
      },
    },
  },
  filetypes = tsserver_filetypes,
})

function _G.VueIndent()
  local lnum = vim.v.lnum
  local section = 'template'

  for i = lnum - 1, 1, -1 do
    local l = vim.fn.getline(i)
    if l:match('^%s*<script') then section = 'script'; break
    elseif l:match('^%s*</script') then break
    elseif l:match('^%s*<style') then section = 'style'; break
    elseif l:match('^%s*</style') then break
    elseif l:match('^%s*<template') then break
    elseif l:match('^%s*</template') then break
    end
  end

  if section == 'script' then
    -- Ships with Neovim: $VIMRUNTIME/indent/javascript.vim
    if vim.fn.exists('*GetJavascriptIndent') == 1 then
      return vim.fn.GetJavascriptIndent()
    end
    return -1
  elseif section == 'style' then
    if vim.fn.exists('*GetCSSIndent') == 1 then
      return vim.fn.GetCSSIndent()
    end
    return -1
  else
    return vim.fn.HtmlIndent()
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'vue',
  callback = function()
    -- Load the indent functions from Neovim runtime
    vim.cmd('runtime! indent/javascript.vim')
    vim.cmd('runtime! indent/css.vim')
    vim.bo.indentexpr = 'v:lua.VueIndent()'
  end,
})

-- vue_ls: on_init is provided by nvim-lspconfig's lsp/vue_ls.lua (includes retry logic
-- for waiting on vtsls to attach). No override needed.

-- Enable all servers. vim.lsp.enable registers a filetype autocmd that starts
-- the server; it is safe to list servers that aren't installed (they simply
-- won't launch). gdscript connects to the Godot editor socket rather than
-- a mason-managed binary, so it must always be listed explicitly here.
vim.lsp.enable({
    'clangd',
    'lua_ls',
    'ltex',
    'rust_analyzer',
    'gdscript',
    'jdtls',
    'html',
    'cssls',
    'pyright',
    'gopls',
    'ocamllsp',
    'hls',
    'postgres_lsp',
    'buf_ls',
    'vtsls',
    'vue_ls',
})

-- Completion
local cmp = require('cmp')
local luasnip = require('luasnip')

require('luasnip.loaders.from_lua').lazy_load({ paths = '~/.config/nvim/LuaSnip/' })

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>']     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-n>']     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-CR>']    = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then luasnip.jump(1) else fallback() end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end
    end, { 'i', 's' }),
  }),
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    format = function(entry, item)
      item.menu = ({ nvim_lsp = '[LSP]', luasnip = '[Snip]' })[entry.source.name]
      return item
    end,
  },
})

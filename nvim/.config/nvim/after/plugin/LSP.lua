local lsp = require('lsp-zero').preset({})
local cmp_action = require('lsp-zero').cmp_action()

lsp.ensure_installed({
  'vuels',
  'eslint',
  'clangd',
  'tsserver',
  'pylsp',
  'ltex'
})

local cmp = require('cmp')
local cmp_format = require('lsp-zero').cmp_format()
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-CR>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<Tab>'] = cmp_action.luasnip_supertab(),
  ['<S-Tab>'] = cmp_action.luasnip_shift_supertab()
});

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  formatting = cmp_format
});

require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/LuaSnip/" });

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'}
  },
  mapping = cmp_mappings,
});

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

  -- To be used in tandem with "neovim-remote" as per:
  -- https://devpoga.org/blog/2022-07-23_neovim_godot/
require('lspconfig').lua_ls.setup{}
-- If developing javascript remember to install typescript and typescript-language-server npm packages globally
require('lspconfig').tsserver.setup{}
-- If working in a complex c package with many compile flags, run `bear -- {compile command here}`
-- This will generate a compile_commands.json so that the editor will corectly understand how to link up all of the files
require('lspconfig').clangd.setup{}

require('lspconfig').gdscript.setup{}
require'lspconfig'.ltex.setup{
  settings = {
    ltex = {
      completionEnabled = true
    }
  }
}

require'lspconfig'.jdtls.setup{}

lsp.setup()

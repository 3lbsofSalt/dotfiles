local lsp = require('lsp-zero').preset({})
local cmp_action = require('lsp-zero').cmp_action()

lsp.ensure_installed({
    'eslint',
    'clangd',
    'ts_ls',
    'ltex'
})

local cmp = require('cmp')
local cmp_format = require('lsp-zero').cmp_format()
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp_action.luasnip_jump_forward(),
    ['<S-Tab>'] = cmp_action.luasnip_jump_backward()
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

lsp.on_attach(function(_, bufnr)
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

require('lspconfig').lua_ls.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim",
                    "require"
                }
            }
        }
    }

};
-- If working in a complex c package with many compile flags, run `bear -- {compile command here}`
-- This will generate a compile_commands.json so that the editor will corectly understand how to link up all of the files
require('lspconfig').clangd.setup{};

require('lspconfig').gdscript.setup{};
require'lspconfig'.ltex.setup{
    settings = {
        ltex = {
            completionEnabled = true
        }
    }
};

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
    capabilities = capabilities,
}

require'lspconfig'.jdtls.setup{}
require('lspconfig').html.setup{};
require('lspconfig').cssls.setup{};

require'lspconfig'.pylsp.setup{
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = {'E501', 'E231', 'E302', 'W293', 'E275', 'E303', 'W291', 'E261', 'E305'}, -- Rules at https://pycodestyle.pycqa.org/en/latest/intro.html#configuration
                    maxLineLength = 100
                }
            }
        }
    }
}

require'lspconfig'.volar.setup {
    -- add filetypes for typescript, javascript and vue
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    init_options = {
      vue = {
        -- disable hybrid mode
        hybridMode = false,
      },
    },
  }

--require'lspconfig'.ts_ls.setup{}

lsp.setup()

--[[
local tsserver_attached = false;
local volar_attached = false;

require'lspconfig'.volar.setup{
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
  init_options = {
    typescript = {
      -- tsdk = '/path/to/.npm/lib/node_modules/typescript/lib'
      tsdk = os.getenv('HOME') .. '/.global_node_modules/lib/node_modules/typescript/lib'
      -- Alternative location if installed as root:
      -- tsdk = '/usr/local/lib/node_modules/typescript/lib'
    }
  }
}
--]]

-- Prevents tsserver from being attached if volar is attached
--[[
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id);
    if(client.name == 'volar') then
      volar_attached = true;
      if(tsserver_attached == true) then
        for _, client in ipairs(vim.lsp.get_active_clients()) do
          if client.name == 'tsserver' then
            tsserver_attached = false;
            client.stop();
          end
        end
      end
    end
    if(client.name == 'tsserver') then
      if(volar_attached == true) then
        client.stop();
      else
        tsserver_attached = true;
      end
    end
  end
});
]]

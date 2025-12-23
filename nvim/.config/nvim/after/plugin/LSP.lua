local lsp = require('lsp-zero').preset({})
local cmp_action = require('lsp-zero').cmp_action()

lsp.ensure_installed({
    'clangd',
    'ltex',
    'rust_analyzer',
    'vue_ls',
    'vtsls'
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
    expand = function(args) require'luasnip'.lsp_expand(args.body) end,
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
require('lspconfig').clangd.setup{
    filetypes = {"c"}
};
require'lspconfig'.rust_analyzer.setup{}

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
require'lspconfig'.pyright.setup{};
require'lspconfig'.gopls.setup{};

-- This Vue_Ls Config Was Grabbed from Here: https://github.com/vuejs/language-tools/wiki/Neovim
local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
print(vue_language_server_path)
local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}
local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = tsserver_filetypes,
}

local ts_ls_config = {
  init_options = {
    plugins = {
      vue_plugin,
    },
  },
  filetypes = tsserver_filetypes,
}

-- If you are on most recent `nvim-lspconfig`
local vue_ls_coonfig = {}
-- If you are not on most recent `nvim-lspconfig` or you want to override
local vue_ls_config = {
  on_init = function(client)
    client.handlers['tsserver/request'] = function(_, result, context)
      local ts_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })
      local vtsls_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
      local clients = {}

      vim.list_extend(clients, ts_clients)
      vim.list_extend(clients, vtsls_clients)

      if #clients == 0 then
        vim.notify('Could not find `vtsls` or `ts_ls` lsp client, `vue_ls` would not work without it.', vim.log.levels.ERROR)
        return
      end
      local ts_client = clients[1]

      local param = unpack(result)
      local id, command, payload = unpack(param)
      ts_client:exec_cmd({
        title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
        command = 'typescript.tsserverRequest',
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, r)
          local response = r and r.body
          -- TODO: handle error or response nil here, e.g. logging
          -- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
          local response_data = { { id, response } }

          ---@diagnostic disable-next-line: param-type-mismatch
          client:notify('tsserver/response', response_data)
        end)
    end
  end,
}
-- nvim 0.11 or above
vim.lsp.config('vtsls', vtsls_config)
vim.lsp.config('vue_ls', vue_ls_config)
vim.lsp.config('ts_ls', ts_ls_config)
vim.lsp.enable({'vtsls', 'vue_ls'}) -- If using `ts_ls` replace `vtsls` to `ts_ls`
-- End Vue Ls Setup

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

require'lspconfig'.ocamllsp.setup{}
require('lspconfig')['hls'].setup{
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
}

require'lspconfig'.buf_ls.setup{}
vim.lsp.enable('postgres_lsp')
lsp.setup()

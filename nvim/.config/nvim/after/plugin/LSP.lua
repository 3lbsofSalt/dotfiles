require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'ltex',
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
        local opts = { buffer = event.buf, remap = false }
        vim.keymap.set('n', 'gd',          vim.lsp.buf.definition,      opts)
        vim.keymap.set('n', 'K',           vim.lsp.buf.hover,           opts)
        vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set('n', '<leader>vd',  vim.diagnostic.open_float,   opts)
        vim.keymap.set('n', '[d',          vim.diagnostic.goto_next,    opts)
        vim.keymap.set('n', ']d',          vim.diagnostic.goto_prev,    opts)
        vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action,     opts)
        vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references,      opts)
        vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename,          opts)
        vim.keymap.set('n', '<C-h>',       vim.lsp.buf.signature_help,  opts)
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

vim.lsp.config('pylsp', {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    -- Rules: https://pycodestyle.pycqa.org/en/latest/intro.html#configuration
                    ignore = { 'E501', 'E231', 'E302', 'W293', 'E275', 'E303', 'W291', 'E261', 'E305' },
                    maxLineLength = 100,
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

vim.lsp.config('vue_ls', {
    on_init = function(client)
        client.handlers['tsserver/request'] = function(_, result, context)
            local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
            if #clients == 0 then
                vim.notify(
                    'Could not find `vtsls` lsp client; `vue_ls` will not work without it.',
                    vim.log.levels.ERROR
                )
                return
            end
            local ts_client = clients[1]
            local param = unpack(result)
            local id, command, payload = unpack(param)
            ts_client:exec_cmd({
                title = 'vue_request_forward',
                command = 'typescript.tsserverRequest',
                arguments = { command, payload },
            }, { bufnr = context.bufnr }, function(_, r)
                -- NOTE: return nil on error/no response to prevent memory leak in vue_ls
                local response_data = { { id, r and r.body } }
                ---@diagnostic disable-next-line: param-type-mismatch
                client:notify('tsserver/response', response_data)
            end)
        end
    end,
})

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
    'pylsp',
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

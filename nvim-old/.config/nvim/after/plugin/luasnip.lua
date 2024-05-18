local ls = require("luasnip");

ls.setup({
  enable_autosnippets=true
});

--E5108: Error executing lua ~/.local/share/nvim/lazy/LuaSnip/lua/luasnip/nodes/util.lua:641: attempt to index field 'snippet_roots' (a nil value)
--stack traceback:
--        ~/.local/share/nvim/lazy/LuaSnip/lua/luasnip/nodes/util.lua:641: in function 'snippettree_find_undamaged_node'
--        ~/.local/share/nvim/lazy/LuaSnip/lua/luasnip/nodes/snippet.lua:633: in function 'trigger_expand'
--        ~/.local/share/nvim/lazy/LuaSnip/lua/luasnip/init.lua:270: in function 'snip_expand'
--        ~/.local/share/nvim/lazy/LuaSnip/lua/luasnip/init.lua:392: in function 'lsp_expand'
--        ~/.local/share/nvim/lazy/lsp-zero.nvim/lua/lsp-zero/cmp.lua:250: in function 'expand'
--        /home/max/.local/share/nvim/lazy/nvim-cmp/lua/cmp/core.lua:488: in function </home/max/.local/share/nvim/lazy/nvim-cmp/lua/cmp/core.lua:434>
--        ~/.local/share/nvim/lazy/nvim-cmp/lua/cmp/utils/feedkeys.lua:47: in function <...ocal/share/nvim/lazy/nvim-cmp/lua/cmp/utils/feedkeys.lua:45>

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

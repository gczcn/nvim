local create_autocmd = vim.api.nvim_create_autocmd

-- Line breaks are not automatically commented
create_autocmd('FileType', {
  pattern = '*',
  callback = function ()
    vim.cmd('setlocal formatoptions-=c formatoptions-=r formatoptions-=o')
  end
})

-- Highlight when copying
create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function ()
    vim.highlight.on_yank()
  end
})

create_autocmd('FileType', {
  pattern = { 'json', 'lsonc', 'markdown' },
  callback = function()
    vim.wo.conceallevel = 0
  end
})

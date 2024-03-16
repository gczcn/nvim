local autocmd = vim.api.nvim_create_autocmd

autocmd('FileType', {
  pattern = '*',
  callback = function ()
    vim.cmd('setlocal formatoptions-=c formatoptions-=r formatoptions-=o')
  end
})

autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function ()
    vim.highlight.on_yank()
  end
})

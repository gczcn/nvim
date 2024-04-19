local create_autocmd = vim.api.nvim_create_autocmd
local exec_autocmds = vim.api.nvim_exec_autocmds

-- File opened event
create_autocmd({ 'BufReadPost', 'BufWritePost', 'BufNewFile' }, {
  pattern = '*',
  callback = function()
    exec_autocmds('User', { pattern = 'FileOpened' })
  end
})

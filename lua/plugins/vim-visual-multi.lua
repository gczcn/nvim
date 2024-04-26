return {
  'mg979/vim-visual-multi',
  event = 'User FileOpened',
  config = function ()
    vim.cmd([[
      nmap <C-u> <C-up>
      nmap <C-e> <C-down>
      ]])
  end
}

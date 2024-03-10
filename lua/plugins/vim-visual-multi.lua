return {
  'mg979/vim-visual-multi',
  event = fileopened,
  config = function ()
    vim.cmd([[
      nmap <C-u> <C-up>
      nmap <C-e> <C-down>
      ]])
  end
}

return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  keys = {
    {'<C-t>', '<cmd>ToggleTerm<CR>', mode = 'n'},
    {'<leader>tt', '<cmd>ToggleTerm<CR>', mode = 'n'},
    {'<leader>T', '<cmd>ToggleTerm<CR>', mode = 'n'},
    {'<M-q>', '<C-\\><C-n>', mode = 't'},
    {'<C-t>', '<C-\\><C-n><cmd>ToggleTerm<CR>', mode = 't'},
  },
  version = "*",
  opts = {
    size = 30,
    winbar = {
      enabled = true,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end
    },
  }
}

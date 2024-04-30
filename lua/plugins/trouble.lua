return {
  'folke/trouble.nvim',
  keys = {
    { '<leader>to', '<cmd>TroubleToggle<CR>', desc = 'Toggle Trouble' },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    height = 20,
  },
}

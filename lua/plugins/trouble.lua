return {
  "folke/trouble.nvim",
  keys = {
    {'<leader>ot', '<cmd>TroubleToggle<CR>', desc = 'Toggle Trouble'}
  },
  event = 'VeryLazy',
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    position = 'right',
  },
}

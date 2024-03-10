return {
  "folke/trouble.nvim",
  keys = {
    {'<leader>o', '<cmd>TroubleToggle<CR>'}
  },
  event = 'VeryLazy',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    position = 'right',
  },
}

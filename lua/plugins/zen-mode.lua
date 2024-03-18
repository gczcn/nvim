return {
  "folke/zen-mode.nvim",
  cmd = 'ZenMode',
  keys = {
    { '<leader>zm', '<cmd>Twilight<CR><cmd>ZenMode<CR>' },
  },
  opts = {
    window = {
      width = 150,
    },
  },
}

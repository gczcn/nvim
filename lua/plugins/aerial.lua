return {
  'stevearc/aerial.nvim',
  event = 'User FileOpened',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    -- 'nvim-tree/nvim-web-devicons',
  },
  cmd = 'AerialToggle',
  keys = {
    { '<leader>cA', '<cmd>AerialToggle<CR>' }
  },
  config = function ()
    require("aerial").setup({
      layout = {
        max_width = { 60, 0.4 },
        width = 50,
      }
    })
  end
}

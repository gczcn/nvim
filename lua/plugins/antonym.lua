return {
  'gczcn/antonym.nvim',
  cmd = 'AntonymWord',
  keys = {
    {'<leader>ya', '<cmd>AntonymWord<CR>' }
  },
  config = function ()
    require('antonym').setup()
  end
}

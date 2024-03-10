return {
  'TobinPalmer/rayso.nvim',
  cmd = { 'Rayso' },
  keys = {
    { '<leader>rs', ':Rayso<CR>', mode = {'n', 'v'} },
  },
  config = function()
    require('rayso').setup({
      options = {
        theme = 'sunset'
      }
    })
  end
}

return {
  'Bekaboo/dropbar.nvim',
  event = 'VeryLazy',
  keys = {
    {'<leader>wp', function () require('dropbar.api').pick() end, mode = 'n'}
  },
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim'
  }
}

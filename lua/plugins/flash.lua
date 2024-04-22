return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { 'st', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
    { 'sT', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
    { 'srf', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
    { 'sRf', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
    { '<C-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
  },
}

return {
  'Bekaboo/deadcolumn.nvim',
  event = { 'VeryLazy' },
  config = function ()
    require('deadcolumn').setup({
      scope = 'buffer',
      modes = function() return true end,
      warning = {
        colorcode = '#fb4934',
      }
    })
  end
}

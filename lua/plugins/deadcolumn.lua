return {
  'Bekaboo/deadcolumn.nvim',
  event = 'VeryLazy',
  config = function ()
    require('deadcolumn').setup({
      scope = 'buffer',
      modes = function() return true end,
      warning = {
        alpha = 1,
        hlgroup = { 'CursorLine', 'bg' }
      }
    })
  end
}

return {
  'williamboman/mason.nvim',
  cmd = 'Mason',
  build = ':MasonUpdate',
  config = function()
    require('mason').setup({
      ui = {
        icons = {
          package_installed = '󰽢',
          package_pending = '',
          package_uninstalled = '󰽤',
        },
      },
    })
  end
}

return {
  'AckslD/nvim-neoclip.lua',
  keys = {
    {'ty', '<cmd>Telescope neoclip<CR>', mode = 'n'}
  },
  dependencies = {
    {'kkharji/sqlite.lua', module = 'sqlite'},
    {'nvim-telescope/telescope.nvim'},
  },
  config = function ()
    require('neoclip').setup({
      history = 1000,
      enable_persistent_history = true,
      keys = {
        telescope = {
          i = {
            select = '<c-y>',
            paste = '<cr>',
            paste_behind = '<c-g>',
            replay = '<c-q>', -- replay a macro
            delete = '<c-d>', -- delete an entry
            edit = '<c-k>', -- edit an entry
            custom = {},
          },
        },
      },
    })
  end
}

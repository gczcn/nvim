return {
  'crusj/bookmarks.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function ()
    require("bookmarks").setup({
      keymap = {
        toggle = '<leader>bm'
      }
    })
  end
}

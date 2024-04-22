return {
  'stevearc/oil.nvim',
  keys = {
    {
      '<leader>e',
      '<cmd>Oil<CR>',
      mode = 'n'
    }
  },
  cmd = 'Oil',
  config = function ()
    require("oil").setup({
      default_file_explorer = false,
      view_options = {
        show_hidden = true,
      },
    })
  end
}

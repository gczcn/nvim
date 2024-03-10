return {
  'gczcn/antonym.nvim',
  config = function ()
    require('antonym').setup({
      key = '<leader>wa'
    })
  end
}

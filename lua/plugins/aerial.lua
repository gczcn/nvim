return {
  'stevearc/aerial.nvim',
  event = { fileopened, 'VeryLazy' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    -- 'nvim-tree/nvim-web-devicons',
  },
  config = function ()
    require("aerial").setup({
      layout = {
        max_width = { 60, 0.4 },
        width = 50,
      }
    })
  end
}

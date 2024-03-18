return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>gl', '<cmd>Gitsigns toggle_linehl<CR>', mode = 'n' }
  },
  config = function()
    require('gitsigns').setup({
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 0,
      },
    })
      vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#665c54' })
  end
}

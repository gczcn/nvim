return {
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('gruvbox').setup({
        italic = {
          strings = false,
        },
        overrides = {
          Visual = { bold = true },
          ErrorLine = { bg = '#4c3130' },
          WarnLine = { bg = '#403821' },
          HintLine = { bg = '#364230' },
          InfoLine = { bg = '#214039' },
        },
      })
      vim.cmd('colorscheme gruvbox')

      -- noice
      vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder', { bg = '#282828' })
      vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitle', { bg = '#282828' })
      vim.api.nvim_set_hl(0, 'NoiceCmdlineIcon', { bg = '#282828', fg = '#fabd2f' })
      vim.api.nvim_set_hl(0, 'NoiceCmdlineIconSearch', { bg = '#282828', fg = '#fabd2f' })
    end
  },
}

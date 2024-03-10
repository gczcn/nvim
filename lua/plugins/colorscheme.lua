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
    end
  },
}

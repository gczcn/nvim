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

          -- floatwin
          FloatBorder = { bg = '#282828', fg = '#ebdbb2' },
          NormalFloat = { bg = '#282828' },

          -- noice
          NoiceCmdlinePopupBorder = { bg = '#282828' },
          NoiceCmdlinePopupTitle = { bg = '#282828' },
          NoiceCmdlineIcon = { bg = '#282828', fg = '#fabd2f' },
          NoiceCmdlineIconSearch = { bg = '#282828', fg = '#fabd2f' },

          -- lazy.nvim
          LazyNormal = { bg = '#3c3836' },

          -- which-key.nvim
          WhichKeyFloat = { bg = '#3c3836' },

          -- mason.nvim
          MasonNormal = { bg = '#3c3836' },
        },
      })
      vim.cmd('colorscheme gruvbox')
    end,
  },
}

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
          FloatTitle = { bg = '#3c3836', bold = true, fg = '#b8bb26' },
          FloatFooter = { bg = '#3c3836', bold = true, fg = '#b8bb26' },

          -- noice
          NoiceCmdlinePopupBorder = { bg = '#282828' },
          NoiceCmdlinePopupTitle = { bg = '#282828' },
          NoiceCmdlineIcon = { bg = '#282828', fg = '#fabd2f' },
          NoiceCmdlineIconSearch = { bg = '#282828', fg = '#fabd2f' },

          -- mini.indentscope
          MiniIndentscopeSymbol = { fg = '#fabd2f' }
        },
      })
      vim.cmd('colorscheme gruvbox')
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    enabled = false,
    priority = 1000,
    config = function ()
      vim.cmd('colorscheme nightfox')
    end
  },
}

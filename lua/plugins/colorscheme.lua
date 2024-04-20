vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    if vim.g.colors_name == 'gruvbox' then
      local set_hl = vim.api.nvim_set_hl
      local get_hl = vim.api.nvim_get_hl
      local yellow = get_hl(0, {name = 'GruvboxYellow'})
      set_hl(0, 'NoiceCmdlinePopupBorder', get_hl(0, {name = 'Normal'}))
      set_hl(0, 'NoiceCmdlinePopupTitle', get_hl(0, {name = 'Normal'}))
      set_hl(0, 'NoiceCmdlineIcon', yellow)
      set_hl(0, 'NoiceCmdlineIcon', yellow)
    end
  end,
})
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

          -- mini.indentscope
          MiniIndentscopeSymbol = { fg = '#fabd2f' }
        },
      })
      vim.cmd('colorscheme gruvbox')
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
    priority = 1000,
    config = function ()
    end
  },
}

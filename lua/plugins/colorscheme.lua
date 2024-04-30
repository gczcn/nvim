local hl_change = function(key, b, list)
  for _, name in ipairs(list) do
    local hl = vim.api.nvim_get_hl(0, {name = name})
    hl[key] = b
    vim.api.nvim_set_hl(0, name, hl)
  end
end

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    local set_hl = vim.api.nvim_set_hl
    local get_hl = vim.api.nvim_get_hl
    local gruvbox_yellow = get_hl(0, {name = 'GruvboxYellow'})
    local gruvbox_orange = get_hl(0, {name = 'GruvboxOrange'})

    local illwr = get_hl(0, {name = 'CursorLine'})
    illwr['underline'] = true

    local diagnostic_line = {
      dark = {
        ErrorLine = '#4c3130',
        WarnLine = '#403821',
        HintLine = '#364230',
        InfoLine = '#304540',
      },
      light = {
        ErrorLine = '',
        WarnLine = '',
        HintLine = '',
        InfoLine = '',
      },
    }

    if vim.g.colors_name == 'gruvbox' then
      set_hl(0, 'NoiceCmdlinePopupBorder', get_hl(0, {name = 'Normal'}))
      set_hl(0, 'NoiceCmdlinePopupTitle', get_hl(0, {name = 'Normal'}))
      set_hl(0, 'NoiceCmdlineIcon', gruvbox_yellow)
      set_hl(0, 'NoiceCmdlineIcon', gruvbox_yellow)
      set_hl(0, 'TelescopePromptBorder', gruvbox_orange)

      -- Set diagnostic row background color
      local dl = diagnostic_line[vim.o.background]
      for _, d in ipairs({ 'ErrorLine', 'WarnLine', 'HintLine', 'InfoLine' }) do
        set_hl(0, d, {bg = dl[d]})
      end
    end

    set_hl(0, 'IlluminatedWordRead', illwr)
    set_hl(0, 'GitSignsCurrentLineBlame', { fg = Utils.get_hl('Comment', 'fg') })

    hl_change('italic', true, {'Comment'})
    hl_change('bold', true, {'Visual', 'Function'})

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
    config = function()
      vim.cmd('colorscheme nightfox')
    end
  },
}

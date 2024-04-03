return {
  'codota/tabnine-nvim',
  event = 'InsertEnter',
  build = './dl_binaries.sh',
  config = function()
    require('tabnine').setup({
      disable_auto_comment = true,
      accept_keymap = '<M-Tab>',
      dismiss_keymap = '<C-]>',
      debounce_ms = 400,
      exclude_filetypes = { 'TelescopePrompt', 'NvimTree' },
      log_file_path = nil, -- absolute path to Tabnine log file
    })
    vim.api.nvim_set_hl(0, 'TabnineSuggestion', {
      fg = '#665c54',
      ctermfg = 244,
    })
  end,
}

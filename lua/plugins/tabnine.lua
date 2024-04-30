return {
  'codota/tabnine-nvim',
  event = 'InsertEnter',
  enabled = vim.g.enabled_tabnine,
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

    local set_hl = function()
      vim.api.nvim_set_hl(0, 'TabnineSuggestion', {
        fg = Utils.get_hl('Comment', 'fg'),
      })
    end

    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = function()
        set_hl()
      end
    })

    set_hl()
  end,
}

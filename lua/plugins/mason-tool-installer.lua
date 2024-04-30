return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  lazy = true,
  dependencies = {
    'williamboman/mason.nvim',
  },
  config = function()
    local mason = require('mason')
    local mason_tool_installer = require('mason-tool-installer')

    mason.setup()

    mason_tool_installer.setup({
      ensure_installed = {
        'prettier', -- prettier formatter
        'stylua', -- lua formatter
        'isort', -- python formatter
        'black', -- python formatter
        'pylint', -- python linter
        'eslint_d', -- js linter
      },
    })

    vim.cmd('MasonToolsInstall')
  end,
}

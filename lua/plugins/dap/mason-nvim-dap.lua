return {
  'jay-babu/mason-nvim-dap.nvim',
  lazy = true,
  dependencies = {
    'williamboman/mason.nvim',
  },
  config = function()
    local mason = require('mason')
    local mason_dap = require('mason-nvim-dap')

    mason.setup()

    mason_dap.setup({
      ensure_installed = {
        'codelldb',
        'coreclr',
      },
    })
  end,
}

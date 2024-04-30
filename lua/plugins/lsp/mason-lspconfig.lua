return {
  'williamboman/mason-lspconfig.nvim',
  lazy = true,
  config = function()
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')
    mason.setup()
    -- enable mason and configure icons
    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        'tsserver',
        'html',
        'cssls',
        'tailwindcss',
        'svelte',
        'lua_ls',
        'graphql',
        'emmet_ls',
        'prismals',
        'pyright',
        'omnisharp',
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })
  end,
}

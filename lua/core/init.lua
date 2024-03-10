require('core.global')
require('core.options')
require('core.keymaps')
require('core.command')
require('core.autocmds')

-- Neovide
if vim.g.neovide then
  require('core.neovide')
end

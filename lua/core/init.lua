require('core.keymaps')
require('core.options')
require('core.events')
require('core.autocmds')
require('core.commands')

-- neovide settings
if vim.g.neovide then
  require('core.neovide')
end

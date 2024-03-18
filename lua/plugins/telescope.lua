return {
  'nvim-telescope/telescope.nvim',
  -- event = 'VeryLazy',
  cmd = "Telescope",
  keys = {
    { 'tf', '<cmd>Telescope find_files<CR>' },
    { 'tr', '<cmd>Telescope oldfiles<CR>' },
    { 'ts', '<cmd>Telescope live_grep<CR>' },
    { 'tc', '<cmd>Telescope grep_string<CR>' },
    { 'tn', '<cmd>Telescope notify<CR>' },
    { 'tu', '<cmd>Telescope undo<CR>' },
  },
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-tree/nvim-web-devicons',
    'AckslD/nvim-neoclip.lua',
    "debugloop/telescope-undo.nvim",
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<M-u>'] = actions.move_selection_previous,
            ['<M-e>'] = actions.move_selection_next,
          }
        }
      }
    })

    if vim.g.neovide then
      telescope.setup({
        defaults = {
          winblend = 70,
        },
      })
    end

    telescope.load_extension('fzf')
    telescope.load_extension('neoclip')
    telescope.load_extension('undo')

  end,
}

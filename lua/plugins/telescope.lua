return {
  'nvim-telescope/telescope.nvim',
  -- event = 'VeryLazy',
  cmd = 'Telescope',
  keys = {
    { 'tf', '<cmd>Telescope find_files<CR>' },
    { 'tr', '<cmd>Telescope oldfiles<CR>' },
    { 'ts', '<cmd>Telescope live_grep<CR>' },
    { 'tc', '<cmd>Telescope grep_string<CR>' },
    { 'tk', '<cmd>Telescope keymaps<CR>' },
    { 'tn', '<cmd>Telescope notify<CR>' },
    { 'ty', '<cmd>Telescope neoclip<CR>', mode = 'n' },
    { 'tu', '<cmd>Telescope undo<CR>' },
    { 'te', '<cmd>Telescope file_browser<CR>' },
    { 'tE', '<cmd>Telescope file_browser path=%:p:h<CR>' },
    { 'tj', '<cmd>Telescope emoji<CR>' },
    { 'tg', '<cmd>Telescope glyph<CR>' },
    { 'tb', '<cmd>Telescope bookmarks<CR>' },
  },
  branch = '0.1.x',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'AckslD/nvim-neoclip.lua',
    { 'kkharji/sqlite.lua', module = 'sqlite' },
    'debugloop/telescope-undo.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    'xiyaowong/telescope-emoji.nvim',
    'ghassan0/telescope-glyph.nvim',
    'crusj/bookmarks.nvim',
  },
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == 'directory' then
        require('telescope')
      end
    end
  end,
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<M-u>'] = actions.move_selection_previous,
            ['<M-e>'] = actions.move_selection_next,
          },
        },
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
          hidden = { file_browser = true, folder_browser = true },
        },
      },
    })

    if vim.g.neovide then
      telescope.setup({
        defaults = {
          winblend = 70,
        },
      })
    end

    -- neoclip config
    require('neoclip').setup({
      history = 1000,
      enable_persistent_history = true,
      keys = {
        telescope = {
          i = {
            select = '<c-y>',
            paste = '<cr>',
            paste_behind = '<c-g>',
            replay = '<c-q>', -- replay a macro
            delete = '<c-d>', -- delete an entry
            edit = '<c-k>', -- edit an entry
            custom = {},
          },
        },
      },
    })

    telescope.load_extension('fzf')
    telescope.load_extension('neoclip')
    telescope.load_extension('undo')
    telescope.load_extension('file_browser')
    telescope.load_extension('emoji')
    telescope.load_extension('glyph')
    telescope.load_extension("bookmarks")
  end,
}

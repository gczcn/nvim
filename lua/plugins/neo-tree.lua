return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = 'Neotree',
  keys = {
    { '<leader>te', '<cmd>Neotree toggle<CR>',           desc = 'Explorer NeoTree (user dir)', remap = true },
    { '<leader>tE', '<cmd>Neotree dir=%:p:h toggle<CR>', desc = 'Explorer NeoTree (%f)',       remap = true },
    {
      '<leader>tge',
      function()
        require('neo-tree.command').execute({ source = 'git_status', toggle = true })
      end,
      desc = 'Git explorer',
    },
    {
      '<leader>tbe',
      function()
        require('neo-tree.command').execute({ source = 'buffers', toggle = true })
      end,
      desc = 'Buffer explorer',
    },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    -- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
    {
      's1n7ax/nvim-window-picker',
      version = '2.*',
      config = function()
        require('window-picker').setup({
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { 'terminal', 'quickfix' },
            },
          },
        })
      end,
    },
  },
  config = function()
    require('neo-tree').setup({
      event_handlers = {
        {
          event = "vim_buffer_enter",
          handler = function()
            if vim.bo.filetype == "neo-tree" then
              vim.opt.number = true
              vim.opt.relativenumber = true
            end
          end,
        },
      },
      popup_border_style = 'single',
      window = {
        mappings = {
          ['e'] = 'none',
          ['o'] = 'open',
          ['h'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hijack_netrw_behavior = 'open_current'
        },
      },
    })
  end,
}

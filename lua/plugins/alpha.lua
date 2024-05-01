return {
  'goolord/alpha-nvim',
  event = 'UIEnter',
  cmd = 'Alpha',
  depengencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local alpha = require('alpha')
    local startify = require('alpha.themes.startify')
    local version = function()
      return 'Neovim Version '
        .. vim.version().major
        .. '.'
        .. vim.version().minor
        .. '.'
        .. vim.version().patch
        .. '-'
        .. vim.version().prerelease
        .. '+'
        .. vim.version().build
    end

    local plugins = function()
      local stats = require('lazy').stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return 'loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
    end

    local date = function()
      if string.sub(os.getenv('LANG'), 1, 2) == 'zh' then
        return os.date('date: %Y年%b月%d日 星期%a %T %Z')
      else
        return os.date('date: %a %b %e %R:%S %Z UTC%z %Y')
      end
    end

    startify.section.header.val = {
      version(),
      plugins(),
      date(),
    }

    startify.opts.layout[1].val = 1
    startify.opts.opts.margin = 2

    -- Set menu
    startify.section.top_buttons.val = {
      startify.button('ne', '  New File', '<cmd>ene<CR>'),
      startify.button('tz', '  Z jump', '<cmd>Telescope z<CR>'),
      startify.button('tf', '󰈞  Find file', '<cmd>Telescope find_files<CR>'),
      startify.button('ts', '󰈬  Find word', '<cmd>Telescope live_grep<CR>'),
      startify.button('tc', '󰅳  grep string', '<cmd>Telescope grep_string<CR>'),
      startify.button('tr', '  Recent files', '<cmd>Telescope oldfiles<CR>'),
      startify.button('tb', '  Bookmarks', '<cmd>Telescope bookmarks list<CR>'),
      startify.button('rs', '  Restore Session', '<cmd>lua require("persistence").load()<CR>'),
      startify.button('nf', '  Neotree file explorer', '<cmd>Neotree toggle<CR>'),
      startify.button('of', '  Oil file explorer', '<cmd>Oil<CR>'),
      startify.button('te', '  Telescope file explorer', '<cmd>Telescope file_browser<CR>'),
      startify.button('tk', '󰌌  Keymaps', '<cmd>Telescope keymaps<CR>'),
      startify.button('cs', '  Colorscheme', '<cmd>Telescope colorscheme<CR>'),
      startify.button('tt', '  Terminal', '<cmd>ToggleTerm<CR>'),
      startify.button('ly', '󰒲  Lazy', '<cmd>Lazy<CR>'),
      startify.button('ls', '󰚰  Lazy Sync', '<cmd>Lazy sync<CR>'),
      startify.button('mn', '󰌗  Mason', '<cmd>Mason<CR>'),
      startify.button('to', '  Find Options', '<cmd>Telescope find_files cwd=' .. vim.fn.stdpath 'config' .. '<CR>'),
      startify.button('st', '󰼭  Speedtyper', '<cmd>Speedtyper<CR>'),
      startify.button('me', '󰍜  More', '<cmd>Menu<CR>'),
      startify.button('hp', '󰮥  Help', ':h '),
    }

    -- Send config to alpha
    alpha.setup(startify.config)

    -- Disable folding on alpha buffer
    vim.cmd('autocmd FileType alpha setlocal nofoldenable')

    vim.keymap.set('n', '<leader>a', '<cmd>Alpha<CR>')
    if vim.o.filetype == 'lazy' then
      vim.cmd([[q]])
    end

    if
      vim.o.filetype ~= 'oil'
      and vim.o.filetype ~= 'neo-tree'
      and vim.o.filetype ~= 'netrw'
      and vim.o.filetype ~= 'TelescopePrompt'
    then
      if vim.fn.expand('%') == '' then
        vim.cmd([[Alpha]])
        vim.cmd([[bd 1]])
      end
    end
  end,
}

return {
  'goolord/alpha-nvim',
  event = 'UIEnter',
  cmd = 'Alpha',
  config = function()
    local alpha = require('alpha')
    local startify = require('alpha.themes.startify')
    local version = function ()
      return 'Neovim Version ' ..
        vim.version().major ..'.' ..
        vim.version().minor ..'.' ..
        vim.version().patch .. '-' ..
        vim.version().prerelease .. '+' ..
        vim.version().build
    end

    local plugins = function ()
      local stats = require('lazy').stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return 'loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
    end

    local date = function ()
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
      startify.button('n', '  New File', '<cmd>ene<CR>'),
      startify.button('F', '󰈞  Find file', '<cmd>Telescope find_files<CR>'),
      startify.button('f', '󰈬  Find word', '<cmd>Telescope live_grep<CR>'),
      startify.button('S', '󰅳  grep string', '<cmd>Telescope grep_string<CR>'),
      startify.button('r', '  Recent files', '<cmd>Telescope oldfiles<CR>'),
      startify.button('s', '  Restore Session', '<cmd>lua require("persistence").load()<CR>'),
      startify.button('v', '  Neotree file explorer', '<cmd>Neotree toggle<CR>'),
      startify.button('i', '  Oil file explorer', '<cmd>Oil<CR>'),
      startify.button('k', '󰌌  Keymaps', '<cmd>Telescope keymaps<CR>'),
      startify.button('c', '  Colorscheme', '<cmd>Telescope colorscheme<CR>'),
      startify.button('t', '  Terminal', '<cmd>ToggleTerm<CR>'),
      startify.button('l', '󰒲  Lazy', '<cmd>Lazy<CR>'),
      startify.button('L', '󰚰  Lazy Sync', '<cmd>Lazy sync<CR>'),
      startify.button('m', '󰌗  Mason', '<cmd>Mason<CR>'),
      startify.button('o', '  Options', '<cmd>Neotree ~/.config/nvim<CR>'),
      startify.button('p', '󰼭  Speedtyper', '<cmd>Speedtyper<CR>'),
      startify.button('x', '󰍜  More', '<cmd>MoreMenu<CR>'),
      startify.button('h', '󰮥  Help', ':h '),
    }

    -- Send config to alpha
    alpha.setup(startify.config)

    -- Disable folding on alpha buffer
    vim.cmd('autocmd FileType alpha setlocal nofoldenable')
    vim.keymap.set('n', '<leader>a', '<cmd>Alpha<CR>')
    if vim.o.filetype == 'lazy' then
      vim.cmd [[q]]
    end
    if vim.o.filetype ~= 'oil' and vim.o.filetype ~= 'neo-tree' then
      if vim.fn.expand('%') == '' then
        vim.cmd [[Alpha]]
        vim.cmd [[bd 1]]
      end
    end
  end
}

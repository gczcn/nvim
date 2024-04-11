return {
  'goolord/alpha-nvim',
  event = 'UIEnter',
  cmd = 'Alpha',
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

    local menu_icon = {
      '  ',
      '  ',
      '󰈞  ',
      '󰈬  ',
      '󰅳  ',
      '  ',
      '  ',
      '  ',
      '  ',
      '  ',
      '  ',
      '󰌌  ',
      '  ',
      '  ',
      '󰒲  ',
      '󰚰  ',
      '󰌗  ',
      '  ',
      '󰼭  ',
      '󰍜  ',
      '󰮥  ',
    }

    local function get_menu_icon(number)
      if vim.g.notty then
        return menu_icon[number]
      end
      return ''
    end
    -- Set menu
    startify.section.top_buttons.val = {
      startify.button('ne', get_menu_icon(1) .. 'New File', '<cmd>ene<CR>'),
      startify.button('zc', get_menu_icon(2) .. 'Z jump', '<cmd>Telescope z<CR>'),
      startify.button('ff', get_menu_icon(3) .. 'Find file', '<cmd>Telescope find_files<CR>'),
      startify.button('fw', get_menu_icon(4) .. 'Find word', '<cmd>Telescope live_grep<CR>'),
      startify.button('gs', get_menu_icon(5) .. 'grep string', '<cmd>Telescope grep_string<CR>'),
      startify.button('rf', get_menu_icon(6) .. 'Recent files', '<cmd>Telescope oldfiles<CR>'),
      startify.button('bm', get_menu_icon(7) .. 'Bookmarks', '<cmd>Telescope bookmarks list<CR>'),
      startify.button('rs', get_menu_icon(8) .. 'Restore Session', '<cmd>lua require("persistence").load()<CR>'),
      startify.button('nf', get_menu_icon(9) .. 'Neotree file explorer', '<cmd>Neotree toggle<CR>'),
      startify.button('of', get_menu_icon(10) .. 'Oil file explorer', '<cmd>Oil<CR>'),
      startify.button('tf', get_menu_icon(11) .. 'Telescope file explorer', '<cmd>Telescope file_browser<CR>'),
      startify.button('km', get_menu_icon(12) .. 'Keymaps', '<cmd>Telescope keymaps<CR>'),
      startify.button('cs', get_menu_icon(13) .. 'Colorscheme', '<cmd>Telescope colorscheme<CR>'),
      startify.button('tr', get_menu_icon(14) .. 'Terminal', '<cmd>ToggleTerm<CR>'),
      startify.button('ly', get_menu_icon(15) .. 'Lazy', '<cmd>Lazy<CR>'),
      startify.button('ls', get_menu_icon(16) .. 'Lazy Sync', '<cmd>Lazy sync<CR>'),
      startify.button('mn', get_menu_icon(17) .. 'Mason', '<cmd>Mason<CR>'),
      startify.button('ot', get_menu_icon(18) .. 'Options', '<cmd>Telescope file_browser path=~/.config/nvim<CR>'),
      startify.button('st', get_menu_icon(19) .. 'Speedtyper', '<cmd>Speedtyper<CR>'),
      startify.button('me', get_menu_icon(20) .. 'More', '<cmd>Menu<CR>'),
      startify.button('hp', get_menu_icon(21) .. 'Help', ':h '),
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
    vim.api.nvim_create_autocmd('User', {
      group = vim.api.nvim_create_augroup('TuoGroup', { clear = false }),
      pattern = 'LazyVimStarted',
      callback = function()
        local stats = require('lazy').stats()
        local footer_val =
          string.format('󱐋 %d/%d plugins loaded in %.3f ms', stats.loaded, stats.count, stats.startuptime)
        startify.config.section.footer.val = footer_val
        for _, s in ipairs({ 'LazyStart', 'LazyDone', 'UIEnter' }) do
          table.insert(startify.config.section.lazystats.val, {
            opts = {
              hl = 'Special',
              position = 'center',
            },
            type = 'text',
            val = string.format('%s %.3f ms', s, stats.times[s]),
          })
        end
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}

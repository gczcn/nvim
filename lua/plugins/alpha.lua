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
      startify.button('ne', '  New File', '<cmd>ene<CR>'),
      startify.button('zc', '  Z jump', '<cmd>Telescope z<CR>'),
      startify.button('ff', '󰈞  Find file', '<cmd>Telescope find_files<CR>'),
      startify.button('fw', '󰈬  Find word', '<cmd>Telescope live_grep<CR>'),
      startify.button('gs', '󰅳  grep string', '<cmd>Telescope grep_string<CR>'),
      startify.button('rf', '  Recent files', '<cmd>Telescope oldfiles<CR>'),
      startify.button('bm', '  Bookmarks', '<cmd>Telescope bookmarks<CR>'),
      startify.button('rs', '  Restore Session', '<cmd>lua require("persistence").load()<CR>'),
      startify.button('nf', '  Neotree file explorer', '<cmd>Neotree toggle<CR>'),
      startify.button('of', '  Oil file explorer', '<cmd>Oil<CR>'),
      startify.button('tf', '  Telescope file explorer', '<cmd>Telescope file_browser<CR>'),
      startify.button('km', '󰌌  Keymaps', '<cmd>Telescope keymaps<CR>'),
      startify.button('cs', '  Colorscheme', '<cmd>Telescope colorscheme<CR>'),
      startify.button('tr', '  Terminal', '<cmd>ToggleTerm<CR>'),
      startify.button('ly', '󰒲  Lazy', '<cmd>Lazy<CR>'),
      startify.button('ls', '󰚰  Lazy Sync', '<cmd>Lazy sync<CR>'),
      startify.button('mn', '󰌗  Mason', '<cmd>Mason<CR>'),
      startify.button('ot', '  Options', '<cmd>Telescope file_browser path=~/.config/nvim<CR>'),
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
      vim.cmd [[q]]
    end
    if vim.o.filetype ~= 'oil' and vim.o.filetype ~= 'neo-tree' and vim.o.filetype ~= 'netrw' and vim.o.filetype ~= 'TelescopePrompt' then
      if vim.fn.expand('%') == '' then
        vim.cmd [[Alpha]]
        vim.cmd [[bd 1]]
      end
    end
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("TuoGroup", { clear = false }),
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local footer_val = string.format(
          "󱐋 %d/%d plugins loaded in %.3f ms",
          stats.loaded,
          stats.count,
          stats.startuptime
        )
        startify.config.section.footer.val = footer_val
        for _, s in ipairs({ "LazyStart", "LazyDone", "UIEnter" }) do
          table.insert(startify.config.section.lazystats.val, {
            opts = {
              hl = "Special",
              position = "center",
            },
            type = "text",
            val = string.format("%s %.3f ms", s, stats.times[s]),
          })
        end
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end
}

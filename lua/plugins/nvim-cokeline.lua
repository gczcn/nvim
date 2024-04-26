return {
  'willothy/nvim-cokeline',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'stevearc/resession.nvim',
    'nvim-lualine/lualine.nvim',
  },
  config = function()
    local get_colors = function(a, b)
      if next(vim.api.nvim_get_hl(0, {name = 'lualine_' .. a .. '_' .. b})) ~= nil then
        return vim.api.nvim_get_hl(0, {name = 'lualine_' .. a .. '_' .. b})
      end
      return vim.api.nvim_get_hl(0, {name = 'lualine_' .. a .. '_normal'})
    end

    local mode_list = {
      i = 'insert',
      c = 'command',
      v = 'visual',
      V = 'visual',
      n = 'normal',
      R = 'replace',
    }

    local get_mode = function()
      if mode_list[vim.api.nvim_get_mode().mode] then
        return mode_list[vim.api.nvim_get_mode().mode]
      end
      return 'normal'
    end

    -- Mode color switch
    vim.api.nvim_create_autocmd({ 'ModeChanged', 'ColorScheme' }, {
      pattern = { '*' },
      -- command = 'redrawtabline',
      callback = function()
        vim.cmd('redrawtabline')
        vim.api.nvim_set_hl(0, 'TabLineFill', get_colors('c', get_mode()))
      end
    })

    -- set keymaps
    vim.keymap.set('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true })
    vim.keymap.set('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true })
    vim.keymap.set('n', '<M-N>', '<Plug>(cokeline-switch-prev)', { silent = true })
    vim.keymap.set('n', '<M-I>', '<Plug>(cokeline-switch-next)', { silent = true })

    for i = 1, 9 do
      vim.keymap.set('n', ('<leader>%s'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i), { silent = true })
      vim.keymap.set('n', ('<leader>d%s'):format(i), ('<Plug>(cokeline-switch-%s)'):format(i), { silent = true })
    end


    require('cokeline').setup({
      default_hl = {
        fg = function(buffer)
          if buffer.is_focused then
            return get_colors('a', get_mode())['fg']
          end
          return get_colors('b', get_mode())['fg']
        end,
        bg = function(buffer)
          if buffer.is_focused then
            return get_colors('a', get_mode())['bg']
          end
          return get_colors('b', get_mode())['bg']
        end,
        bold = function(buffer)
          return buffer.is_focused
        end,
      },
      rhs = {
        {
          text = ' 󰍜 ',
          bold = true,
          bg = function()
            return get_colors('a', get_mode())['bg']
          end,
          fg = function()
            return get_colors('a', get_mode())['fg']
          end,
          on_click = function()
            vim.cmd('Menu')
          end
        }
      },
    })
  end
}

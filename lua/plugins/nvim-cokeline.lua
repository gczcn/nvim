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
    local is_picking_focus = require('cokeline/mappings').is_picking_focus
    local is_picking_close = require('cokeline/mappings').is_picking_close

    local get_buffers = function()
      local lines = 1
      local scripts = vim.api.nvim_command_output("ls")
      for script in scripts:gmatch("[\r\n]+") do
        lines = lines + 1
      end
      return lines
    end

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

    local diagnostic_color = function(buffer)
      return (buffer.diagnostics.errors ~= 0 and Utils.get_hl('DiagnosticError', 'fg'))
        or (buffer.diagnostics.warnings ~= 0 and Utils.get_hl('DiagnosticWarn', 'fg'))
        or (buffer.diagnostics.hints ~= 0 and Utils.get_hl('diagnosticHint', 'fg'))
        or (buffer.diagnostics.infos ~= 0 and Utils.get_hl('diagnosticInfo', 'fg'))
        or nil
    end


    -- Get buffer name
    local function get_path_parts(path)
      local dirs = {}
      for dir in string.gmatch(path, '([^/]+)') do
        table.insert(dirs, dir)
      end

      local filename = dirs[#dirs]
      if filename ~= nil and string.sub(filename, 1, 1) == '+' then
        local ext = filename:match('^.+(%..+)$')
        local last_dir = dirs[#dirs - 1]
        if last_dir == '[id]' and path:match('api') and filename == '+server.ts' then
          local id_index = 0
          for i, dir in ipairs(dirs) do
            if dir == '[id]' then
              id_index = i
            end
          end
          local new_dir = dirs[id_index - 1]
          return new_dir .. '/[id]/' .. filename
        elseif last_dir == '[id]' then
          local id_index = 0
          for i, dir in ipairs(dirs) do
            if dir == '[id]' then
              id_index = i
            end
          end
          local new_dir = dirs[id_index - 1]
          return new_dir .. '/[id]/' .. filename
        elseif path:match('api') then
          local api_index = 0
          for i, dir in ipairs(dirs) do
            if dir == 'api' then
              api_index = i
            end
          end
          local api_next_dir = dirs[api_index + 1]
          return 'api/' .. api_next_dir .. '/' .. filename
        elseif ext == nil then
          local dir = dirs[#dirs - 1]
          return dir .. '/' .. filename
        else
          local dir = dirs[#dirs - 1]
          return dir .. '/' .. filename
        end
      end
    end

    -- Mode color switch
    vim.api.nvim_create_autocmd({ 'ModeChanged', 'ColorScheme' }, {
      pattern = { '*' },
      callback = function()
        vim.api.nvim_set_hl(0, 'TabLineFill', get_colors('c', get_mode()))
        vim.cmd('redrawtabline')
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
          text = function()
            if vim.fn.expand('%') == '' or vim.fn.expand('%') == nil then
              return ' ' .. vim.o.filetype .. ' '
            else
              if os.getenv('HOME') == string.sub(vim.fn.expand('%'), 1, string.len(os.getenv('HOME'))) then
                return ' ~' .. string.sub(vim.fn.expand('%'), (string.len(vim.fn.expand('%')) - string.len(os.getenv('HOME'))) * -1 ) .. ' '
              end
              return ' ' .. vim.fn.expand('%') .. ' '
            end
          end,
          bg = function()
            return get_colors('c', get_mode())['bg']
          end,
          fg = function()
            return get_colors('c', get_mode())['fg']
          end,
        },
        {
          text = ' α ',
          on_click = function()
            vim.cmd([[Alpha]])
          end
        },
        {
          text = ' ',
          on_click = function()
            vim.cmd([[Telescope file_browser]])
          end
        },
        {
          text = ' ? ',
          bold = true,
          bg = function()
            return get_colors('a', get_mode())['bg']
          end,
          fg = function()
            return get_colors('a', get_mode())['fg']
          end,
          on_click = function()
            vim.cmd([[call feedkeys(':h ')]])
          end
        },
        {
          text = 'M ',
          bold = true,
          bg = function()
            return get_colors('a', get_mode())['bg']
          end,
          fg = function()
            return get_colors('a', get_mode())['fg']
          end,
          on_click = function()
            vim.cmd([[Menu]])
          end
        },
        {
          text = '  ',
          bg = Utils.get_hl('DiagnosticHint', 'fg'),
          fg = Utils.get_hl('Normal', 'bg'),
          on_click = function()
            vim.cmd([[RunCode]])
          end
        },
        {
          text = ' ',
          bg = Utils.get_hl('DiagnosticHint', 'fg'),
          fg = Utils.get_hl('Normal', 'bg'),
          on_click = function()
            require('dap').continue()
          end
        },
        {
          text = ' X ',
          bold = true,
          bg = function()
            return Utils.get_hl('DiagnosticSignError', 'fg')
          end,
          fg = function()
            return get_colors('a', get_mode())['fg']
          end,
          on_click = function()
            vim.cmd([[:qa]])
          end
        },
      },
      components = {
        {
          text = function(buffer)
            return ' ' .. buffer.index
          end,
        },
        {
          text = function(buffer)
            if is_picking_focus() or is_picking_close() then
              return ' ' .. buffer.pick_letter
            end
            return ' ' .. buffer.devicon.icon
          end,
          style = function(_)
            return (is_picking_focus() or is_picking_close()) and 'italic,bold' or nil
          end,
        },
        {
          text = function(buffer)
            if get_path_parts(buffer.path) ~= nil then
              return get_path_parts(buffer.path) .. ' '
            else
              return buffer.unique_prefix .. buffer.filename .. ' '
            end
          end,
        },
        {
          text = function(buffer)
            return buffer.is_modified and '* ' or ''
          end,
        },
        {
          text = function(buffer)
            return (buffer.diagnostics.errors ~= 0 and ' Er ' .. buffer.diagnostics.errors .. ' ')
              or (buffer.diagnostics.warnings ~= 0 and ' Wn ' .. buffer.diagnostics.warnings .. ' ')
              or (buffer.diagnostics.hints ~= 0 and ' Ht ' .. buffer.diagnostics.hints .. ' ')
              or (buffer.diagnostics.infos ~= 0 and ' Io ' .. buffer.diagnostics.infos .. ' ')
              or ''
          end,
          fg = function(buffer)
            if buffer.is_focused then
              return nil
            end
            return diagnostic_color(buffer)
          end,
          bg = function(buffer)
            if buffer.is_focused then
              return diagnostic_color(buffer)
            end
            return nil
          end
        },
        {
          text = function(buffer)
            if vim.api.nvim_get_mode().mode ~= 'c' then
              if buffer.index == get_buffers() then
                return ' + '
              end
              return ''
            end
            return ''
          end,
          bold = true,
          bg = function()
            return Utils.get_hl('DiagnosticHint', 'fg')
          end,
          fg = function()
            return Utils.get_hl('Normal', 'bg')
          end,
          on_click = function()
            vim.cmd([[ene]])
          end
        }
      },
    })
    vim.api.nvim_set_hl(0, 'TabLineFill', get_colors('c', get_mode()))
  end
}

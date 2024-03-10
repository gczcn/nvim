return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local mode_map = {
      ['n'] = 'NOR',
      ['no'] = 'O-P',
      ['nov'] = 'O-P',
      ['noV'] = 'O-P',
      ['no\22'] = 'O-P',
      ['niI'] = 'N-I',
      ['niR'] = 'N-R',
      ['niV'] = 'N',
      ['nt'] = 'N-T',
      ['v'] = 'VIS',
      ['vs'] = 'V',
      ['V'] = 'V-L',
      ['Vs'] = 'V-L',
      ['\22'] = 'V-B',
      ['\22s'] = 'V-B',
      ['s'] = 'S',
      ['S'] = 'S-L',
      ['\19'] = 'S-B',
      ['i'] = 'INS',
      ['ic'] = 'I-C',
      ['ix'] = 'I-X',
      ['R'] = 'REP',
      ['Rc'] = 'R-C',
      ['Rx'] = 'R-X',
      ['Rv'] = 'V-R',
      ['Rvc'] = 'RVC',
      ['Rvx'] = 'RVX',
      ['c'] = 'CMD',
      ['cv'] = 'EX',
      ['ce'] = 'EX',
      ['r'] = 'R',
      ['rm'] = 'M',
      ['r?'] = 'C',
      ['!'] = 'SH',
      ['t'] = 'TERM',
    }
    local function modes()
      return mode_map[vim.api.nvim_get_mode().mode] or '__'
    end

    require('lualine').setup {
      options = {
        -- theme = bubbles_theme,
        component_separators = '',
        -- section_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { modes },
        -- lualine_a = { 'mode' },
        lualine_b = { 'filename', 'searchcount', 'selectioncount', 'branch', 'diff' },
        lualine_c = { 'diagnostics', 'filetype' },
        lualine_x = { 'encoding', 'hostname' },
        lualine_y = { 'progress', 'location' },
        lualine_z = {
          function()
            return os.date('Time %R:%S')
          end,
        },
      },
      inactive_sections = {
        lualine_a = { modes },
        lualine_b = { 'filename', 'searchcount', 'selectioncount', 'branch', 'diff' },
        lualine_c = { 'diagnostics', 'filetype' },
        lualine_x = { 'encoding', 'hostname' },
        lualine_y = { 'progress', 'location' },
        lualine_z = {
          function()
            return os.date('Time %R:%S')
          end,
        },
      },

      tabline = {},
      extensions = {},
    }
  end
}

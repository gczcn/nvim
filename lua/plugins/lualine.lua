return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function get_date()
      return os.date('Date: %D %R:%S')
    end

    require('lualine').setup {
      options = {
        -- theme = bubbles_theme,
        component_separators = '',
        -- section_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { Util.simple_mode },
        -- lualine_a = { 'mode' },
        lualine_b = { 'filename', 'searchcount', 'selectioncount', 'branch', 'diff' },
        lualine_c = { 'diagnostics', 'filetype', 'filesize' },
        lualine_x = { 'encoding', 'hostname', 'fileformat' },
        lualine_y = { 'progress', 'location' },
        lualine_z = { get_date }
      },
      inactive_sections = {
        lualine_a = { Util.simple_mode },
        lualine_b = { 'filename', 'searchcount', 'selectioncount', 'branch', 'diff' },
        lualine_c = { 'diagnostics', 'filetype' },
        lualine_x = { 'encoding', 'hostname' },
        lualine_y = { 'progress', 'location' },
        lualine_z = { get_date }
      },

      tabline = {},
      extensions = {},
    }
  end
}

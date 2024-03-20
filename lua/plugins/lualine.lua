return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function get_date()
      return os.date('Date: %D %R:%S')
    end

    local function lsp_clients()
      local clients = vim.lsp.get_clients()
      local clients_list = {}
      for _, client in pairs(clients) do
        table.insert(clients_list, client.name)
      end
      return Utils.dump(clients_list)
    end

    require('lualine').setup({
      options = {
        -- theme = bubbles_theme,
        component_separators = '',
        -- section_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { Utils.simple_mode },
        lualine_b = { 'filename', 'searchcount', 'selectioncount', 'branch', 'diff' },
        lualine_c = { 'diagnostics', 'filetype', 'filesize' },
        lualine_x = { lsp_clients, 'encoding', 'hostname', 'fileformat' },
        lualine_y = { 'progress', 'location' },
        lualine_z = { get_date },
      },
      inactive_sections = {
        lualine_a = { Utils.simple_mode },
        lualine_b = { 'filename', 'searchcount', 'selectioncount', 'branch', 'diff' },
        lualine_c = { 'diagnostics', 'filetype' },
        lualine_x = { lsp_clients, 'encoding', 'hostname', 'fileformat' },
        lualine_y = { 'progress', 'location' },
        lualine_z = { get_date },
      },

      tabline = {},
      extensions = {},
    })
  end,
}

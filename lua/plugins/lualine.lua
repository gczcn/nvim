return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function get_date()
      return os.date('%D %R:%S')
    end

    local function lsp_clients()
      local clients = vim.lsp.get_clients()
      local clients_list = {}
      for _, client in pairs(clients) do
        table.insert(clients_list, client.name)
      end
      return Utils.dump(clients_list)
    end

    local default_sections = {
      lualine_a = { Utils.simple_mode },
      lualine_b = { 'filename', 'searchcount', 'selectioncount', 'branch', 'diff' },
      lualine_c = { 'diagnostics', 'filetype', 'filesize' },
      lualine_x = { 'tabnine', lsp_clients, 'encoding', 'hostname', 'fileformat' },
      lualine_y = { 'progress', 'location' },
      lualine_z = { get_date },
    }

    require('lualine').setup({
      options = {
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = default_sections,
      inactive_sections = default_sections,

      tabline = {},
      extensions = {},
    })
  end,
}

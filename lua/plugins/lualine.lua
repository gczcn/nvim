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
      lualine_x = {
        -- stylua: ignore
        {
          function() return require('noice').api.status.command.get() end,
          cond = function() return package.loaded['noice'] and require('noice').api.status.command.has() end,
          color = function()
            return { fg = Utils.get_hl('Statement', 'fg') }
          end
        },

        -- stylua: ignore
        {
          function() return require('noice').api.status.mode.get() end,
          cond = function() return package.loaded['noice'] and require('noice').api.status.mode.has() end,
          color = function()
            return { fg = Utils.get_hl('Constant', 'fg') }
          end
        },

        -- stylua: ignore
        {
          function() return '  ' .. require('dap').status() end,
          cond = function () return package.loaded['dap'] and require('dap').status() ~= '' end,
          color = function()
            return { fg = Utils.get_hl('Debug', 'fg') }
          end
        },

        {
          require('lazy.status').updates,
          cond = require('lazy.status').has_updates,
          color = function()
            return { fg = Utils.get_hl('Special', 'fg') }
          end
        },

        -- stylua: ignore
        lsp_clients, 'tabnine', 'encoding', 'hostname', 'fileformat' },
      lualine_y = { 'progress', 'location' },
      lualine_z = { get_date },
    }

    require('lualine').setup({
      options = {
        component_separators = '',
        section_separators = { left = '', right = '' },
        disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'starter' } },
      },
      sections = default_sections,
      inactive_sections = default_sections,

      tabline = {},
      extensions = {},
    })
  end,
}

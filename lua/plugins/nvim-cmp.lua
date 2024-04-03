return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer', -- source for text in buffer
    'hrsh7th/cmp-path', -- source for file system paths
    'L3MON4D3/LuaSnip', -- snippet engine
    'saadparwaiz1/cmp_luasnip', -- for autocompletion
    'rafamadriz/friendly-snippets', -- useful snippets
    'onsails/lspkind.nvim', -- vs-code like pictograms
    'hrsh7th/cmp-calc', -- nvim-cmp source for math calculation.
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lua', -- nvim-cmp source for neovim Lua API
    'ray-x/cmp-treesitter',
    {
      'tzachar/cmp-tabnine',
      build = './install.sh',
      dependencies = {
        'hrsh7th/nvim-cmp',
      },
      config = function ()
      end
    }
  },
  config = function()
    local fgdark = '#282828'
    local set_hl = vim.api.nvim_set_hl
    set_hl(0, 'CmpItemAbbrMatch', { fg = '#fe8019', bg = 'NONE', bold = true })
    set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#fe8019', bg = 'NONE', bold = true })
    set_hl(0, 'CmpItemAbbrDeprecated', { fg = '#7c6f64', bg = 'NONE', strikethrough = true })

    set_hl(0, 'CmpItemMenu', { fg = '#928374', bg = 'NONE', italic = true })
    set_hl(0, 'CmpItemKindField', { fg = fgdark, bg = '#fb4934' })
    set_hl(0, 'CmpItemKindProperty', { fg = fgdark, bg = '#fb4934' })
    set_hl(0, 'CmpItemKindEvent', { fg = fgdark, bg = '#fb4934' })

    set_hl(0, 'CmpItemKindText', { fg = fgdark, bg = '#b8bb26' })
    set_hl(0, 'CmpItemKindEnum', { fg = fgdark, bg = '#b8bb26' })
    set_hl(0, 'CmpItemKindKeyword', { fg = fgdark, bg = '#b8bb26' })

    set_hl(0, 'CmpItemKindConstant', { fg = fgdark, bg = '#fabd2f' })
    set_hl(0, 'CmpItemKindConstructor', { fg = fgdark, bg = '#fabd2f' })
    set_hl(0, 'CmpItemKindReference', { fg = fgdark, bg = '#fabd2f' })

    set_hl(0, 'CmpItemKindFunction', { fg = fgdark, bg = '#d3869b' })
    set_hl(0, 'CmpItemKindStruct', { fg = fgdark, bg = '#d3869b' })
    set_hl(0, 'CmpItemKindClass', { fg = fgdark, bg = '#d3869b' })
    set_hl(0, 'CmpItemKindModule', { fg = fgdark, bg = '#d3869b' })
    set_hl(0, 'CmpItemKindOperator', { fg = fgdark, bg = '#d3869b' })

    set_hl(0, 'CmpItemKindVariable', { fg = fgdark, bg = '#ebdbb2' })
    set_hl(0, 'CmpItemKindFile', { fg = fgdark, bg = '#7c6f64' })

    set_hl(0, 'CmpItemKindUnit', { fg = fgdark, bg = '#fe8019' })
    set_hl(0, 'CmpItemKindSnippet', { fg = fgdark, bg = '#fe8019' })
    set_hl(0, 'CmpItemKindFolder', { fg = fgdark, bg = '#fe8019' })

    set_hl(0, 'CmpItemKindMethod', { fg = fgdark, bg = '#83a598' })
    set_hl(0, 'CmpItemKindValue', { fg = fgdark, bg = '#83a598' })
    set_hl(0, 'CmpItemKindEnumMember', { fg = fgdark, bg = '#83a598' })

    set_hl(0, 'CmpItemKindInterface', { fg = fgdark, bg = '#8ec07c' })
    set_hl(0, 'CmpItemKindColor', { fg = fgdark, bg = '#8ec07c' })
    set_hl(0, 'CmpItemKindTypeParameter', { fg = fgdark, bg = '#8ec07c' })
    -- local limitStr = function(str)
    --   if #str > 25 then
    --     str = string.sub(str, 1, 22) .. '...'
    --   end
    --   return str
    -- end
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require('luasnip.loaders.from_vscode').lazy_load()
    require('lspkind').init({
      symbol_map = {
        Text = '󰉿',
        Method = '󰆧',
        Function = '󰊕',
        Constructor = '',
        Comment = '',
        Field = '󰜢',
        Variable = '󰀫',
        Class = '󰠱',
        Interface = '',
        Module = '',
        Property = '󰜢',
        Unit = '󰑭',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '󰏘',
        File = '󰈙',
        Reference = '󰈇',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰏿',
        String = '󰅳',
        Struct = '󰙅',
        Event = '',
        Operator = '󰆕',
        TabNine = 'A',
        TypeParameter = '',
      },
    })
    cmp.setup({
      window = {
        completion = {
          winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
          col_offset = -3,
          -- col_offset = 0,
          side_padding = 0,
        },
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          local kind = lspkind.cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, '%s', { trimempty = true })
          vim_item.kind = ' ' .. (strings[1] or '') .. ' '
          -- vim_item.kind = ' ' .. '114' ..  ' '
          vim_item.menu = ({
            path = '[FS]',
            buffer = '[BF]',
            nvim_lsp = '[LS]',
            luasnip = '[SN]',
            nvim_lua = '[LU]',
            calc = '[CC]',
            emoji = '[EM]',
            treesitter = '[TS]',
            cmp_tabnine = '[TN]',
          })[entry.source.name]
          vim_item.menu = vim_item.menu .. ' ' .. (strings[2] or '')
          return vim_item
        end,
      },
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      view = {
        entries = { name = 'custom', selection_order = 'near_cursor' },
      },

      mapping = cmp.mapping.preset.insert({
        ['<M-u>'] = cmp.mapping.select_prev_item(), -- previous suggestion
        ['<TAB>'] = cmp.mapping.select_next_item(), -- next suggestion
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<M-o>'] = cmp.mapping.complete(), -- show completion suggestions
        ['<M-e>'] = cmp.mapping.abort(), -- close completion window
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'calc' },
        { name = 'luasnip' }, -- snippets
        { name = 'nvim_lua' },
        { name = 'buffer' }, -- text within current buffer
        { name = 'path' }, -- file system paths
        { name = 'treesitter' },
        { name = 'cmp_tabnine' },
        { name = 'emoji' },
      }),
    })
  end,
}

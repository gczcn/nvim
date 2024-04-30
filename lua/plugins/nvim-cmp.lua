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
    'hrsh7th/cmp-nvim-lsp',
    'ray-x/cmp-treesitter',
    'neovim/nvim-lspconfig',
    {
      'tzachar/cmp-tabnine',
      enabled = vim.g.enabled_tabnine,
      build = './install.sh',
      dependencies = {
        'hrsh7th/nvim-cmp',
      },
      config = false,
    }
  },

  config = function()
    local set_hl = vim.api.nvim_set_hl

    set_hl(0, 'CmpItemMenu', { fg = Utils.get_hl('Comment', 'fg'), bg = 'NONE', italic = false })

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
        Number = '0'
      },
    })
    cmp.setup({
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          menu = ({
            path = '[Path]',
            buffer = '[Buffer]',
            nvim_lsp = '[LSP]',
            luasnip = '[LuaSnip]',
            nvim_lua = '[Lua]',
            latex_symbols = '[Latex]',
            calc = '[Calc]',
            emoji = '[Emoji]',
            treesitter = '[Treesitter]',
            cmp_tabnine = '[Tabnine]',
          })
        }),
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
        { name = 'cmp_tabnine' },
        { name = 'nvim_lua' },
        { name = 'buffer' }, -- text within current buffer
        { name = 'path' }, -- file system paths
        { name = 'treesitter' },
        { name = 'emoji' },
      }),
    })
  end,
}

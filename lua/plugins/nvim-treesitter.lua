return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { fileopened, 'VeryLazy' },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'lua',
          'luadoc',
          'luap',
          'python',
          'c',
          'html',
          'vim',
          'vimdoc',
          'javascript',
          'typescript',
          'bash',
          'diff',
          'jsdoc',
          'json',
          'jsonc',
          'toml',
          'yaml',
          'tsx',
          'markdown',
          'markdown_inline',
          'regex',
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            node_decremental = '<BS>',
            scope_incremental = '<TAB>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['kf'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['kc'] = '@class.inner',
            }
          },
        },
      })
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.wo.foldlevel = 90
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = { fileopened, 'VeryLazy' },
  }
}

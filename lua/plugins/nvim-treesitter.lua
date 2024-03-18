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
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { fileopened, 'VeryLazy' },
    config = function()
      local tscontext = require('treesitter-context')
      tscontext.setup {
        enable = true,
        max_lines = 0,        -- How many lines the window should span. Values <= 0 mean no limit
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',      -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
      vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = '#1d2021' })
      vim.keymap.set("n", "[c", function()
        tscontext.go_to_context()
        end, { silent = true })
    end
  },
}

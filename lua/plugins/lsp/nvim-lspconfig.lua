return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      local mason = require('mason')
      local mason_lspconfig = require('mason-lspconfig')
      mason.setup()
      -- enable mason and configure icons
      mason_lspconfig.setup({
        -- list of servers for mason to install
        ensure_installed = {
          'tsserver',
          'html',
          'cssls',
          'tailwindcss',
          'svelte',
          'lua_ls',
          'graphql',
          'emmet_ls',
          'prismals',
          'pyright',
          'omnisharp',
        },
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
      })
    end,
  },
  {
    'smjonas/inc-rename.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function ()
      require("inc_rename").setup({
        -- input_buffer_type = "dressing",
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local lspconfig = require('lspconfig')
      local cmp_nvim_lsp = require('cmp_nvim_lsp')
      local opts = { noremap = true, silent = true }
      local on_attach = function(_, bufnr)
        opts.buffer = bufnr

        -- set keybinds
        opts.desc = 'Show LSP references'
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts) -- show definition, references

        opts.desc = 'Go to declaration'
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = 'Show LSP definitions'
        vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts) -- show lsp definitions

        opts.desc = 'Show LSP implementations'
        vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts) -- show lsp implementations

        opts.desc = 'Show LSP type definitions'
        vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts) -- show lsp type definitions

        opts.desc = 'See available code actions'
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        -- inc-rename
        opts.desc = 'Smart rename'
        -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- smart rename
        vim.keymap.set('n', '<leader>rn', function ()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end, { noremap = true, expr = true })

        opts.desc = 'Show buffer diagnostics'
        vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts) -- show  diagnostics for file

        opts.desc = 'Show line diagnostics'
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = 'Go to previous diagnostic'
        vim.keymap.set('n', '<M-[>', vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = 'Go to next diagnostic'
        vim.keymap.set('n', '<M-]>', vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = 'Show documentation for what is under cursor'
        vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = 'Restart LSP'
        vim.keymap.set('n', '<leader>rs', '<cmd>LspRestart<CR>', opts) -- mapping to restart lsp if necessary
      end

      local capabilities = cmp_nvim_lsp.default_capabilities()

      local signs = { Error = 'Er', Warn = 'Wn', Hint = 'Ht', Info = 'Io' }
      -- local signs = { Error = ' E', Warn = ' W', Hint = ' H', Info = ' I' }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        local lhl = type .. 'Line'
        vim.fn.sign_define(hl, { name = hl, text = icon, texthl = hl, numhl = '', linehl = lhl })
      end

      -- configure html server
      lspconfig['html'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure typescript server with plugin
      lspconfig['tsserver'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure css server
      lspconfig['cssls'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure tailwindcss server
      lspconfig['tailwindcss'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure svelte server
      lspconfig['svelte'].setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)

          vim.api.nvim_create_autocmd('BufWritePost', {
            pattern = { '*.js', '*.ts' },
            callback = function(ctx)
              if client.name == 'svelte' then
                client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.file })
              end
            end,
          })
        end,
      })

      -- configure prisma orm server
      lspconfig['prismals'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure graphql language server
      lspconfig['graphql'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { 'graphql', 'gql', 'svelte', 'typescriptreact', 'javascriptreact' },
      })

      -- configure emmet language server
      lspconfig['emmet_ls'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
      })

      -- configure python server
      lspconfig['pyright'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure lua server (with special settings)
      lspconfig['lua_ls'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { -- custom settings for lua
          Lua = {
            -- make the language server recognize 'vim' global
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              -- make language server aware of runtime files
              library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.stdpath('config') .. '/lua'] = true,
              },
            },
          },
        },
      })

      -- configure C sharp language server
      lspconfig['omnisharp'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
        root_dir = function ()
          return vim.loop.cwd() -- current working directory
        end,
      })
    end
  },
  {
    'antosha417/nvim-lsp-file-operations',
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<CR>',           desc = 'Explorer NeoTree (user dir)', remap = true },
      { '<leader>E', '<cmd>Neotree dir=%:p:h toggle<CR>', desc = 'Explorer NeoTree (%f)',       remap = true },
      {
        '<leader>ge',
        function()
          require('neo-tree.command').execute({ source = 'git_status', toggle = true })
        end,
        desc = 'Git explorer',
      },
      {
        '<leader>be',
        function()
          require('neo-tree.command').execute({ source = 'buffers', toggle = true })
        end,
        desc = 'Buffer explorer',
      },
    },
    config = true,
  },
}

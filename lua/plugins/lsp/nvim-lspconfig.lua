return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'folke/neoconf.nvim', cmd = 'Neoconf', config = false, dependencies = { 'nvim-lspconfig' } },
    { 'folke/neodev.nvim', opts = {} },
    { 'smjonas/inc-rename.nvim', config = function() require('inc_rename').setup() end },
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')
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
      vim.keymap.set('n', '<leader>rn', function ()
        return ':IncRename ' .. vim.fn.expand('<cword>')
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

    local if_nil = function(val, default)
      if val == nil then return default end
      return val
    end

    local capabilities = function(override)
      override = override or {}

      return {
        textDocument = {
          completion = {
            dynamicRegistration = if_nil(override.dynamicRegistration, false),
            completionItem = {
              snippetSupport = if_nil(override.snippetSupport, true),
              commitCharactersSupport = if_nil(override.commitCharactersSupport, true),
              deprecatedSupport = if_nil(override.deprecatedSupport, true),
              preselectSupport = if_nil(override.preselectSupport, true),
              tagSupport = if_nil(override.tagSupport, {
                valueSet = {
                  1, -- Deprecated
                }
              }),
              insertReplaceSupport = if_nil(override.insertReplaceSupport, true),
              resolveSupport = if_nil(override.resolveSupport, {
                properties = {
                  'documentation',
                  'detail',
                  'additionalTextEdits',
                  'sortText',
                  'filterText',
                  'insertText',
                  'textEdit',
                  'insertTextFormat',
                  'insertTextMode',
                },
              }),
              insertTextModeSupport = if_nil(override.insertTextModeSupport, {
                valueSet = {
                  1, -- asIs
                  2, -- adjustIndentation
                }
              }),
              labelDetailsSupport = if_nil(override.labelDetailsSupport, true),
            },
            contextSupport = if_nil(override.snippetSupport, true),
            insertTextMode = if_nil(override.insertTextMode, 1),
            completionList = if_nil(override.completionList, {
              itemDefaults = {
                'commitCharacters',
                'editRange',
                'insertTextFormat',
                'insertTextMode',
                'data',
              }
            })
          },
        },
      }
    end

    local signs = { Error = 'Er', Warn = 'Wn', Hint = 'Ht', Info = 'Io' }
    -- local signs = { Error = ' E', Warn = ' W', Hint = ' H', Info = ' I' }

    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      local lhl = type .. 'Line'
      vim.fn.sign_define(hl, { name = hl, text = icon, texthl = hl, numhl = '', linehl = lhl })
    end

    local lsp_default_config = function()
      return {
        capabilities = capabilities(),
        on_attach = on_attach,
      }
    end

    -- configure html server
    lspconfig['html'].setup(lsp_default_config())

    -- configure typescript server with plugin
    lspconfig['tsserver'].setup(lsp_default_config())

    -- configure css server
    lspconfig['cssls'].setup(lsp_default_config())

    -- configure tailwindcss server
    lspconfig['tailwindcss'].setup(lsp_default_config())

    -- configure svelte server
    lspconfig['svelte'].setup({
      capabilities = capabilities(),
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
    lspconfig['prismals'].setup(lsp_default_config())

    -- configure graphql language server
    local graphql_config = lsp_default_config()
    graphql_config['filetypes'] = { 'graphql', 'gql', 'svelte', 'typescriptreact', 'javascriptreact' }

    lspconfig['graphql'].setup(graphql_config)

    -- configure emmet language server
    local emmet_config = lsp_default_config()
    emmet_config['filetypes'] = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' }

    lspconfig['emmet_ls'].setup(emmet_config)

    -- configure python server
    lspconfig['pyright'].setup(lsp_default_config())

    -- configure lua server (with special settings)
    lspconfig['lua_ls'].setup({
      capabilities = capabilities(),
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
      capabilities = capabilities(),
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
}

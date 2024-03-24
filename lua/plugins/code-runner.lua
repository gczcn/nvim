return {
  'CRAG666/code_runner.nvim',
  event = fileopened,
  config = function ()
    local setup = function ()
      require('code_runner').setup({
        filetype = {
          markdown = function ()
            vim.cmd [[MarkdownPreviewToggle]]
          end,
          java = {
            'cd $dir &&',
            'javac $fileName &&',
            'java $fileNameWithoutExt'
          },
          python = 'python3 $file ' .. vim.g.code_runner_run_args ,
          lua = 'lua $file ' .. vim.g.code_runner_run_args,
          typescript = 'deno run',
          rust = {
            'cd $dir &&',
            'rustc $fileName &&',
            '$dir/$fileNameWithoutExt'
          },
        },
      })
    end
    vim.g.code_runner_run_args = ''
    vim.keymap.set('n', '<leader>ra', function ()
      vim.ui.input({prompt = 'Input Args:'}, function (args)
        if args ~= nil then
          vim.g.code_runner_run_args = args
          setup()
        end
      end)
    end)
    vim.keymap.set('n', '<leader>r', '<cmd>RunCode<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>rf', '<cmd>RunFile<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>rft', '<cmd>RunFile tab<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>rp', '<cmd>RunProject<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>rc', '<cmd>RunClose<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>crf', '<CMD>CRFiletype<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>crp', '<cmd>CRProjects<CR>', { noremap = true, silent = false })
    setup()
  end
}

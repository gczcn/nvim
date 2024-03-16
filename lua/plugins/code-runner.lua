return {
  'CRAG666/code_runner.nvim',
  event = fileopened,
  config = function ()
    vim.keymap.set('n', '<leader>r', '<cmd>RunCode<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>rf', '<cmd>RunFile<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>rft', '<cmd>RunFile tab<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>rp', '<cmd>RunProject<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>rc', '<cmd>RunClose<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>crf', '<CMD>CRFiletype<CR>', { noremap = true, silent = false })
    vim.keymap.set('n', '<leader>crp', '<cmd>CRProjects<CR>', { noremap = true, silent = false })
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
        python = 'python3 -u',
        lua = 'lua',
        typescript = 'deno run',
        rust = {
          'cd $dir &&',
          'rustc $fileName &&',
          '$dir/$fileNameWithoutExt'
        },
      },
    })
  end
}

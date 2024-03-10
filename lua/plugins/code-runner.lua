return{
  'CRAG666/code_runner.nvim',
  event = fileopened,
  config = function ()
    map('n', '<leader>r', '<cmd>RunCode<CR>', { noremap = true, silent = false })
    map('n', '<leader>rf', '<cmd>RunFile<CR>', { noremap = true, silent = false })
    map('n', '<leader>rft', '<cmd>RunFile tab<CR>', { noremap = true, silent = false })
    map('n', '<leader>rp', '<cmd>RunProject<CR>', { noremap = true, silent = false })
    map('n', '<leader>rc', '<cmd>RunClose<CR>', { noremap = true, silent = false })
    map('n', '<leader>crf', '<CMD>CRFiletype<CR>', { noremap = true, silent = false })
    map('n', '<leader>crp', '<cmd>CRProjects<CR>', { noremap = true, silent = false })
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

return {
  'shellRaining/hlchunk.nvim',
  event = fileopened,
  config = function()
    require('hlchunk').setup({
      indent = {
        chars = { '│' },
      },
      blank = {
        enable = false,
      },
      chunk = {
        chars = {
          horizontal_line = '─',
          vertical_line = '│',
          left_top = '┌',
          left_bottom = '└',
          right_arrow = '─',
        },
        style = {
          { fg = '#b8bb26' },
          { fg = '#fb4934' },
        },
      },
      line_num = {
        style = '#fabd2f',
      },
    })
  end
}

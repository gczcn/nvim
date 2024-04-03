return {
  "sontungexpt/stcursorword",
  event = "VeryLazy",
  config = function ()
    require('stcursorword').setup({
      highlight = {
        underline = true,
        fg = nil,
        bg = '#3c3836',
      },
    })
  end,
}

return {
  'rcarriga/nvim-notify',
  event = 'VeryLazy',
  config = function()
    require('notify').setup({
      -- stages = static,
      -- render = wrapped-compact,
      level = 1,
      timeout = 1000,
    })
  end
}

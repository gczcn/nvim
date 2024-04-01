return {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>cg', '<cmd>ChatGPT<CR>' }
  },
  config = function()
    require('chatgpt').setup({
    })
  end
}

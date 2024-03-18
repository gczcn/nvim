return {
  "hedyhli/outline.nvim",
  cmd = 'Outline',
  keys = {
    { '<leader>ou', '<cmd>Outline<CR>', desc = 'Toggle Outline' }
  },
  config = function()
    -- Example mapping to toggle outline
    -- vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
    --   { desc = "Toggle Outline" })

    require("outline").setup {
      -- Your setup opts here (leave empty to use defaults)
    }
  end,
}

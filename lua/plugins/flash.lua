return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "j", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "<M-S>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "<leader>r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "<M-R>", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
}

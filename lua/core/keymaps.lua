vim.g.mapleader      = ' '
vim.g.maplocalleader = '\\'
vim.o.timeoutlen     = 300

local nvo            = { 'n', 'v', 'o' }
local nv             = { 'n', 'v' }
local v              = { 'v' }
local i              = { 'i' }
local ic             = { 'i', 'c' }
local it             = { 'i', 't' }
local c              = { 'c' }

local nmappings      = {

  { from = 'S',          to = '<cmd>w<CR>' },
  { from = 'Q',          to = '<cmd>q<CR>' },
  { from = '<leader>bd', to = '<cmd>bd<CR>' },
  { from = ';',          to = ':',                                   mode = nv },
  { from = 'Y',          to = '"+y',                                 mode = nv },
  { from = 'P',          to = '"+gp',                                mode = nv },
  { from = '<M-v>',      to = '<cmd>normal"+gp<CR><right>',          mode = i },
  { from = '`',          to = '~',                                   mode = nv },
  { from = '<M-q>',      to = '<ESC>',                               mode = i },

  -- Movement
  { from = 'u',          to = 'k',                                   mode = nvo },
  { from = 'e',          to = 'j',                                   mode = nvo },
  { from = 'n',          to = 'h',                                   mode = nvo },
  { from = 'i',          to = 'l',                                   mode = nvo },
  { from = 'U',          to = '5k',                                  mode = nvo },
  { from = 'E',          to = '5j',                                  mode = nvo },
  { from = 'N',          to = '0',                                   mode = nvo },
  { from = 'I',          to = '$',                                   mode = nvo },
  { from = '<M-u>',      to = '<up>',                                mode = i },
  { from = '<M-e>',      to = '<down>',                              mode = i },
  { from = '<M-n>',      to = '<left>',                              mode = ic },
  { from = '<M-i>',      to = '<right>',                             mode = ic },
  { from = '<M-U>',      to = '<cmd>normal! 5k<CR>',                 mode = i },
  { from = '<M-E>',      to = '<cmd>normal! 5j<CR>',                 mode = i },
  { from = '<M-N>',      to = '<cmd>normal! 0<CR>',                  mode = i },
  { from = '<M-I>',      to = '<cmd>normal! $<CR><right>',           mode = i },
  { from = '<M-N>',      to = '<left><left><left><left><left>',      mode = c },
  { from = '<M-I>',      to = '<right><right><right><right><right>', mode = c },
  { from = 'h',          to = 'e',                                   mode = nv },
  { from = 'W',          to = '5w',                                  mode = nv },
  { from = 'B',          to = '5b',                                  mode = nv },

  -- Actions
  { from = 'l',          to = 'u',                                   mode = nv },
  { from = 'L',          to = '<C-r>',                               mode = nv },
  { from = 'k',          to = 'i',                                   mode = nv },
  { from = 'K',          to = 'I',                                   mode = nv },

  -- Move block
  { from = '+',          to = ":m '>+1<CR>gv=gv",                    mode = v },
  { from = '-',          to = ":m '<-2<CR>gv=gv",                    mode = v },
  { from = '+',          to = "v:m '>+1<CR>gv=gv<ESC>" },
  { from = '-',          to = "v:m '<-2<CR>gv=gv<ESC>" },

  -- Window & splits
  { from = '<leader>wu', to = '<C-w>k' },
  { from = '<leader>we', to = '<C-w>j' },
  { from = '<leader>wn', to = '<C-w>h' },
  { from = '<leader>wi', to = '<C-w>l' },
  { from = '<leader>wv', to = '<C-w>v' },
  { from = '<leader>ws', to = '<C-w>s' },

  -- Resize
  { from = '<M-U>',      to = '<cmd>resize +2<CR>' },
  { from = '<M-E>',      to = '<cmd>resize -2<CR>' },
  { from = '<M-N>',      to = '<cmd>vertical resize -2<CR>' },
  { from = '<M-I>',      to = '<cmd>vertical resize +2<CR>' },
  { from = '<C-u>',      to = '<cmd>resize +2<CR>',                  mode = it },
  { from = '<C-e>',      to = '<cmd>resize -2<CR>',                  mode = it },
  { from = '<C-n>',      to = '<cmd>vertical resize -2<CR>',         mode = it },
  { from = '<C-i>',      to = '<cmd>vertical resize +2<CR>',         mode = it },

  -- Number
  { from = '<M-a>',      to = '1',                                   mode = nvo },
  { from = '<M-r>',      to = '2',                                   mode = nvo },
  { from = '<M-s>',      to = '3',                                   mode = nvo },
  { from = '<M-t>',      to = '4',                                   mode = nvo },
  { from = '<M-d>',      to = '5',                                   mode = nvo },
  { from = '<M-h>',      to = '6',                                   mode = nvo },
  { from = '<M-n>',      to = '7',                                   mode = nvo },
  { from = '<M-e>',      to = '8',                                   mode = nvo },
  { from = '<M-i>',      to = '9',                                   mode = nvo },
  { from = '<M-o>',      to = '0',                                   mode = nvo },

  -- Pairs
  { from = '<M-BS>',     to = '<BS><Del>',                           mode = i },
  { from = '<M-[>',      to = '[]<left>',                            mode = i },
  { from = '<M-{>',      to = '{}<left>',                            mode = i },
  { from = '<M-(>',      to = '()<left>',                            mode = i },
  { from = '<M-<>',      to = '<><left>',                            mode = i },
  { from = "<M-'>",      to = "''<left>",                            mode = i },
  { from = '<M-`>',      to = '``<left>',                            mode = i },
  { from = '<M-">',      to = '""<left>',                            mode = i },
  { from = '<M-#>',      to = '##<left>',                            mode = i },
  { from = '<M-t>',      to = '<CR><ESC>O',                          mode = i },

  -- Other
  {
    from = '<M-c>',
    to = function()
      if vim.o.cursorcolumn == true then
        vim.o.cursorcolumn = false
      else
        vim.o.cursorcolumn = true
      end
    end
  },
  {
    from = '<leader>zs',
    to = function()
      vim.ui.input(
        { prompt = 'Do you want to replace all tab characters with the corresponding number of spaces? [y/N]' },
        function(zsinput)
          if zsinput == 'y' or zsinput == 'yes' then
            local space = ''
            for _ = 0, vim.o.shiftwidth - 1 do
              space = space .. ' '
            end
            local zscmd = '%s/\t/' .. space .. '/g'
            vim.cmd(zscmd)
            vim.cmd('noh')
          end
        end)
    end
  },
  { from = '<leader>l', to = '<cmd>noh<CR>', mode = nv },

}

for _, mapping in ipairs(nmappings) do
  -- map(mapping.mode or 'n', mapping.from, mapping.to, { noremap = true, silent = true })
  map(mapping.mode or 'n', mapping.from, mapping.to, { noremap = true })
end

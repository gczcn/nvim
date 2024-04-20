vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.o.timeout = true
vim.o.timeoutlen = 300

local nvo = { 'n', 'v', 'o' }
local nv  = { 'n', 'v' }
local v   = { 'v' }
local i   = { 'i' }
local ic  = { 'i', 'c' }
local it  = { 'i', 't' }

local nmappings = {
  { from = 'S',           to = '<cmd>w<CR>' },
  { from = 'Q',           to = '<cmd>q<CR>' },
  { from = ';',           to = ':',                                                              mode = nv },
  { from = '<M-y>',       to = '"+y',                                                            mode = nv },
  { from = '<M-Y>',       to = '"+Y',                                                            mode = nv },
  { from = '<M-p>',       to = '"+p',                                                            mode = nv },
  { from = '<M-P>',       to = '"+P',                                                            mode = nv },
  { from = 'vr',          to = '`[v`]' },
  { from = '`',           to = '~<left>' },
  { from = '`',           to = '~',                                                              mode = v },
  { from = '<M-q>',       to = '<ESC>',                                                          mode = iv },
  { from = '<leader>sni', to = '<cmd>noh<CR>' },

  -- Movement
  { from = 'u',           to = 'k',                                                              mode = nvo },
  { from = 'e',           to = 'j',                                                              mode = nvo },
  { from = 'n',           to = 'h',                                                              mode = nvo },
  { from = 'i',           to = 'l',                                                              mode = nvo },
  { from = 'U',           to = '5k',                                                             mode = nvo },
  { from = 'E',           to = '5j',                                                             mode = nvo },
  { from = 'N',           to = '0',                                                              mode = nvo },
  { from = 'I',           to = '$',                                                              mode = nvo },
  { from = '<M-u>',       to = '<up>',                                                           mode = i },
  { from = '<M-e>',       to = '<down>',                                                         mode = i },
  { from = '<M-n>',       to = '<left>',                                                         mode = ic },
  { from = '<M-i>',       to = '<right>',                                                        mode = ic },
  { from = '<M-U>',       to = '<cmd>normal! 5k<CR>',                                            mode = i },
  { from = '<M-E>',       to = '<cmd>normal! 5j<CR>',                                            mode = i },
  { from = '<M-N>',       to = '<cmd>normal! 0<CR>',                                             mode = i },
  { from = '<M-I>',       to = '<cmd>normal! $<CR><right>',                                      mode = i },
  { from = '<M-N>',       to = '<left><left><left><left><left>',                                 mode = c },
  { from = '<M-I>',       to = '<right><right><right><right><right>',                            mode = c },
  { from = 'h',           to = 'e',                                                              mode = nv },
  { from = 'W',           to = '5w',                                                             mode = nv },
  { from = 'B',           to = '5b',                                                             mode = nv },

  -- Actions
  { from = 'l',           to = 'u',                                                              mode = nv },
  { from = 'L',           to = '<C-r>',                                                          mode = nv },
  { from = 'k',           to = 'i',                                                              mode = nv },
  { from = 'K',           to = 'I',                                                              mode = nv },

  -- Move block
  { from = '+',           to = ":m '>+1<CR>gv=gv",                                               mode = v },
  { from = '-',           to = ":m '<-2<CR>gv=gv",                                               mode = v },

  -- Window & splits
  { from = '<leader>ww',  to = '<C-w>w' },
  { from = '<leader>wu',  to = '<C-w>k' },
  { from = '<leader>we',  to = '<C-w>j' },
  { from = '<leader>wn',  to = '<C-w>h' },
  { from = '<leader>wi',  to = '<C-w>l' },
  { from = 'su',          to = '<cmd>set nosplitbelow<CR><cmd>split<CR><cmd>set splitbelow<CR>' },
  { from = 'se',          to = '<cmd>set splitbelow<CR><cmd>split<CR>' },
  { from = 'sn',          to = '<cmd>set nosplitright<CR><cmd>vsplit<CR><cmd>set splitright<CR>' },
  { from = 'si',          to = '<cmd>set splitright<CR><cmd>vsplit<CR>' },
  { from = 'sv',          to = '<C-w>t<C-w>H' },
  { from = 'sh',          to = '<C-w>t<C-w>K' },
  { from = 'srv',         to = '<C-w>b<C-w>H' },
  { from = 'srh',         to = '<C-w>b<C-w>K' },

  -- Resize
  { from = '<M-u>',       to = '<cmd>resize +2<CR>' },
  { from = '<M-e>',       to = '<cmd>resize -2<CR>' },
  { from = '<M-n>',       to = '<cmd>vertical resize -2<CR>' },
  { from = '<M-i>',       to = '<cmd>vertical resize +2<CR>' },

  -- Pairs
  { from = '<M-<>',       to = '<><left>',                                                       mode = ic },
  { from = '<M-#>',       to = '##<left>',                                                       mode = ic },
  { from = '<M-BS>',      to = '<BS><Del>',                                                      mode = c },
  { from = '<M-[>',       to = '[]<left>',                                                       mode = c },
  { from = '<M-{>',       to = '{}<left>',                                                       mode = c },
  { from = '<M-(>',       to = '()<left>',                                                       mode = c },
  { from = "<M-'>",       to = "''<left>",                                                       mode = c },
  { from = '<M-`>',       to = '``<left>',                                                       mode = c },
  { from = '<M-">',       to = '""<left>',                                                       mode = c },

  -- Buffer
  { from = '<leader>bd',  to = '<cmd>bd<CR>' },

  -- Other
  {
    from = '<leader>cts',
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
}

for _, mapping in ipairs(nmappings) do
  vim.keymap.set(mapping.mode or 'n', mapping.from, mapping.to, { noremap = mapping.noremap or true, desc = mapping.desc or nil })
end

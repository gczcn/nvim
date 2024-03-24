vim.g.mapleader      = ' '
vim.g.maplocalleader = '\\'
vim.o.timeout        = true
vim.o.timeoutlen     = 300

local nvo            = { 'n', 'v', 'o' }
local nv             = { 'n', 'v' }
local v              = { 'v' }
local i              = { 'i' }
local ic             = { 'i', 'c' }
local it             = { 'i', 't' }
local c              = { 'c' }
local t              = { 't' }

local nmappings      = {
  { from = 'S',           to = '<cmd>w<CR>' },
  { from = 'Q',           to = '<cmd>q<CR>' },
  { from = '<leader>bd',  to = '<cmd>bd<CR>' },
  { from = ';',           to = ':',                                                              mode = nv },
  { from = '<M-y>',       to = '"+y',                                                            mode = nv },
  { from = '<M-Y>',       to = '"+Y',                                                            mode = nv },
  { from = '<M-p>',       to = '"+p',                                                            mode = nv,},
  { from = '<M-P>',       to = '"+P',                                                            mode = nv,},
  { from = 'vr',          to = '`[v`]', },
  { from = '<M-v>',       to = '<cmd>normal! "+P<CR>',                                           mode = it },
  { from = '`',           to = '~<left>', },
  { from = '`',           to = '~',                                                              mode = v },
  { from = '<M-q>',       to = '<ESC>',                                                          mode = i },

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
  { from = '+',           to = "v:m '>+1<CR>gv=gv<ESC>" },
  { from = '-',           to = "v:m '<-2<CR>gv=gv<ESC>" },

  -- Window & splits
  { from = '<leader>ww',  to = '<C-w>w' },
  { from = '<leader>wu',  to = '<C-w>k' },
  { from = '<leader>we',  to = '<C-w>j' },
  { from = '<leader>wn',  to = '<C-w>h' },
  { from = '<leader>wi',  to = '<C-w>l' },
  { from = '<leader>su',  to = '<cmd>set nosplitbelow<CR><cmd>split<CR><cmd>set splitbelow<CR>' },
  { from = '<leader>se',  to = '<cmd>set splitbelow<CR><cmd>split<CR>' },
  { from = '<leader>sn',  to = '<cmd>set nosplitright<CR><cmd>vsplit<CR><cmd>set splitright<CR>' },
  { from = '<leader>si',  to = '<cmd>set splitright<CR><cmd>vsplit<CR>' },
  { from = '<leader>sv',  to = '<C-w>t<C-w>H' },
  { from = '<leader>sh',  to = '<C-w>t<C-w>K' },
  { from = '<leader>srv', to = '<C-w>b<C-w>H' },
  { from = '<leader>srh', to = '<C-w>b<C-w>K' },

  -- Resize
  { from = '<M-U>',       to = '<cmd>resize +2<CR>' },
  { from = '<M-E>',       to = '<cmd>resize -2<CR>' },
  { from = '<M-N>',       to = '<cmd>vertical resize -2<CR>' },
  { from = '<M-I>',       to = '<cmd>vertical resize +2<CR>' },
  { from = '<C-u>',       to = '<cmd>resize +2<CR>',                                             mode = it },
  { from = '<C-e>',       to = '<cmd>resize -2<CR>',                                             mode = it },
  { from = '<C-n>',       to = '<cmd>vertical resize -2<CR>',                                    mode = it },
  { from = '<C-i>',       to = '<cmd>vertical resize +2<CR>',                                    mode = it },

  -- Number
  { from = '<M-a>',       to = '1',                                                              mode = nvo },
  { from = '<M-r>',       to = '2',                                                              mode = nvo },
  { from = '<M-s>',       to = '3',                                                              mode = nvo },
  { from = '<M-t>',       to = '4',                                                              mode = nvo },
  { from = '<M-d>',       to = '5',                                                              mode = nvo },
  { from = '<M-h>',       to = '6',                                                              mode = nvo },
  { from = '<M-n>',       to = '7',                                                              mode = nvo },
  { from = '<M-e>',       to = '8',                                                              mode = nvo },
  { from = '<M-i>',       to = '9',                                                              mode = nvo },
  { from = '<M-o>',       to = '0',                                                              mode = nvo },

  -- Pairs
  { from = '<M-BS>',      to = '<BS><Del>',                                                      mode = ic },
  { from = '<M-[>',       to = '[]<left>',                                                       mode = ic },
  { from = '<M-{>',       to = '{}<left>',                                                       mode = ic },
  { from = '<M-(>',       to = '()<left>',                                                       mode = ic },
  { from = '<M-<>',       to = '<><left>',                                                       mode = ic },
  { from = "<M-'>",       to = "''<left>",                                                       mode = ic },
  { from = '<M-`>',       to = '``<left>',                                                       mode = ic },
  { from = '<M-">',       to = '""<left>',                                                       mode = ic },
  { from = '<M-#>',       to = '##<left>',                                                       mode = ic },
  { from = '<M-t>',       to = '<CR><ESC>O',                                                     mode = i },

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
  { from = '<leader>l',   to = '<cmd>noh<CR>',                                                     mode = nv },
  { from = '<leader>mm',  to = '<cmd>Menu<CR>' },
  { from = '<M-n>',       to = '<C-\\><C-n>',                                                      mode = t },
  { from = '<M-=>',       to = function ()
    vim.cmd('normal! ciw' .. vim.fn.expand('<cword>') + 1)
  end },
  { from = '<M-->',       to = function ()
    vim.cmd('normal! ciw' .. vim.fn.expand('<cword>') - 1)
  end },

}

for _, mapping in ipairs(nmappings) do
  -- map(mapping.mode or 'n', mapping.from, mapping.to, { noremap = true, silent = true })
  vim.keymap.set(mapping.mode or 'n', mapping.from, mapping.to, { noremap = mapping.noremap or true, desc = mapping.desc or nil })
end

Utils.menu_game = function()
  vim.ui.select({
    '< Back',
    '  Cellular automaton',
    '  Nvimesweeper',
    '  Speedtyper',
    '  Tetris',
  }, { prompt = 'Game' }, function(game_name)
    if game_name ~= nil then
      if game_name == '< Back' then
        vim.cmd('Menu')
      elseif game_name == '  Cellular automaton' then
        vim.ui.select({ '  make_it_rain', '  game_of_life' }, { prompt = 'Select Game' }, function(ca_mode)
          vim.cmd('CellularAutomaton ' .. ca_mode)
        end)
      else
        vim.cmd(game_name)
      end
    end
  end)
end

Utils.menu = function()
  vim.ui.select({
    '> Game',
  }, { prompt = 'Menu' }, function(input)
    if input ~= nil then
      vim.cmd('Menu' .. string.sub(input, 3))
    end
  end)
end

vim.cmd('command! Menu :lua Utils.menu()')
vim.cmd('command! MenuGame :lua Utils.menu_game()')

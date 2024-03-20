Utils.moremenu = function()
  vim.ui.select({ 'game list', 'plugins' }, { prompt = 'Menu' }, function(select_a)
    if select_a == 'game list' then
      vim.ui.select({ 'Tetris', 'Speedtyper', 'cellular automaton' }, { prompt = 'Select Game' }, function(game_name)
        if game_name ~= nil then
          if game_name == 'cellular automaton' then
            vim.ui.select({ 'make_it_rain', 'game_of_life' }, { prompt = 'Select Game' }, function(ca_mode)
              vim.cmd('CellularAutomaton ' .. ca_mode)
            end)
          else
            vim.cmd(game_name)
          end
        end
      end)
    end
  end)
end

vim.cmd('command! Menu :lua Utils.moremenu()')

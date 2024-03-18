Util.moremenu = function ()
  vim.ui.select({'game list', 'plugins'}, {prompt = 'More'}, function (select_a)
    if select_a == 'game list' then
      vim.ui.select({'Tetris', 'Speedtyper'}, {prompt = 'Select Game'}, function (game_name)
        if game_name ~= nil then
          vim.cmd(game_name)
        end
      end)
    end
  end)
end

vim.cmd('command! MoreMenu :lua Util.moremenu()')

Utils.get_hl = function (n, color)
  run = true
  name = n
  while run do
    hl = vim.api.nvim_get_hl(0, {name = name})

    if hl['link'] == nil then
      run = false
      if hl[color] ~= nil then
        return '#' .. string.format('%X', hl[color])
      else
        return '#000000'
      end
    end

    name = hl['link']
  end
end

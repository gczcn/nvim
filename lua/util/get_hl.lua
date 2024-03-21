Utils.get_hl = function (ns_id, opts, color)
  return '#' .. string.format('%X', vim.api.nvim_get_hl(ns_id, opts)[color])
end

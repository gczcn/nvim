local font = 'Terminus (TTF)'
local default_fontsize = 12
local symbol = 'Terminess Nerd Font Mono'

-- vim.o.guifont = font .. ':h' .. default_fontsize
vim.o.guifont = font .. ',' .. symbol .. ':h' .. default_fontsize
vim.g.neovide_floating_blur_amount_x = 1.5
vim.g.neovide_floating_blur_amount_y = 1.5
vim.g.neovide_scroll_animation_length = 0.15
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_unlink_border_highlights = true
vim.g.neovide_confirm_quit = true
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_cursor_unfocused_outline_width = 0.1
vim.g.neovide_cursor_vfx_mode = 'pixiedust'
vim.g.neovide_remember_window_size = true
vim.g.neovide_input_macos_alt_is_meta = true

vim.opt.pumblend = 35
vim.opt.winblend = 35

local get_guifontsize = function ()
  return string.split(vim.o.guifont, ':h')[2]
end

vim.keymap.set('n', '<C-->', function ()
  vim.o.guifont = font .. ',' .. symbol .. ':h' .. get_guifontsize() - 1
  print(get_guifontsize())
end, {noremap = true, desc = 'Increase gui font size'})

vim.keymap.set('n', '<C-=>', function ()
  vim.o.guifont = font .. ',' .. symbol .. ':h' .. get_guifontsize() + 1
  print(get_guifontsize())
end, {noremap = true, desc = 'Reduce gui font size'})

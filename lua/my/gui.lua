local g = vim.g
local o = require'my.utils'.opts.o

if vim.fn.has('macunix') then
  o.guifont = 'FiraCode Nerd Font Mono:h15'
  g.neovide_cursor_vfx_mode = 'railgun'
end

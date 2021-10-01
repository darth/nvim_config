local utils = require 'my.utils'

local function map(m, c)
  local opts = {silent = true}
  local cmd = '<cmd>exe (v:count ? v:count : "")."' .. c
  utils.map('no', ']' .. m, cmd .. 'next"<CR>', opts)
  utils.map('no', ']' .. string.upper(m), cmd .. 'last"<CR>', opts)
  utils.map('no', '[' .. m, cmd .. 'prev"<CR>', {})
  utils.map('no', '[' .. string.upper(m), cmd .. 'first"<CR>', opts)
end

map('a', '')
map('b', 'b')
map('q', 'c')
map('l', 'l')

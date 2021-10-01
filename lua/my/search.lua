local utils = require 'my.utils'
local o = utils.opts.o
local map = utils.map

o.smartcase = true
o.ignorecase = true
o.incsearch = true
o.inccommand = 'nosplit'
o.showmatch = true
o.hlsearch = true
o.gdefault = true
map('n', '<leader><space>', '<cmd>noh<CR>', {})
map('nx', '&', '<cmd>&&<CR>', {})

local g = vim.g
local map = require'my.utils'.map
local command_alias = require'my.utils'.command_alias

g.grepper = {tools = {'rg', 'grep'}}

map('n', '<leader>*', '<cmd>Grepper -cword -noprompt<CR>', {})

map('nx', 'gs', '<plug>(GrepperOperator)', {noremap = false})

command_alias('grep', 'GrepperRg')

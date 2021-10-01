local map = require'my.utils'.map

map('n', '<leader>gs', '<cmd>Git<CR>', {silent = true})
map('n', '<leader>gc', '<cmd>Git commit<CR>', {silent = true})
map('n', '<leader>gd', '<cmd>Gdiff<CR>', {silent = true})

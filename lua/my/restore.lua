local augroup = require'my.utils'.augroup

augroup("restore", {
  {
    'BufReadPost', '*',
    [[if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]
  }
})

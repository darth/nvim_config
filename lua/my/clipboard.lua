if vim.fn.has('macunix') == 1 then
  vim.g.clipboard = {
    name = 'smart',
    copy = {['+'] = 'rcopy', ['*'] = 'rcopy'},
    paste = {['+'] = 'rpaste', ['*'] = 'rpaste'}
  }
end

if vim.fn.has('macunix') then
  vim.g.clipboard = {
    name = 'smart',
    copy = {['+'] = 'rcopy', ['*'] = 'rcopy'},
    paste = {['+'] = 'rpaste', ['*'] = 'rpaste'}
  }
end

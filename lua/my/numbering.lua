local utils = require 'my.utils'
local w = utils.opts.w
local augroup = utils.augroup

w.number = true
w.relativenumber = true
augroup('numbertoggle', {
  {
    'BufEnter,FocusGained,InsertLeave', '*',
    'if buflisted(bufnr("")) | set relativenumber | endif'
  }, {
    'BufLeave,FocusLost,InsertEnter', '*',
    'if buflisted(bufnr("")) | set norelativenumber | endif'
  }
})

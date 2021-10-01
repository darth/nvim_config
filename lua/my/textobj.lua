local utils = require 'my.utils'
local g = vim.g
local augroup = utils.augroup

g.textobj_entire_no_default_key_mappings = 1
augroup('textobj-entire', {
  {
    'BufEnter', '*',
    'call textobj#user#map("entire", {"-": {"select-a": "aE", "select-i": "iE"}})'
  }
})

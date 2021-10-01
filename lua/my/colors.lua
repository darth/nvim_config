local utils = require 'my.utils'
local cmd = vim.cmd
local g = vim.g
local o = utils.opts.o
local augroup = utils.augroup

o.termguicolors = true
g.nord_bold = 1
g.nord_italic = 1
g.nord_underline = 1
cmd 'colorscheme nord'
augroup('nord-overrides', {
  {'ColorScheme', 'nord', 'highlight Comment guifg=#7B88A1 gui=bold'},
  {'ColorScheme', 'nord', 'highlight Folded guifg=#7B88A1'},
  {'ColorScheme', 'nord', 'highlight FoldColumn guifg=#7B88A1'},
  {'ColorScheme', 'nord', 'highlight pythonSelf guifg=#81A1C1 gui=italic'}
})

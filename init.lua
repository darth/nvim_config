local utils = require 'my.utils'
local cmd = vim.cmd
local g = vim.g
local env = vim.env
local o = utils.opts.o
local b = utils.opts.b
local w = utils.opts.w
local map = utils.map

o.shortmess = o.shortmess .. 'I'
o.hidden = true
b.undofile = true
o.mouse = 'a'
g.mapleader = '\\'
g.loaded_python_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.python3_host_prog = 'python3'
w.list = true
w.listchars = 'tab:▸ ,eol:¬'
w.cursorline = true
w.colorcolumn = '81'
o.wildmenu = true
o.wildmode = 'list:longest'
o.backspace = 'indent,eol,start'
w.signcolumn = 'yes:1'
map('c', '<c-p>', 'wildmenumode() ? "<c-p>" : "<up>"', {expr = true})
map('c', '<c-n>', 'wildmenumode() ? "<c-n>" : "<down>"', {expr = true})

g.smoothie_experimental_mappings = true

cmd 'autocmd TextYankPost * lua vim.highlight.on_yank {timeout = 500}'
map('n', '<space>', 'za', {})
map('n', '<leader>c', '<cmd>close<CR>', {})

require 'my.plugins'
require 'my.search'
require 'my.numbering'
require 'my.colors'
require 'my.clipboard'
require 'my.restore'
require 'my.quickfix'
require 'my.spell'
require 'my.statusline'
require 'my.gui'
require 'my.textobj'
require 'my.unimpaired'
require 'my.bufdel'
require 'my.fugitive'
require 'my.grepper'
require 'my.matchup'
require 'my.scrollbar'
require 'my.closetag'
require'my.indent'.setup {width = 2}
require'my.terminal'.setup {perc = 0.8, keymap = '<leader>t'}
require'bufferline'.setup {options = {separator_style = "slant"}}

cmd 'runtime fzf.vim'

env.VISUAL = 'nvr -cc split --remote-wait +"set bufhidden=wipe"'

require'indent_guides'.setup {
  indent_guide_size = 4,
  even_colors = {fg = '#3B4252', bg = '#3B4252'},
  odd_colors = {fg = '#434C5E', bg = '#434C5E'},
  exclude_filetypes = {'ToggleTerminal', 'help'}
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'bash', 'c', 'cpp', 'css', 'go', 'json', 'lua', 'python',
  },
  highlight = {enable = true, disable = {}}
}

if (env.DEVMODE) then
  require'my.completion'.setup {
    complete = '<c-x><c-o>',
    confirm = '<c-y>',
    close = '<c-e>',
    snip_next = '<c-j>',
    snip_prev = '<c-k>'
  }
  require 'my.lsp'
  require'lspfuzzy'.setup {}
  require'lspkind'.init {}
  require 'my.vimtex'
end

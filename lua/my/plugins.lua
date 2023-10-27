local fn = vim.fn
local cmd = vim.cmd

cmd 'packadd paq-nvim'

local paq = require 'paq'

paq {
  'savq/paq-nvim',

  'tweekmonster/startuptime.vim',

  'arcticicestudio/nord-vim',

  'tpope/vim-commentary',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-fugitive',
  'tpope/vim-obsession',
  'tpope/vim-projectionist',
  'tpope/vim-eunuch',
  'tpope/vim-dispatch',
  'radenling/vim-dispatch-neovim',

  'kana/vim-textobj-user',
  'kana/vim-textobj-function',
  'kana/vim-textobj-entire',

  'andymass/vim-matchup',
  'alvan/vim-closetag',

  'lukas-reineke/indent-blankline.nvim',
  'kyazdani42/nvim-web-devicons',
  'akinsho/nvim-bufferline.lua',
  'hoob3rt/lualine.nvim',
  'psliwka/vim-smoothie',

  'junegunn/fzf',
  'junegunn/fzf.vim',

  'mhinz/vim-grepper',

  'vim-utils/vim-husk',
  'editorconfig/editorconfig-vim',

  'pboettch/vim-cmake-syntax',
  'lifepillar/pgsql.vim',
  'tweekmonster/braceless.vim',
  'othree/javascript-libraries-syntax.vim',
  'yuezk/vim-js',
  'maxmellon/vim-jsx-pretty',
  'nfnty/vim-nftables',

  'vim-scripts/modelica',
  'bohlender/vim-smt2',
  'wannesm/wmnusmv.vim',

  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
}

if (vim.env.DEVMODE) then
  paq {
    'neovim/nvim-lspconfig',
    'onsails/lspkind-nvim',
    'ojroques/nvim-lspfuzzy',
    'hrsh7th/vim-vsnip',
    'hrsh7th/nvim-compe',
    'squareys/vim-cmake',
    'lervag/vimtex',
    {'iamcco/markdown-preview.nvim', build = fn['mkdp#util#install']},
  }
end

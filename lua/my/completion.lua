local g = vim.g
local utils = require 'my.utils'
local o = utils.opts.o
local map = utils.map

o.completeopt = 'menuone,noselect'

g.loaded_compe_snippets_nvim = true
g.loaded_compe_treesitter = true
g.loaded_compe_spell = true
g.loaded_compe_vim_lsc = true
g.loaded_compe_vim_lsp = true
g.loaded_compe_tags = true
g.loaded_compe_calc = true
g.loaded_compe_ultisnips = true
g.loaded_compe_path = true
g.loaded_compe_omni = true

require'compe'.setup {
  max_abbr_width = 50,
  max_kind_width = 50,
  max_menu_width = 50,
  source = {buffer = true, vsnip = true, nvim_lsp = true, nvim_lua = true}
}

return {
  setup = function(args)
    map('i', args.complete, 'compe#complete()', {expr = true, silent = true})
    map('i', args.confirm, 'compe#confirm("' .. args.confirm .. '")',
        {expr = true, silent = true})
    map('i', args.close, 'compe#close("' .. args.close .. '")',
        {expr = true, silent = true})
    map('is', args.snip_next,
        'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "' .. args.snip_next ..
            '"', {expr = true, noremap = false, silent = true})
    map('is', args.snip_prev,
        'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "' .. args.snip_prev ..
            '"', {expr = true, noremap = false, silent = true})
  end
}

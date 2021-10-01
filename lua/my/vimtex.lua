local fn = vim.fn
local g = vim.g

g.tex_flavor = 'latex'
g.tex_conceal = ''
g.tex_comment_nospell = true
g.latex_fold_enabled = true

if (fn.has('mac')) then g.vimtex_view_method = 'skim' end

-- if (fn.executable('pplatex')) then g.vimtex_quickfix_method = 'pplatex' end

g.vimtex_compiler_latexmk = {build_dir = 'build'}
g.vimtex_compiler_progname = 'nvr'
g.vimtex_quickfix_ignore_filters = {
  'Package etex Warning', 'Package hyperref Warning',
  'You have requested package `MCLabPaper', 'Overfull', 'Underfull'
}

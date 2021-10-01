let g:fzf_command_prefix = 'Fzf'
let g:fzf_preview_window = ['right:60%:+{2}-/2',  'ctrl-/']
let g:fzf_action = {
\ 'ctrl-r': 'read',
\ 'ctrl-t': 'tab split',
\ 'ctrl-x': 'split',
\ 'ctrl-v': 'vsplit'
\ }
function! Files()
  function! s:prepend_icon(idx, fpath)
    let fname = fnamemodify(a:fpath, ':p:t')
    let fext = fnamemodify(a:fpath, ':e')
    let icon = luaeval('require"nvim-web-devicons".get_icon("'.fname.'", "'.fext.'", {default = true})')
    return printf("%s %s", icon, a:fpath)
  endfunction
  let files = split(system($FZF_DEFAULT_COMMAND), '\n')
  call map(files, function('s:prepend_icon'))
  let wrapped = fzf#wrap({'source': files, 'placeholder': '{2..}', 'options': ['-m']})
  let s:sink = wrapped['sink*']
  let wrapped['sink*'] = {lines -> s:sink(extend(lines[0:0], map(lines[1:], 'get(split(v:val, " "), 1, "")')))}
  call fzf#run(fzf#vim#with_preview(wrapped))
endfunction
command! Files call Files()
nnoremap <Leader>f :Files<CR>

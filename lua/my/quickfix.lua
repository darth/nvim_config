local utils = require 'my.utils'
local augroup = utils.augroup
local map = utils.map
local fn = vim.fn
local cmd = vim.cmd

augroup('qf', {
  {
    'FileType', 'qf',
    'setlocal nobuflisted nonumber norelativenumber colorcolumn= nolist nowrap'
  },
  {'WinEnter', '*', 'if winnr("$") == 1 && !buflisted(bufnr("")) | q | endif'}
})


local function toggle(type, focus)
  local function numqf()
    local n = 0
    for i = 1, fn.bufnr('$') do
      if fn.bufexists(i) and fn.getbufvar(i, '&bt') == 'quickfix' and fn.bufwinnr(i) >= 0 then
        n = n + 1
      end
    end
    return n
  end
  local nbefore = numqf()
  if (type == 'quickfix') then
    cmd 'silent! cclose'
  elseif (type == 'location') then
    cmd 'silent! lclose'
  end
  local nafter = numqf()
  if (nafter == nbefore) then
    if (type == 'quickfix') then
      cmd 'silent! botright copen'
    elseif (type == 'location') then
      cmd 'silent! lopen'
    end
    if (focus) then cmd 'wincmd p' end
  end
end

map('n', '<leader>q',
    '<cmd>lua require("my.quickfix").toggle("quickfix", false)<CR>',
    {silent = true})
map('n', '<leader>Q',
    '<cmd>lua require("my.quickfix").toggle("quickfix", true)<CR>',
    {silent = true})
map('n', '<leader>l',
    '<cmd>lua require("my.quickfix").toggle("location", false)<CR>',
    {silent = true})
map('n', '<leader>L',
    '<cmd>lua require("my.quickfix").toggle("location", true)<CR>',
    {silent = true})

return {toggle = toggle, numqf = numqf}

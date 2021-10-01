local fn = vim.fn
local cmd = vim.cmd
local map = require'my.utils'.map

local function delete_buffer()
  local buflisted = fn.getbufinfo({buflisted = 1})
  local cur_winnr, cur_bufnr = fn.winnr(), fn.bufnr()
  if #buflisted < 2 then cmd 'confirm qall' return end
  for _, winid in ipairs(fn.getbufinfo(cur_bufnr)[1].windows) do
    cmd(string.format('%d wincmd w', fn.win_id2win(winid)))
    cmd(cur_bufnr == buflisted[#buflisted].bufnr and 'bp' or 'bn')
  end
  cmd(string.format('%d wincmd w', cur_winnr))
  local is_terminal = fn.getbufvar(cur_bufnr, '&buftype') == 'terminal'
  cmd(is_terminal and 'bd! #' or 'silent! confirm bd #')
end

cmd 'command! BD lua require"my.bufdel"()'
map('n', '<leader>bd', '<cmd>:BD<CR>', {})

return delete_buffer

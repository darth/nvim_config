local utils = require 'my.utils'
local map = utils.map
local augroup = utils.augroup
local api = vim.api
local fn = vim.fn
local cmd = vim.cmd

local function border(x, y, w, h)
  local b = api.nvim_create_buf(false, true)
  local top = '╭' .. string.rep('─', w) .. '╮'
  local mid = "│" .. string.rep(' ', w) .. '│'
  local bot = '╰' .. string.rep('─', w) .. '╯'
  local lines = {}
  table.insert(lines, top)
  for _ = 1, h do table.insert(lines, mid) end
  table.insert(lines, bot)
  api.nvim_buf_set_lines(b, 0, -1, false, lines)
  return api.nvim_open_win(b, false, {
    relative = 'editor',
    col = x - 1,
    row = y - 1,
    width = w + 2,
    height = h + 2,
    style = 'minimal',
    focusable = false
  })
end

local state = {buf = nil, win = {border = nil, term = nil}}

local function close()
  for _, w in ipairs({state.win.term, state.win.border}) do
    api.nvim_set_current_win(w)
    augroup('TT', {})
    cmd 'q'
  end
end

local function open(perc, keymap)
  local bufexists = state.buf and fn.bufexists(state.buf) == 1
  local win = -1
  if (bufexists) then
    win = fn.bufwinnr(state.buf)
  else
    state.buf = api.nvim_create_buf(false, false)
    api.nvim_buf_set_option(state.buf, 'ft', 'ToggleTerminal')
  end
  if (win == -1) then
    local width = math.floor(vim.o.columns * perc)
    local col = (vim.o.columns - width) / 2
    local height = math.floor(vim.o.lines * perc)
    local row = (vim.o.lines - height) / 2
    state.win.border = border(col, row, width, height)
    api.nvim_win_set_option(state.win.border, 'signcolumn', 'no')
    state.win.term = api.nvim_open_win(state.buf, true, {
      relative = 'editor',
      width = width,
      height = height,
      row = row,
      col = col,
      style = 'minimal'
    })
    api.nvim_win_set_option(state.win.term, 'signcolumn', 'no')
    if (not bufexists) then
      fn.termopen('TT=1 ' .. vim.o.shell)
      map('nt', keymap, '<cmd>lua require("my.terminal").close()<CR>',
          {buffer = state.buf, silent = true})
    end
    augroup('TT', {{'BufLeave', '<buffer=' .. state.buf ..  '>', 'lua require("my.terminal").close()'}})
    cmd 'startinsert'
  else
    close()
  end
end

return {
  setup = function(args)
    map('n', args.keymap,
        '<cmd>lua require("my.terminal").open(' .. args.perc .. ', "\\' ..
            args.keymap .. '")<CR>', {silent = true})
  end,
  open = open,
  close = close
}

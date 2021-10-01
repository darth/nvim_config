local api = vim.api
local fn = vim.fn
local cmd = vim.cmd

local function augroup(name, cmds)
  cmd('augroup ' .. name)
  cmd('autocmd!')
  for _, c in ipairs(cmds) do
    cmd('autocmd ' .. c[1] .. ' ' .. c[2] .. ' ' .. c[3])
  end
  cmd('augroup END')
end

local _opts = {o = vim.o, b = {_real = vim.bo}, w = {_real = vim.wo}}

local mt = {
  __newindex = function(t, k, v)
    t._real[k] = v
    vim.o[k] = v
  end
}
setmetatable(_opts.b, mt)
setmetatable(_opts.w, mt)

local function map(modes, lhs, rhs, opts)
  local f
  local options = vim.tbl_extend('force', {noremap = true}, opts)
  if (options.buffer) then
    local bufnr = options.buffer
    options.buffer = nil
    f = function(...) api.nvim_buf_set_keymap(bufnr, ...) end
  else
    f = api.nvim_set_keymap
  end
  for m in modes:gmatch '.' do f(m, lhs, rhs, options) end
end

local function preserve(command)
  local s = api.getreg('/')
  local l = api.line('.')
  local c = api.col('.')
  cmd(command)
  api.setreg('/', s)
  api.cursor(l, c)
end

local function command_alias(alias, command)
  cmd(string.format([[
    cabbrev <expr> %s ((getcmdtype() is# ":" && getcmdline() is# "%s") ? ("%s") : ("%s"))
  ]], alias, alias, command, alias))
end

return {
  opts = _opts,
  augroup = augroup,
  map = map,
  preserve = preserve,
  command_alias = command_alias
}

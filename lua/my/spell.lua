local fn = vim.fn
local cmd = vim.cmd
local o = require'my.utils'.opts.o

local fs = fn.globpath(o.rtp, 'spell/*.add', false, true)
for _, f in ipairs(fs) do
  if (fn.filereadable(f) == 1) then
    if (not (fn.filereadable(f .. '.spl') == 1) or
        (fn.getftime(f) > fn.getftime(f .. '.spl'))) then
      cmd('silent mkspell! ' .. fn.fnameescape(f))
    end
  end
end

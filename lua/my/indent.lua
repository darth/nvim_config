local b = require'my.utils'.opts.b

return {
  setup = function(args)
    b.tabstop = args.width
    b.softtabstop = args.width
    b.shiftwidth = args.width
    b.expandtab = true
    b.cinoptions = 'g0:0'
  end
}

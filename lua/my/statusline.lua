require'lualine'.setup {
  options = {
    theme = 'nord',
    sections = {
      lualine_x = {
        'encoding', 'fileformat', 'filetype',
        {'diagnostics', sources = {'nvim_lsp'}}
      },
      lualine_z = {{'location', icon = ''}}
    },
    section_separators = {left = '', right = ''},
    component_separators = {left = '', right = ''}
  },
  extension = {'fzf'}
}

local fn = vim.fn
local api = vim.api

vim.fn.sign_define("DiagnosticSignError", {text = "", texthl = "LspDiagnosticsError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = "", texthl = "LspDiagnosticsWarning"})
vim.fn.sign_define("DiagnosticSignInformation", {text = "", texthl = "LspDiagnosticsInformation"})
vim.fn.sign_define("DiagnosticSignHint", {text = "", texthl = "LspDiagnosticsHint"})

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  -- Mappings.
  local opts = {buffer = bufnr, silent = true}
  local map = require('my.utils').map
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
      opts)
  map('n', '<space>wl',
      '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
      opts)
  map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map('n', '<space>e',
      '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    map("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    map("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    api.nvim_exec([[
      :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {'pyright', 'sourcegraph_js', 'yamlls', 'jsonls'}
for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup {on_attach = on_attach} end

nvim_lsp['ccls'].setup {
  capabilities = capabilities,
  init_options = {
    compilationDatabaseDirectory = 'build',
    cache = {directory = '/tmp/ccls-cache'},
    highlight = {lsRanges = true},
    client = {snippetSupport = true}
  },
  on_attach = on_attach
}

if vim.env.LUA_LS_ROOT then
  local sys_name
  if fn.has('mac') == 1 then
    sys_name = 'macOS'
  elseif fn.has('unix') then
    sys_name = 'Linux'
  elseif fn.has('win32') then
    sys_name = 'Windows'
  else
    print('Unsupported system for sumneko')
  end
  local srv_root = fn.expand('$LUA_LS_ROOT')
  local srv_bin = srv_root .. '/bin/' .. sys_name .. '/lua-language-server'
  nvim_lsp['sumneko_lua'].setup {
    cmd = {srv_bin, "-E", srv_root .. '/main.lua'},
    settings = {
      Lua = {
        runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
        diagnostics = {globals = {'vim'}},
        workspace = {
          library = {
            [fn.expand('$VIMRUNTIME/lua')] = true,
            [fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
          }
        }
      }
    },
    on_attach = on_attach
  }
end

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

local server_name = "sourcegraph_js"
local bin_name = "javascript-typescript-stdio"

if not lspconfig[server_name] then
  configs[server_name] = {
    default_config = {
      cmd = {bin_name},
      filetypes = {
        "javascript", "javascriptreact", "javascript.jsx", "typescript",
        "typescriptreact", "typescript.tsx"
      },
      root_dir = function(fname)
        return util.root_pattern("tsconfig.json")(fname) or
                   util.root_pattern("package.json", "jsconfig.json", ".git")(
                       fname);
      end
    },
    docs = {
      description = [[
  https://github.com/sourcegraph/javascript-typescript-langserver
  ```
  ]],
      default_config = {
        root_dir = [[root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")]]
      }
    }
  }
end
lspconfig[server_name].setup{}

-- vim:et ts=2 sw=2

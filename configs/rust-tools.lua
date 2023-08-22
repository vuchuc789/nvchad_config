local on_attach = require("custom.configs.lspconfig").on_attach
local capabilities = require("custom.configs.lspconfig").capabilities

local opts = {

  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

require("rust-tools").setup(opts)

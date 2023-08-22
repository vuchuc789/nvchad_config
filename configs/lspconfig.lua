local capabilities = require("plugins.configs.lspconfig").capabilities
local utils = require "core.utils"

local lspconfig = require "lspconfig"
local lspconfig_eslint = require "lspconfig.server_configurations.eslint"

local custom_utils = require "custom.utils"

local M = {}
M.capabilities = capabilities

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end

  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })
  end
end

M.on_attach = on_attach

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "pyright", "gopls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function(fname)
    -- detect yarn pnp
    local pnp_root = custom_utils.detect_yarn_pnp(fname)
    if pnp_root then
      return pnp_root
    end

    return lspconfig_eslint.default_config.root_dir(fname)
  end,
  on_init = function(client)
    local path = client.workspace_folders[1].name

    -- detect yarn pnp
    if custom_utils.detect_yarn_pnp(path) then
      client.config.settings.packageManager = "yarn"
      client.config.settings.nodePath = ".yarn/sdks"
    end

    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    return true
  end,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = function(client)
    local path = client.workspace_folders[1].name

    -- detect yarn pnp
    if custom_utils.detect_venv(path) then
      client.config.settings.python.venvPath = ".venv"
    end

    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    return true
  end,
}

return M

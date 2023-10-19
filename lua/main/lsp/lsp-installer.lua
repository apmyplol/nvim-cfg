local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

mason.setup()

require("mason-lspconfig").setup()

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local on_attach = require("main.lsp.handlers").on_attach
local capabilities = require("main.lsp.handlers").capabilities

local luals_opts = require "main.lsp.settings.lua_ls"
local jsonls_opts = require "main.lsp.settings.jsonls"
local pyright_opts = require "main.lsp.settings.pyright"
local jdtls_opts = require "main.lsp.settings.java_jdtls"

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = luals_opts
}

lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  opts = jsonls_opts,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  opts = pyright_opts,
}

lspconfig.jdtls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  opts = jdtls_opts,
}

lspconfig.gradle_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.kotlin_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

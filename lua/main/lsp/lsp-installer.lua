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
local scalametals_opts = require "main.lsp.settings.scalametals"
local ltex_opts = require "main.lsp.settings.ltex"

lspconfig.texlab.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- lspconfig.vale_ls.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = luals_opts,
}

lspconfig.jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    opts = jsonls_opts,
}

lspconfig.ltex.setup {
    capabilities = capabilities,
    cmd = { "/home/afa/Downloads/ltex-ls-plus-18.4.0/bin/ltex-ls-plus" },
    settings = ltex_opts,
    on_attach = function(client, bufnr)
        -- rest of your on_attach process.
        require("ltex_extra").setup { load_langs = { "en-GB" } }
        on_attach(client, bufnr)
    end,
}

lspconfig.harper_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {
        "c",
        "cpp",
        "cs",
        "gitcommit",
        "go",
        "html",
        "java",
        "javascript",
        "lua",
        "markdown",
        "nix",
        "python",
        "ruby",
        "rust",
        "swift",
        "toml",
        "typescript",
        "typescriptreact",
        "haskell",
        "cmake",
        "typst",
        "php",
        "dart",
    },
  settings = {
    ["harper-ls"] = {
      userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
    }
  }
}

lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = pyright_opts,
}

-- jdtls installed via nvim-jdtls
-- lspconfig.jdtls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   opts = jdtls_opts,
-- }

lspconfig.gradle_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.kotlin_language_server.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.metals.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = scalametals_opts,
}

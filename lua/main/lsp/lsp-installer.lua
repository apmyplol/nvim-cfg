local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

mason.setup()

require("mason-lspconfig").setup()


local luals_opts = require "main.lsp.settings.lua_ls"
local jsonls_opts = require "main.lsp.settings.jsonls"
local pyright_opts = require "main.lsp.settings.pyright"
local ltex_opts = require "main.lsp.settings.ltex"

local vue_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}
vim.print(vue_language_server_path)
vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

vim.lsp.config("lua_ls", {
    settings = luals_opts,
})

vim.lsp.config("jsonls", {
    opts = jsonls_opts,
})

vim.lsp.config("ltex", {
    cmd = { "/home/afa/Downloads/ltex-ls-plus-18.4.0/bin/ltex-ls-plus" },
    settings = ltex_opts,
})

-- vim.lsp.config("harper_ls", {
--     filetypes = {
--         "c",
--         "cpp",
--         "cs",
--         "gitcommit",
--         "go",
--         "html",
--         "java",
--         "javascript",
--         "lua",
--         "markdown",
--         "nix",
--         "python",
--         "ruby",
--         "rust",
--         "swift",
--         "toml",
--         "typescript",
--         "typescriptreact",
--         "haskell",
--         "cmake",
--         "typst",
--         "php",
--         "dart",
--     },
--   settings = {
--     ["harper-ls"] = {
--       userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
--     }
--   }
-- })

vim.lsp.config("pyright", {
    settings = pyright_opts,
})

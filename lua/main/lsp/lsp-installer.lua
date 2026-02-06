local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

mason.setup()

require("mason-lspconfig").setup()


local function my_root_dir(bufnr, on_dir)
  -- The project root is where the LSP can be started from
  local root_markers = { 'deno.lock' }
  -- Give the root markers equal priority by wrapping them in a table
  root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
    or vim.list_extend(root_markers, { '.git' })
  -- exclude non-deno projects (npm, yarn, pnpm, bun)
  -- local non_deno_path = vim.fs.root(
  --   bufnr,
  --   { 'package.json', 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
  -- )
  local project_root = vim.fs.root(bufnr, root_markers)
  -- if non_deno_path and (not project_root or #non_deno_path >= #project_root) then
  --   return
  -- end
  -- We fallback to the current working directory if no project root is found
  on_dir(project_root or vim.fn.getcwd())
end


vim.lsp.config("denols", {
  root_dir = my_root_dir,
  init_options = {
    lint = true,
    unstable = true,
    enable = true,
    suggest = {
      imports = {
        hosts = {
          ["https://deno.land"] = true,
        },
      },
    },
  },
})

local luals_opts = require "main.lsp.settings.lua_ls"
local jsonls_opts = require "main.lsp.settings.jsonls"
local pyright_opts = require "main.lsp.settings.pyright"
local ltex_opts = require "main.lsp.settings.ltex"


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

vim.lsp.config("harper_ls", {
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
})

vim.lsp.config("pyright", {
    settings = pyright_opts,
})

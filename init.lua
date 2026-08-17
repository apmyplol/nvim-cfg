vim.o.winborder = "rounded"
vim.opt.autoread = true

package.path = package.path .. ";/home/afa/.config/nnvim/?.lua"

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  'https://github.com/nvim-mini/mini.nvim',
  "https://github.com/folke/which-key.nvim",
  "https://github.com/lunarvim/colorschemes",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/akinsho/toggleterm.nvim",
  "https://github.com/nvimdev/lspsaga.nvim",
  "https://github.com/kevinhwang91/nvim-bqf",
  "https://github.com/lervag/vimtex",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/antonk52/filepaths_ls.nvim"
})

require "mini.pick".setup()
require "mini.icons".setup()
require "mini.tabline".setup()
require "mini.cmdline".setup()
require "mini.files".setup({
  mappings = {
    go_out = "ö",
    go_out_plus = "Ö",
    synchronize = "w"
  },
  windows = {
    preview = true,
    width_preview = 50
  }
})
require "mini-settings.highlight"
require "mini.bufremove".setup()
require "mini.comment".setup()
require "mini.ai".setup()
require "snippets.luasnip"
require "mini.operators".setup()
require "mini.sessions".setup()
require "mini.starter".setup()
require "mini.surround".setup()
require "mini.statusline".setup()
require "mini.pairs".setup()
require "mini.extra".setup()
require "vimtex"
require "mini.indentscope".setup()
require "mini.completion".setup()
require "mini.keymap".setup()
local map_multistep = require('mini.keymap').map_multistep

map_multistep('i', '<Tab>', { 'pmenu_next' })
map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
map_multistep('i', '<BS>', { 'minipairs_bs' })
local map = require "mini.map"
map.setup({
  integrations = {
    map.gen_integration.builtin_search(),
    map.gen_integration.diff(),
    map.gen_integration.diagnostic(),
  },
  window = {
    width = 20
  }
})
require "keymaps-config"
require "which-key-config"
require "options"
require "vtsls"
require "lua_ls"
require "mason".setup()
require "autocmds"


-- ctrl-x-smth change how it works, on files for example it stops after one entry and then I have to enter ctrl-x ctrl-f again

require("lspsaga").setup {
  definition = {
    keys = {
      edit = "e",
    },
  },
  lightbulb = { enable = false } }

vim.cmd("set completeopt+=noselect")
vim.cmd("colorscheme tokyonight")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local status_ok, wk = pcall(require, "which-key")
    if not status_ok then
      print "which-key"
    end

    local opts = {
      mode = "n",      -- NORMAL mode
      prefix = "",
      buffer = ev.buf, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,   -- use `silent` when creating keymaps
      noremap = true,  -- use `noremap` when creating keymaps
      nowait = true,   -- use `nowait` when creating keymaps
    }

    local mappings = {
      h = { "<cmd>Lspsaga hover_doc<cr>", "LSP Hover" },
      g = {
        d = { "<cmd>Lspsaga peek_definition<CR>", "peek definiton" },
        i = { "<cmd>Lspsaga finder imp<cr>", "search implementations" },
        r = { "<cmd>Lspsaga finder<CR>", "search references" }

      }
    }

    wk.register(mappings, opts)

    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format(async = true)' ]]
  end
})
vim.lsp.enable({ "lua_ls", "vtsls", "ltex_plus", "filepaths_ls" })
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local status_ok, wk = pcall(require, "which-key")
    if not status_ok then
      print "which-key"
    end

    local opts = {
      mode = "n",        -- NORMAL mode
      prefix = "",
      buffer = ev.buf,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,     -- use `silent` when creating keymaps
      noremap = true,    -- use `noremap` when creating keymaps
      nowait = true,     -- use `nowait` when creating keymaps
    }

    local mappings = {
      h = { "<cmd>Lspsaga hover_doc<cr>", "LSP Hover" },
      g = {
        d = {"<cmd>Lspsaga peek_definition<CR>" , "peek definiton" },
        i = { "<cmd>Lspsaga finder imp<cr>", "search implementations" },
        r = { "<cmd>Lspsaga finder<CR>", "search references" }

      }
    }

    wk.register(mappings, opts)

    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format(async = true)' ]]
  end
})

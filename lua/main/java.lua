vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function(args)
    local status_ok, jdtls = pcall(require, "jdtls")
    if not status_ok then
      print "error while loading jdtls"
    end

    local on_attach = require("main.lsp.handlers").on_attach
    local capabilities = require("main.lsp.handlers").capabilities

    local config = require "main.lsp.settings.java_jdtls"
    config.on_attach = on_attach
    config.capabilities = capabilities

    jdtls.start_or_attach(config)

    local status_ok, wk = pcall(require, "which-key")
    if not status_ok then
      print "error while loading jdtls"
    end

    local opts = {
      mode = "n",     -- NORMAL mode
      prefix = "<leader>",
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true,  -- use `nowait` when creating keymaps
    }


    local mappings = {
      j = {
        g = { "<cmd>lua require('main.FOP').gradle()<cr>", "execute gradle task" },
        d = { "<cmd>JdtUpdateDebugConfig<cr>", "init debug for java" },
      },
      d = {
        l = { function() require('dap').continue() end, "→ continue" },
        L = { function() require('dap').step_over() end, "↷ step over" },
        j = { function() require('dap').step_into() end, "↴ step into" },
        k = { function() require('dap').step_out() end, "↳ step out" },
        b = { function() require('dap').toggle_breakpoint() end, "🐞 toggle BP" },
        -- B = { function() require('dap').set_breakpoint() end, "set BP" },
        B = { function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
          "BP with log message" },
        r = { function() require('dap').repl.open() end, "RELP" },
        -- L = { function() require('dap').run_last() end, "run latest" },
        -- h = { function() require('dap.ui.widgets').hover() end, "floating hover" },
        -- p = { function() require('dap.ui.widgets').preview() end, "preview window" },
        -- f = { function()
        --   local widgets = require('dap.ui.widgets')
        --   widgets.centered_float(widgets.frames)
        -- end, "cur scope in float" },
        -- s = { function()
        --   local widgets = require('dap.ui.widgets')
        --   widgets.centered_float(widgets.scopes)
        -- end, "bla" },
        u = { function() require("dapui").toggle() end, "toggle DAPUI" }
      }
    }

    wk.register(mappings, opts)


    local status_ok, dapui = pcall(require, "dapui")
    if not status_ok then
      print "error while loading jdtls"
    end
    dapui.setup()

  end,
})

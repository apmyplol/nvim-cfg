local dap = require("dap")
local dapui = require("dapui")
local utils = require("dap.utils")

-- Set logging levels to debug why adapters are not working
-- logs are saved in ~.cache/nvim/dap.log.
dap.set_log_level("DEBUG")

-- dap.adapters["pwa-node"] = {
--   type = "executable",
--   command = "node",
--   -- Path to the actual JS file of the debugger
--   args = {
--     vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
--     "${port}"
--   },
-- }

-- vim.print(vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js")

dap.adapters = {
  ["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = {
        vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
        "${port}",
      },
    },
  }
}

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to process ID",
      processId = utils.pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to Port",
      address = "127.0.0.1",
      port = function()
        local port = vim.fn.input("Enter Port (default 9229):")
        if port == "" then
          return 9229
        end
        return tonumber(port)
      end,
      sourceMaps = true,
      restart = true,
      cwd = "${workspaceFolder}",
      protocol = "inspector",
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch & Debug Chrome",
      url = function()
        local co = coroutine.running()
        return coroutine.create(function()
          vim.ui.input({
            prompt = "Enter URL: ",
            default = "http://localhost:3000",
          }, function(url)
            if url == nil or url == "" then
              return
            else
              coroutine.resume(co, url)
            end
          end)
        end)
      end,
      webRoot = vim.fn.getcwd(),
      protocol = "inspector",
      sourceMaps = true,
      userDataDir = false,
    },
    {
      name = "----- ↓ launch.json configs ↓ -----",
      type = "",
      request = "launch",
    },
  }
end

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
  controls = {
    icons = {
      pause = "⏸",
      play = "▶",
      step_into = "⏎",
      step_over = "⏭",
      step_out = "⏮",
      step_back = "b",
      run_last = "▶▶",
      terminate = "⏹",
      disconnect = "⏏",
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close
dap.listeners.before.event_disconnected["dapui_config"] = dapui.close

local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  print "which-key"
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
    D = { function()
      require('dap').clear_breakpoints()
      require('dap').terminate()
      require('dapui').close()
    end, "Stop Debugger & Clear BP" },
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
    u = { function() require("dapui").toggle() end, "toggle DAPUI" },
  }
}

wk.register(mappings, opts)

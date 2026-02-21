local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false,      -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true,       -- default bindings on <c-w>
      nav = true,           -- misc bindings to work with windows
      z = true,             -- bindings for folds, spelling and others prefixed with z
      g = true,             -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  presets = {
    z = true,
  },
  replace = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ["<space>"] = "␣",
    ["<cr>"] = "↵",
    ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  keys = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>",   -- binding to scroll up inside the popup
  },
  wi = {
    border = "rounded",       -- none, single, double, shadow
    position = "bottom",      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3,                    -- spacing between columns
    align = "left",                 -- align columns left, center or right
  },
  -- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = {
    { "<auto>", mode = "nxso" },
  },
  -- triggers = "auto", -- automatically setup triggers
  -- -- triggers = {"<leader>"} -- or specify a list manually
  -- triggers_blacklist = {
  --     -- list of mode / prefixes that should never be hooked by WhichKey
  --     -- this is mostly relevant for key maps that start with a native binding
  --     -- most people should not need to change this
  --     n = { "s" },
  --     i = { "j", "k" },
  --     v = { "j", "k" },
  -- },
}

local nbinds = {

  {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    {
      "<leader>/",
      "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
      desc = "Comment",
      nowait = true,
      remap = false,
    },
    {
      "<leader>F",
      "<cmd>Telescope live_grep theme=ivy<cr>",
      desc = "Find Text",
      nowait = true,
      remap = false,
    },
    {
      "<leader>P",
      "<cmd>Telescope workspaces<cr>",
      desc = "Projects/Workspaces",
      nowait = true,
      remap = false,
    },
    {
      "<leader>S",
      group = "Search",
      nowait = true,
      remap = false,
    },
    {
      "<leader>SC",
      "<cmd>Telescope commands<cr>",
      desc = "Commands",
      nowait = true,
      remap = false,
    },
    {
      "<leader>SM",
      "<cmd>Telescope man_pages<cr>",
      desc = "Man Pages",
      nowait = true,
      remap = false,
    },
    {
      "<leader>SR",
      "<cmd>Telescope registers<cr>",
      desc = "Registers",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Sb",
      "<cmd>Telescope git_branches<cr>",
      desc = "Checkout branch",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Sc",
      "<cmd>Telescope colorscheme<cr>",
      desc = "Colorscheme",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Sh",
      "<cmd>Telescope help_tags<cr>",
      desc = "Find Help",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Sk",
      "<cmd>Telescope keymaps<cr>",
      desc = "Keymaps",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Sr",
      "<cmd>Telescope oldfiles<cr>",
      desc = "Open Recent File",
      nowait = true,
      remap = false,
    },
    {
      "<leader>T",
      group = "Terminal",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Tf",
      "<cmd>ToggleTerm direction=float<cr>",
      desc = "Float",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Th",
      "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
      desc = "Horizontal",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Tn",
      "<cmd>lua _NODE_TOGGLE()<cr>",
      desc = "Node",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Tp",
      "<cmd>lua _PYTHON_TOGGLE()<cr>",
      desc = "Python",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Tt",
      "<cmd>lua _HTOP_TOGGLE()<cr>",
      desc = "Htop",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Tu",
      "<cmd>lua _NCDU_TOGGLE()<cr>",
      desc = "NCDU",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Tv",
      "<cmd>ToggleTerm size=80 direction=vertical<cr>",
      desc = "Vertical",
      nowait = true,
      remap = false,
    },
    {
      "<leader>a",
      "<cmd>Alpha<cr>",
      desc = "Alpha",
      nowait = true,
      remap = false,
    },
    {
      "<leader>e",
      "<cmd>NvimTreeToggle<cr>",
      desc = "Explorer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>f",
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      desc = "Find files",
      nowait = true,
      remap = false,
    },
    {
      "<leader>g",
      group = "Git",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gb",
      "<cmd>Telescope git_branches<cr>",
      desc = "Checkout branch",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gc",
      "<cmd>Telescope git_commits<cr>",
      desc = "Checkout commit",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gg",
      "<cmd>lua _LAZYGIT_TOGGLE()<cr>",
      desc = "Lazygit",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gh",
      "<cmd>VGit buffer_history_preview<cr>",
      desc = "buffer history",
      nowait = true,
      remap = false,
    },
    {
      "<leader>go",
      "<cmd>Telescope git_status<cr>",
      desc = "Open changed file",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gp",
      "<cmd>VGit buffer_blame_preview<cr>",
      desc = "Preview Hunk",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gs",
      "<cmd>VGit buffer_stage<cr>",
      desc = "Stage buffer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>gu",
      "<cmd>VGit buffer_unstage<cr>",
      desc = "Undo Stage Hunk",
      nowait = true,
      remap = false,
    },
    {
      "<leader>h",
      "<cmd>nohlsearch<CR>",
      desc = "No Highlight",
      nowait = true,
      remap = false,
    },
    {
      "<leader>l",
      group = "LSP",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lD",
      "<cmd>lua vim.lsp.buf.declaration()<CR>",
      desc = "Goto declaration",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lI",
      "<cmd>LspInstallInfo<cr>",
      desc = "Installer Info",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lL",
      "<<cmd>lua vim.diagnostic.open_float()<CR>",
      desc = "float Diagnostic",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lR",
      "<cmd>lua vim.lsp.buf.rename()<cr>",
      desc = "Rename",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lS",
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      desc = "Workspace Symbols",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lZ",
      "<cmd>lua vim.lsp.buf.signature_help()<CR>",
      desc = "Signature help?",
      nowait = true,
      remap = false,
    },
    {
      "<leader>la",
      "<cmd>lua vim.lsp.buf.code_action()<cr>",
      desc = "Code Action",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ld",
      "<cmd>lua vim.lsp.buf.definition()<CR>",
      desc = "Goto definition",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lf",
      "<cmd>lua vim.lsp.buf.format{async = true}<cr>",
      desc = "Format",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lh",
      "<cmd>lua vim.lsp.buf.hover()<CR>",
      desc = "hover",
      nowait = true,
      remap = false,
    },
    {
      "<leader>li",
      "<cmd>LspInfo<cr>",
      desc = "Info",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lj",
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      desc = "Next Diagnostic",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lk",
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      desc = "Prev Diagnostic",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lq",
      "<cmd>lua vim.diagnostic.setloclist()<cr>",
      desc = "Quickfix",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lr",
      "<cmd>lua vim.lsp.buf.references()<CR>",
      desc = "References",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ls",
      "<cmd>Telescope lsp_document_symbols<cr>",
      desc = "Document Symbols",
      nowait = true,
      remap = false,
    },
    {
      "<leader>lz",
      "<cmd>lua vim.lsp.buf.implementation()<CR>",
      desc = "Implementations?",
      nowait = true,
      remap = false,
    },
    {
      "<leader>m",
      group = "my stuff",
      nowait = true,
      remap = false,
    },
    {
      "<leader>mR",
      function()
        local reload = require("plenary.reload").reload_module
        require("luasnip").cleanup()
        reload("main", false)
        dofile(vim.env.MYVIMRC)
      end,
      desc = "reload entire nvim config",
      nowait = true,
      remap = false,
    },
    {
      "<leader>mS",
      "<cmd>Shipwright ~/.config/nvim/lua/colors/shipwright_build.lua<cr>",
      desc = "Build theme with shipwright",
      nowait = true,
      remap = false,
    },
    {
      "<leader>mc",
      "<cmd>ColorizerAttachToBuffer<cr>",
      desc = "enable colorizer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ml",
      "<cmd>lua require'main.keymapfunctions'.latex()<cr>",
      desc = "Show markdown/tex preview",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ms",
      '<cmd>lua require("luasnip").cleanup() print("cleaned snippets") vim.cmd("source ~/.config/nvim/lua/main/snippets/helpers.lua") vim.cmd("source ~/.config/nvim/lua/main/luasnip.lua") vim.cmd("source ~/.config/nvim/lua/main/snippets/tex_snip.lua") vim.cmd("source ~/.config/nvim/lua/main/snippets/obsidian_snip.lua") vim.notify("loaded snippets")<cr>',
      desc = "reload snippets",
      nowait = true,
      remap = false,
    },
    {
      "<leader>p",
      group = "Packer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>pS",
      "<cmd>PackerStatus<cr>",
      desc = "Status",
      nowait = true,
      remap = false,
    },
    {
      "<leader>pc",
      "<cmd>PackerCompile<cr>",
      desc = "Compile",
      nowait = true,
      remap = false,
    },
    {
      "<leader>pi",
      "<cmd>PackerInstall<cr>",
      desc = "Install",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ps",
      "<cmd>PackerSync<cr>",
      desc = "Sync",
      nowait = true,
      remap = false,
    },
    {
      "<leader>pu",
      "<cmd>PackerUpdate<cr>",
      desc = "Update",
      nowait = true,
      remap = false,
    },
    {
      "<leader>q",
      "<cmd>lua require'main.keymapfunctions'.TODOLocList()<cr>",
      desc = "Todo Location list",
      nowait = true,
      remap = false,
    },
    {
      "<leader>w",
      "<cmd>w!<CR>",
      desc = "Save",
      nowait = true,
      remap = false,
    },
  },
}

local vbinds = {
  {
    mode = { "v" },
    {
      "<leader>/",
      '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
      desc = "Comment",
      nowait = true,
      remap = false,
    },
    {
      "<leader>c",
      group = "Comments",
      nowait = true,
      remap = false,
    },
    {
      "<leader>cb",
      '<CMD>lua require("Comment.api").toggle.blockwise()<CR>',
      desc = "Toggle blockwise comment",
      nowait = true,
      remap = false,
    },
    {
      "<leader>cc",
      '<CMD>lua require("Comment.api").toggle.linewise_op<CR>',
      desc = "Toggle linewise Comment",
      nowait = true,
      remap = false,
    },
    {
      "<leader>z",
      group = "Folds",
      nowait = true,
      remap = false,
    },
    {
      "<leader>zf",
      ":'<,'>fold<CR>",
      desc = "create Fold",
      nowait = true,
      remap = false,
    },
  },
}

which_key.add { nbinds, vbinds }
which_key.setup(setup)

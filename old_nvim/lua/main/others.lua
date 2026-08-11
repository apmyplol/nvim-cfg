local status_ok, hologram = pcall(require, "hologram")
if not status_ok then
  return
end

require("faster").setup({
  behaviours = {
    bigfile = {
      filesize = 1,
      features_disabled = {
        "illuminate", "matchparen", "lsp", "treesitter",
        "indent_blankline", "vimopts", "syntax", "colorizer"
      },
      extra_patterns = {
        { filesize = 0.1, pattern = "*.json" }
      }
    }
  },
  features = {
    colorizer = {
      on = true,
      defer = false,
      disable = function()
        if vim.fn.exists(':ColorizerDetachFromBuffer') ~= 2 then
          print("colorizer not existent")
          return
        end
        vim.cmd('ColorizerDetachFromBuffer')
        print("disabled colorizer")
      end,

      enable = function()
        if vim.fn.exists(':ColorizerAttachToBuffer') ~= 2 then
        print("cannot enable colorizer")
          return
        end
        vim.cmd('ColorizerAttachToBuffer')
        print("enabled colorizer")
      end,
      commands = function() end

    }
  }
})

hologram.setup {
  -- auto_display = true -- WIP automatic markdown image display, may be prone to breaking
}

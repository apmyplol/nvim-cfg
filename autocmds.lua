vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  pattern = "*",
  desc = "highlight selection on yank",
  callback = function()
    vim.highlight.on_yank({ timeout = 200, visual = true })
  end
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "automatically format buffers before writing them",
  callback = function()
    vim.lsp.buf.format()
  end
})

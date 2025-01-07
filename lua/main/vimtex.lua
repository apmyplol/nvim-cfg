local g = vim.g

g.tex_flavor='latex'
g.vimtex_view_method='zathura'
g.vimtex_fold_enabled=0
g.vimtex_quickfix_mode=0
g.tex_conceal='abdmg'
vim.api.nvim_set_option_value("conceallevel", 1, {})

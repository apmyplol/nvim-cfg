local g = vim.g

g.tex_flavor = "latex"
g.vimtex_view_method = "zathura"
g.vimtex_fold_enabled = 1
g.vimtex_quickfix_mode = 0
g.tex_conceal = "abdmg"
g.vimtex_toc_config = {
    fold_enable = 1,
    indent_levels = 1,
    split_width = 90,
    split_pos = "vert rightbelow",
    layers = { "content", "label", "todo", "include" },
    layer_keys = { content = "C", label = "L", todo = "T", include = "I", defi = "D" },
}
g.vimtex_toc_custom_matchers = {
    {
        title = "other",
        re = [[\v^\s*\\begin\{(defi|thm|lem|cor|proofpart|proof|ex|rem)]],
        get_entry = function(context)
            -- print(vim.inspect(context))
            local _, _, typ, content = string.find(context.line, "\\begin[%*]?{(%a+)[%*]?}[%[]?([^%]]*)[%]]?")
            local cont = content:gsub("%s+", "") == "" and typ or typ .. ": " .. content
            -- print(vim.inspect { typ, cont })
            local level = 1
            if typ == "ex" or typ == "proof" or typ == "rem" then
                level = 2
            elseif typ == "proofpart" then
                level = 3
            end
            return {
                title = cont,
                number = "",
                file = context.file,
                line = context.lnum,
                rank = context.lnum_total,
                level = level,
                type = "content",
            }
        end,
    },
}

vim.api.nvim_set_option_value("conceallevel", 1, {})

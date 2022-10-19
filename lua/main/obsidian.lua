local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}

local find_command = {
    "rg",
    "--files",
    "--ignore-file",
    ".rgignore",
    -- "&&",
    -- "rg",
    -- "-e",
    -- "'aliases: (.+)'",
    -- "--ignore-file",
    -- ".rgignore",
}

-- function for tabcompletion in telescope
local tabcomplete = function(prompt_bufnr)
    -- get selected entry and prompt
    -- if no item is selected then return
    local selected_entry = action_state.get_selected_entry()
    if selected_entry == nil then
        return
    end
    local prompt = action_state.get_current_picker(prompt_bufnr).sorter._discard_state.prompt
    local text = selected_entry.display
    -- if prompt has text then remove the text
    if prompt ~= "" then
        vim.api.nvim_input "<ESC>"
        vim.api.nvim_input "dd"
        vim.api.nvim_input "i"
    end
    -- input selected entry text into prompt
    vim.api.nvim_input(text)
end

-- function to rename heading or block reference
-- only runs, if a heading or block was selected in the second prompt
local rename_heading_block = function(sel)
    local filename = sel.filename
    local attach = sel.attach

    local res = { attach, filename }

    opts = {}
    pickers
        .new(opts, {
            prompt_title = "Block/Heading Naming for File: " .. filename .. attach,
            finder = finders.new_table {
                results = res,
                entry_maker = function(entry)
                    return sel
                end,
            },
            sorter = conf.file_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    local prompt_text = action_state.get_current_picker(prompt_bufnr).sorter._discard_state.prompt
                    actions.close(prompt_bufnr)

                    vim.api.nvim_put({ "[[" .. filename .. attach .. "|" .. prompt_text .. "]] " }, "", false, true)
                    vim.api.nvim_input "a"
                end)
                map("i", "<Tab>", function()
                    tabcomplete(prompt_bufnr)
                end)
                return true
            end,
        })
        :find()
end

-- prompt that renames a file or selects a heading / block in a file and opens another prompt to rename the heading / block reference
local obsidian_rename = function(inp_fname)
    local fname, ext = inp_fname:match "([^/.]+)%.(.*)$"
    fname = ext == "md" and fname or fname .. "." .. ext
    -- only search for aliases and ^^ things in file if markdown file
    -- but either way add fname as a result
    local res = { fname }

    if ext == "md" then
        local alias_match = vim.fn.system("rg -e 'aliases:' " .. inp_fname:gsub(" ", "\\ "))
        local block_ref = vim.fn.system("rg -e '^\\^' " .. inp_fname:gsub(" ", "\\ "))
        local heading_ref = vim.fn.system("rg -e '^#' " .. inp_fname:gsub(" ", "\\ "))

        -- add aliases to result list
        for str in alias_match:gsub("aliases:%s?", ""):gsub("\n", ""):gsub(",%s", "~"):gmatch "[^~]+" do
            if str ~= "" then
                res[#res + 1] = str
            end
        end

        for str in block_ref:gmatch "[^\n]+" do
            res[#res + 1] = str
        end

        for str in heading_ref:gmatch "[^\n]+" do
            res[#res + 1] = str
        end
    end

    local opts = {}
    pickers
        .new(opts, {
            prompt_title = "Ref Naming, Block/Heading selection for File: " .. fname,
            finder = finders.new_table {
                results = res,
                entry_maker = function(entry)
                    -- is this a file reference or header/block reference
                    local fileref = true
                    -- what to attach to the filename in the reference
                    local lattach = ""
                    local display = ""
                    local mathref = false
                    -- if entry is the filename, then attach nothing, and set filereference to true
                    if entry == fname then
                        lattach = entry:find "_" and "|" .. entry:gsub("_", " ") or ""
                        display = entry:find "_" and "|" .. entry:gsub("_", " ") or entry
                    elseif entry:find "^^" then
                        fileref = false
                        lattach = "#" .. entry
                        display = lattach
                    elseif entry:find "^#" then
                        fileref = false
                        lattach = "" .. entry
                        display = lattach
                    else
                        lattach = "|" .. entry
                        display = lattach
                    end
                    return {
                        -- attach what is being displayed
                        display = display,
                        attach = lattach,
                        ordinal = entry,
                        filename = fname,
                        fileref = fileref,
                        mathref = mathref,
                    }
                end,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                --[[ local prompt_text = action_state.get_current_picker(prompt_bufnr).sorter._discard_state.prompt ]]
                actions.select_default:replace(function()
                    local prompt_text = action_state.get_current_picker(prompt_bufnr).sorter._discard_state.prompt
                    local selection = action_state.get_selected_entry()
                    -- if the selection is nil then use the prompt text, else the selection attach
                    local attach = selection == nil and "|" .. prompt_text or selection.attach
                    if selection == nil or selection.fileref == true then
                        actions.close(prompt_bufnr)
                        vim.api.nvim_put({ "[[" .. fname .. attach .. "]] " }, "", false, true)
                        vim.api.nvim_input "a"
                    else
                        rename_heading_block(selection)
                    end
                end)

                map("i", "<C-CR>", function()
                    local prompt_text = action_state.get_current_picker(prompt_bufnr).sorter._discard_state.prompt
                    actions.close(prompt_bufnr)

                    vim.api.nvim_put({ "[[" .. fname .. "|" .. prompt_text .. "]] " }, "", false, true)
                    vim.api.nvim_input "a"
                end)
                map("i", "<Tab>", function()
                    tabcomplete(prompt_bufnr)
                end)
                return true
            end,
        })
        :find()
end

-- first telescope instance
function M.fileref_popup(opts)
    opts = opts or {}

    -- create entries manually to be able to search for aliases
    local entries = {}
    local full_search = vim.fn.system "rg -e 'aliases:' --ignore-file .rgignore"
    -- loop over all files and their aliases
    for str in full_search:gmatch "([^\n]+)\n" do
        -- split stirng into filename and aliases
        local file, aliases = str:match "(.*):aliases:(.*)"
        -- add file without | as entry
        local fname = file:match "([^/.]+)%.(.*)$"
        entries[#entries + 1] = { fname, "", file }
        if fname:find "_" then
            local f_no_underscore = fname:gsub("_", " ")
            entries[#entries + 1] = { fname, f_no_underscore, file }
        end
        -- loop over all aliases and add {filename, alias} as entry
        for alias in aliases:gsub("%s?", ""):gsub("\n", ""):gsub(",%s", "~"):gmatch "[^~]+" do
            if alias ~= "" then
                entries[#entries + 1] = { fname, alias, file }
            end
        end
    end

    -- entry creation done, create telescope picker
    pickers
        .new(opts, {
            prompt_title = "Reference File",
            finder = finders.new_table {
                results = entries,
                entry_maker = function(entry)
                    if entry[2] == "" then
                        return { display = entry[1], ordinal = entry[1], alias = false, filename = entry[3] }
                    else
                        return {
                            display = entry[1] .. "|" .. entry[2],
                            ordinal = entry[1] .. " " .. entry[2],
                            alias = true,
                            filename = entry[3],
                        }
                    end
                end,
            },
            sorter = conf.file_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    local prompt = action_state.get_current_picker(prompt_bufnr).sorter._discard_state.prompt
                    actions.close(prompt_bufnr)
                    -- if local prompt contains | then the text was probably completed using tab
                    -- -> do not open obsidian rename window, just input the text
                    if prompt:find "|" then
                        vim.api.nvim_put({ "[[" .. prompt .. "]] " }, "", false, true)
                        vim.api.nvim_input "a"
                    else
                        local filename = action_state.get_selected_entry().filename
                        obsidian_rename(filename)
                    end
                end)
                map("i", "<C-CR>", function()
                    local telematch = action_state.get_selected_entry()
                    local text = ""
                    if telematch ~= nil then
                        text = telematch.display
                    else
                        text = action_state.get_current_picker(prompt_bufnr).sorter._discard_state.prompt
                    end
                    actions.close(prompt_bufnr)

                    vim.api.nvim_put({ "[[" .. text .. "]] " }, "", false, true)
                    vim.api.nvim_input "a"
                end)

                -- autocomplete prompt according to the entry that is selected
                map("i", "<Tab>", function()
                    tabcomplete(prompt_bufnr)
                end)
                return true
            end,
        })
        :find()
end

M.mathlink = function()
    opts = opts or {}

    -- create entries manually to be able to search for aliases
    local entries = {}
    local full_search = vim.fn.system "rg -e 'mathlink:' --ignore-file .rgignore"
    -- loop over all files and their aliases
    for str in full_search:gmatch "([^\n]+)\n" do
        -- split stirng into filename and aliases
        local file, mathlinks = str:match "(.*):mathlink:%s?(.*)"
        -- add file without | as entry
        local fname = file:match("([^/.]+)%.(.*)$"):gsub(" ", "%20")
        -- loop over all aliases and add {filename, alias} as entry
        for mathlink in mathlinks:gsub("\n", ""):gsub(",,%s", "~"):gmatch "[^~]+" do
            if mathlink ~= "" and mathlink ~= " " then
                entries[#entries + 1] = { fname, mathlink, file }
            end
        end
    end


    -- entry creation done, create telescope picker
    pickers
        .new(opts, {
            prompt_title = "Mathlink (File)",
            finder = finders.new_table {
                results = entries,
                entry_maker = function(entry)
                    return {
                        display = entry[2] .. " <----- " .. entry[1],
                        ordinal = entry[1] .. " " .. entry[2],
                        filename = entry[3],
                        math = entry[2],
                        luasnip = "\\href{obsidian://open?vault=wiki&file=" .. entry[1] .. "}{" .. entry[2] .. "}"
                    }
                end,
            },
            sorter = conf.file_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    -- local prompt = action_state.get_current_picker(prompt_bufnr).sorter._discard_state.prompt
                    actions.close(prompt_bufnr)
                    local luasnip = action_state.get_selected_entry().luasnip
                    vim.fn.setreg("m", luasnip)
                    require('luasnip.extras.otf').on_the_fly("m")
                    -- if local prompt contains | then the text was probably completed using tab
                    -- -> do not open obsidian rename window, just input the text
                    -- vim.api.nvim_put({ telematch }, "", false, true)
                    -- vim.api.nvim_input "a"
                end)
                return true
            end,
        })
        :find()
end

return M

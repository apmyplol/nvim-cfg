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

local obsidian_rename = function(old_bufnr)
    actions.close(old_bufnr)
    local old_sel = action_state.get_selected_entry()
    local fname, ext = old_sel[1]:match "([^/.]+)%.(.*)$"
    fname = ext == "md" and fname or fname  .. "." .. ext
    local match = vim.fn.system("rg -e 'aliases:' " .. old_sel[1])
    local res = { fname }
    for str in match:gsub("aliases:%s?", ""):gsub("\n", ""):gsub(",%s", "~"):gmatch "[^~]+" do
        if str ~= "" then
            res[#res + 1] = str
        end
    end

    local opts = {}
    pickers.new(opts, {
        prompt_title = "Reference Naming",
        finder = finders.new_table {
            results = res,
            entry_maker = function(entry)
                local attach = entry == fname and "" or "|" .. entry
                return {
                    display = entry,
                    ordinal = entry,
                    attach = attach,
                }
            end,
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            --[[ local prompt_text = action_state.get_current_picker(prompt_bufnr).sorter._discard_state.prompt ]]
            actions.select_default:replace(function()
                local prompt_text = action_state.get_current_picker(prompt_bufnr).sorter._discard_state.prompt
                local selection = action_state.get_selected_entry()
                local text = selection ~= nil and selection.attach
                    or "|" .. prompt_text
                actions.close(prompt_bufnr)
                vim.api.nvim_put({ "[[" .. fname .. text .. "]] " }, "", false, true)
                -- vim.api.nvim_command "startinsert"
                -- vim.cmd("startinsert")
                vim.api.nvim_input "a"
            end)
            return true
        end,
    }):find()
end

function M.obsidian(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "Reference File",
        finder = finders.new_oneshot_job(find_command, opts),
        sorter = conf.file_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                obsidian_rename(prompt_bufnr)
            end)
            map("i", "<C-CR>", function()
                --[[ actions.close(prompt_bufnr) ]]
                local selection = action_state.get_selected_entry()[1]:match "([^/.]+)%..*$"
                selection = selection:find "_" == nil and selection or selection .. "|" .. selection:gsub("_", " ")

                vim.api.nvim_put({ "[[" .. selection .. "]] " }, "", false, true)
                vim.api.nvim_input "a"
            end)
            return true
        end,
    }):find()
end

M.main = function()
    --[[ M.obsidian(require("telescope.themes").get_dropdown {}) ]]
    M.obsidian()
end
return M

local M = {}

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local entry_display = require "telescope.pickers.entry_display"

local displayer = entry_display.create {
    seperator = "|",
    items = {
        { width = 35 },
        { remaining = true },
    },
}

local make_display = function(entry)
        print(vim.inspect(entry))
    return displayer {
        entry.ordinal,
        entry.desc,
    }
end

M.gradle = function()
    local commands = {
        { "application/run", "execute main method", "run" },
        { "verification/test", "execute students junit tests", "test" },
        { "verification/graderPublicRun", "execute public tests", "graderPublicRun" },
        { "verification/check", "execute all tests", "check" },
        { "build/mainBuildSubmission", "create submission file", "mainBuildSubmission" },
    }

    local opts = {}
    pickers
        .new(opts, {
            prompt_title = "Select gradle task",
            finder = finders.new_table {
                results = commands,
                entry_maker = function(entry)
                    return {
                        display = make_display,
                        ordinal = entry[1],
                        cmd = entry[3],
                        desc = entry[2]
                    }
                end,
            },
            sorter = conf.file_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    local entry = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    vim.fn.system("./gradlew " .. entry.cmd .. "&")
                end)
                return true
            end,
        })
        :find()
end

return M

local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local status_ok, treesitterps = pcall(require, "nvim-treesitter.parsers")
if not status_ok then
	return
end

-- treesitterps.get_parser_configs().matlab = {
-- 	install_info = {
-- 		url = "https://github.com/mstanciu552/tree-sitter-matlab.git",
-- 		files = { "src/parser.c" },
-- 		branch = "main",
-- 	},
-- 	filetype = "matlab",
-- }
treesitter.setup({
	ensure_installed = "all",
	sync_install = false,
	ignore_install = { "r" }, -- List of parsers to ignore installing
	highlight = {
		enable = false, -- false will disable the whole extension
		disable = { "octave", "r" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } },

	-- fancy rainbow braces

	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},

	-- plugin for commenting out based on file and language
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},

	-- playground for creating themes
	playground = {
		enable = false,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
		disable = { "c", "ruby" }, -- optional, list of language that will be disabled
		-- [options]
	},
})

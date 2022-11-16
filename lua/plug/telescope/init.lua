local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local status_ok, actions = pcall(require, "telescope.actions")
if not status_ok then
	return
end

local SETTINGS = {
	defaults = {
		riprep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix      = "  ",
		selection_caret    = "  ",
		entry_prefix       = "  ",
		initial_mode       = "insert",
		selection_strategy = "reset",
		sorting_strategy   = "ascending",
		layout_strategy    = "horizontal",
		layout_config      = {
			horizontal     = {
				prompt_position = "top",
				preview_width   = 0.55,
				results_width   = 0.8,
			},
			vertical       = { mirror = false },
			width          = 0.80,
			height         = 0.85,
			preview_cutoff = 120,
		},
		file_sorter          = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = {
			"luadisabled",
			"vimdisabled",
			"forks",
			".backup",
			".swap",
			".langservers",
			".session",
			".undo",
			".git/",
			"node_modules",
			"vendor",
			".cache",
			".vscode-server",
			".Desktop",
			".Documents",
			"classes",
			"quantumimage",
		},
		generic_sorter         = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display           = { "truncate" },
		winblend               = 0,
		border                 = {},
		borderchars            = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons         = true,
		set_env                = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer         = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer         = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer       = require("telescope.previewers").vim_buffer_qflist.new,
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings               = {
			i = {
				["<C-n>"]      = actions.cycle_history_next,
				["<C-p>"]      = actions.cycle_history_prev,
				["<C-j>"]      = actions.move_selection_next,
				["<C-k>"]      = actions.move_selection_previous,
				["<C-c>"]      = actions.close,
				["<Down>"]     = actions.move_selection_next,
				["<Up>"]       = actions.move_selection_previous,
				["<CR>"]       = actions.select_default,
				["<C-x>"]      = actions.select_horizontal,
				["<C-v>"]      = actions.select_vertical,
				["<C-t>"]      = actions.select_tab,
				["<C-u>"]      = actions.preview_scrolling_up,
				["<C-d>"]      = actions.preview_scrolling_down,
				["<PageUp>"]   = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
				["<Tab>"]      = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"]    = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"]      = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"]      = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"]      = actions.complete_tag,
				["<C-_>"]      = actions.which_key, -- keys from pressing <C-/>
			},

			n = {
				["q"]          = actions.close,
				["<esc>"]      = actions.close,
				["<CR>"]       = actions.select_default,
				["<C-x>"]      = actions.select_horizontal,
				["<C-v>"]      = actions.select_vertical,
				["<C-t>"]      = actions.select_tab,
				["<Tab>"]      = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"]    = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"]      = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"]      = actions.send_selected_to_qflist + actions.open_qflist,
				["j"]          = actions.move_selection_next,
				["k"]          = actions.move_selection_previous,
				["H"]          = actions.move_to_top,
				["M"]          = actions.move_to_middle,
				["L"]          = actions.move_to_bottom,
				["<Down>"]     = actions.move_selection_next,
				["<Up>"]       = actions.move_selection_previous,
				["gg"]         = actions.move_to_top,
				["G"]          = actions.move_to_bottom,
				["<C-u>"]      = actions.preview_scrolling_up,
				["<C-d>"]      = actions.preview_scrolling_down,
				["<PageUp>"]   = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
				["?"]          = actions.which_key,
			},
		},
	},
	extensions = {
		emoji = {
			action = function(emoji)
				-- vim.fn.setreg("*", emoji.value)
				-- print([[Press p or "*p to paste this emoji]] .. emoji.value)

				-- insert emoji when picked
				vim.api.nvim_put({ emoji.value }, "c", false, true)
			end,
		},
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd  = "rg", -- find command (defaults to `fd`)
		},
		file_browser = {
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
		},
	},
	extensions_list = { "themes", "terms" },
}

telescope.setup(SETTINGS)
telescope.load_extension("emoji")
telescope.load_extension("media_files")
telescope.load_extension("ui-select")
telescope.load_extension("file_browser")
telescope.load_extension('project')
-- telescope.load_extension('frecency')

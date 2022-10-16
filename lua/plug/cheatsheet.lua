local status_ok, cheatsheet = pcall(require, "cheatsheet")
if not status_ok then
	return
end

local status_ok, action = pcall(require, "cheatsheet.telescope.actions")
if not status_ok then
	return
end

local SETTINGS = {
	-- Whether to show bundled cheatsheets

	-- For generic cheatsheets like default, unicode, nerd-fonts, etc
	-- bundled_cheatsheets = {
	--     enabled = {},
	--     disabled = {},
	-- },
	bundled_cheatsheets = true,

	-- For plugin specific cheatsheets
	-- bundled_plugin_cheatsheets = {
	--     enabled = {},
	--     disabled = {},
	-- }
	bundled_plugin_cheatsheets = true,

	-- For bundled plugin cheatsheets, do not show a sheet if you
	-- don't have the plugin installed (searches runtimepath for
	-- same directory name)
	include_only_installed_plugins = true,

	-- Key mappings bound inside the telescope window
	telescope_mappings = {
		["<CR>"]   = action.select_or_fill_commandline,
		["<A-CR>"] = action.select_or_execute,
		["<C-Y>"]  = action.copy_cheat_value,
		["<C-E>"]  = action.edit_user_cheatsheet,
	},
}

cheatsheet.setup(SETTINGS)

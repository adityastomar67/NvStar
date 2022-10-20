local status_ok, minimap = pcall(require, "codewindow")
if not status_ok then
	return
end

local SETTINGS = {
	minimap_width      = 15,   -- The width of the text part of the minimap
	width_multiplier   = 4,    -- How many characters one dot represents
	use_lsp            = true, -- Use the builtin LSP to show errors and warnings
	use_treesitter     = true, -- Use nvim-treesitter to highlight the code
	exclude_filetypes  = {},   -- Choose certain filetypes to not show minimap on
	z_index            = 1,    -- The z-index the floating window will be on
	max_minimap_height = nil,  -- The maximum height the minimap can take (including borders)
}

minimap.setup(SETTINGS)
minimap.apply_default_keybinds()

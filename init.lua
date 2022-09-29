local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
	impatient.enable_profile()
end

local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

for _, source in ipairs({

	-- CORE
	"core.plugins",
	"core.maps",
	"core.options",
	"core.utils",
	"core.autocmds",
	"core.colorscheme",

	-- PLUGS
	"plug.notify",
	"plug.dashboard",
	"plug.whichkey",
	"plug.nvim-tree",
	"plug.ts-context",
	"plug.terminal",
	"plug.telescope",
	"plug.mason",
	"plug.cmp",
	"plug.lsp",
	"plug.lsp-installer",
	"plug.git-sign",
	"plug.bufferline",
	"plug.statusline",
	"plug.null-ls",
	"plug.todo-comments",

}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		local err = "Failed to load " .. source
		-- vim.api.nvim_err_writeln(err  .. "\n\n" .. fault)
		notify(err, "error")
	end
end

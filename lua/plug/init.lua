local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
	impatient.enable_profile()
end

local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

for _, source in ipairs({

	"plug.ui",
	"plug.whichkey",
	"plug.nvim-tree",
	"plug.ts-context",
	"plug.terminal",
	"plug.telescope",
	"plug.mason",
	"plug.cmp",
	"plug.lsp",
	"plug.trouble",
	"plug.todo-comments",
	"plug.hydra",
	"plug.cheatsheet",
	"plug.fzf",
	"plug.other",

}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		local err = "Failed to load " .. source .. "\n\n" .. fault
		notify(err, "error", {title = "Require Error"})
	end
end
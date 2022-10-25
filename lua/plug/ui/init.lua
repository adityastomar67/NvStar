local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
	impatient.enable_profile()
end

local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

for _, source in ipairs({

	"plug.ui.notify",
    "plug.ui.dashboard",
	"plug.ui.bufferline",
	"plug.ui.git-sign",
	"plug.ui.minimap",
	"plug.ui.statusline",
	-- "plug.ui.noice",

}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		local err = "Failed to load " .. source .. "\n\n" .. fault
		notify(err, "error", {title = "Require Error"})
	end
end
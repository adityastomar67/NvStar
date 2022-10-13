for _, source in ipairs({

    "plug.hydra.dap",
    "plug.hydra.git",
    "plug.hydra.options",
    "plug.hydra.spelling",
    "plug.hydra.telescope",
    "plug.hydra.windows",

}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		local err = "Failed to load " .. source .. "\n\n" .. fault
		notify(err, "error")
	end
end



local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
    impatient.enable_profile()
end

for _, source in ipairs({

    -- CORE
    "core.plugins",
    "core.abbreviations",
    "core.maps",
    "core.options",
    "core.utils",
    "core.autocmds",
    "core.colorscheme",
    "plug",

}) do
    local status_ok, fault = pcall(require, source)
    if not status_ok then
        local err = "Failed to load " .. source .. "\n\n" .. fault
        notify(err, "error", { title = "Require Error" })
    end
end

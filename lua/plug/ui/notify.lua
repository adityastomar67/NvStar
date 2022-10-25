local status_ok, notify = pcall(require, "notify")
if not status_ok then
    return
end

local SETTINGS = {
    icons = {
        DEBUG = "  ",
        ERROR = "  ",
        WARN  = "  ",
        TRACE = "  ",
        INFO  = "  "
    },
    fps        = 60,
    max_height = 5,
    max_widht  = 10,
    render     = "minimal"
}

notify.setup(SETTINGS)

local snip_status_ok, dynamic = pcall(require, "cmp_dynamic")
if not snip_status_ok then
	return
end

local Date = require("cmp_dynamic.utils.date")

local SETTINGS = {
    {
        label = "today",
        insertText = 1,
        cb = {
            function()
                return os.date("%Y/%m/%d")
            end,
        },
        cache = true -- default: false
    },
    {
        label = "next Monday",
        insertText = 1,
        cb = {
            function()
                return Date.new():add_date(7):day(1):format("%Y/%m/%d")
            end,
        },
    },
}

dynamic.register(SETTINGS)

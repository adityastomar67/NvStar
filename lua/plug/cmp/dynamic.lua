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
    {
        label = "next Tuesday",
        insertText = 1,
        cb = {
            function()
                return Date.new():add_date(7):day(2):format("%Y/%m/%d")
            end,
        },
    },
    {
        label = "next Wednesday",
        insertText = 1,
        cb = {
            function()
                return Date.new():add_date(7):day(3):format("%Y/%m/%d")
            end,
        },
    },
    {
        label = "next Thursday",
        insertText = 1,
        cb = {
            function()
                return Date.new():add_date(7):day(4):format("%Y/%m/%d")
            end,
        },
    },
    {
        label = "next Friday",
        insertText = 1,
        cb = {
            function()
                return Date.new():add_date(7):day(5):format("%Y/%m/%d")
            end,
    },
    {
        label = "next Saturday",
        insertText = 1,
        cb = {
            function()
                return Date.new():add_date(7):day(6):format("%Y/%m/%d")
            end,
        },
    },
    {
        label = "next Sunday",
        insertText = 1,
        cb = {
            function()
                return Date.new():add_date(7):day(7):format("%Y/%m/%d")
            end,
        },
    },
    }
}

dynamic.register(SETTINGS)

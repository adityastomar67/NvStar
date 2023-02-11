local snip_status_ok, comment = pcall(require, "nvim_comment")
if not snip_status_ok then
	return
end

local snip_status_ok, hop = pcall(require, "hop")
if not snip_status_ok then
	return
end

local snip_status_ok, autopair = pcall(require, "nvim-autopairs")
if not snip_status_ok then
	return
end


comment.setup({})
autopair.setup({})
hop.setup({ keys = 'etovxqpdygfblzhckisuran' })

require('hlargs').setup {
    color = '#FFEEAF',
}

local api = require("core.utils").get_api_key()
require('neural').setup({
    open_ai = {
        api_key = api
    }
})
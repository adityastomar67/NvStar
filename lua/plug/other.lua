local status, comment = pcall(require, "nvim_comment")
if not status then
	return
end

local status, autopair = pcall(require, "nvim-autopairs")
if not status then
	return
end

local status, leap = pcall(require, "leap")
if not status then
	return
end

local status, flit = pcall(require, "flit")
if not status then
	return
end

local status, neural = pcall(require, "neural")
if not status then
	return
end

comment.setup({})
autopair.setup({})
leap.add_default_mappings()
flit.setup {
  keys = { f = 'f', F = 'F', t = 't', T = 'T' },
  -- A string like "nv", "nvo", "o", etc.
  labeled_modes = "nx",
  multiline = true,
  -- Like `leap`s similar argument (call-specific overrides).
  -- E.g.: opts = { equivalence_classes = {} }
  opts = {}
}
-- hop.setup({ keys = 'etovxqpdygfblzhckisuran' })

-- require('hlargs').setup {
--     color = '#FFEEAF',
-- }

local api = require("core.utils").get_api_key()
neural.setup({
    open_ai = {
        api_key = api
    }
})

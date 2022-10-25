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
	"core.abbreviations",
	"core.maps",
	"core.options",
	"core.utils",
	"core.autocmds",
	"core.colorscheme",
    "plug"

}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		local err = "Failed to load " .. source .. "\n\n" .. fault
		notify(err, "error", {title = "Require Error"})
	end
end


-- Temporary
vim.cmd([[set showtabline=0]])

vim.cmd([[
	function! Syn()
		for id in synstack(line("."), col("."))
		  echo synIDattr(id, "name")
		endfor
	  endfunction
	  command! -nargs=0 Syn call Syn()
]])

vim.cmd[[lua require('core.utils.toggle').toggle_transparency()]]
-- vim.cmd[[source ~/.config/nvim/lua/core/doc.vim]]

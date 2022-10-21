local status_ok, fzf = pcall(require, "fzf-lua")
if not status_ok then
	return
end

fzf.setup({})

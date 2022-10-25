local snip_status_ok, tabnine = pcall(require, "cmp_tabnine.config")
if not snip_status_ok then
	return
end

local SETTINGS = {
	max_lines                = 1000,
	max_num_results          = 20,
	sort                     = true,
	run_on_every_keystroke   = true,
	snippet_placeholder      = "..",
	show_prediction_strength = false,
}

tabnine.setup(SETTINGS)
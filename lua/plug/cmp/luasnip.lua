local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
	return
end

local key = vim.keymap.set

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/bin/snippets/lua_snip/" })
ls.config.setup({ store_selection_keys = "<A-p>" })

vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])

local types = require("luasnip.util.types")
ls.config.set_config({
	history             = true,                        --keep around last snippet local to jump back
	updateevents        = "TextChanged,TextChangedI", --update changes as you type
	enable_autosnippets = true,
	ext_opts            = {
		[types.choiceNode] = {
			active = {
				virt_text = { { " ●" } },
			},
		},
	},
})

key({ "i", "s" }, "<c-s>", "<Esc>:w<cr>")
key({ "i", "s" }, "<c-u>", '<cmd>lua require("luasnip.extras.select_choice")()<cr><C-c><C-c>')

key({ "i", "s" }, "<a-p>", function()
	if ls.expand_or_jumpable() then
		ls.expand()
	end
end, { silent = true })

key({ "i", "s" }, "<A-y>", "<Esc>o", { silent = true })

key({ "i", "s" }, "<a-k>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })
key({ "i", "s" }, "<a-j>", function()
	if ls.jumpable(1) then
		ls.jump(1)
	end
end, { silent = true })

key({ "i", "s" }, "<a-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	else
		-- print current time
		local t = os.date("*t")
		local time = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
		print(time)
	end
end)
key({ "i", "s" }, "<a-h>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)

key("n", "<Leader><CR>", "<cmd>LuaSnipEdit<cr>", { silent = true, noremap = true })

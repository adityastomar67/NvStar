local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

require("plug.cmp.dynamic")
require("plug.cmp.tabnine")
require("plug.cmp.luasnip")

vim.opt.completeopt = "menuone,noselect"

local function load_snippets()
	local snippets_dir1 = vim.fn.stdpath("plug") .. "luasnip_snippets"
	local snippets_dir2 = vim.fn.stdpath("plug") .. "friendly-snippets"
	local snippets_dir3 = vim.fn.stdpath("plug") .. "snippets"

	if vim.fn.isdirectory(snippets_dir1) == 0 then
		print("Cloning snippets to" .. snippets_dir1)
		vim.fn.system({"git", "clone", "https://github.com/adityastomar67/LuaSnip-snippets.nvim.git", snippets_dir1})
	end
	if vim.fn.isdirectory(snippets_dir2) == 0 then
		print("Cloning snippets to" .. snippets_dir2)
		vim.fn.system({"git", "clone", "https://github.com/adityastomar67/friendly-snippets.git", snippets_dir2})
	end

	require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippets_dir1 .. "/lua/luasnip_snippets" } })
	require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippets_dir2 } })
	-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippets_dir3 } })
end
load_snippets()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local has_any_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local SETTINGS = {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-y>"] = cmp.config.disable,
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = require("plug.lspkind").cmp_format({
			with_text = true,
			menu = {
				nvim_lsp         = "[LSP]",
				luasnip          = "[LuaSnip]",
				buffer           = "[Buffer]",
				nvim_lua         = "[Lua]",
				ultisnips        = "[UltiSnips]",
				vsnip            = "[vSnip]",
				treesitter       = "[treesitter]",
				look             = "[Look]",
				copilot          = "[Copilot]",
				path             = "[Path]",
				spell            = "[Spell]",
				calc             = "[Calc]",
				emoji            = "[Emoji]",
				neorg            = "[Neorg]",
				cmp_openai_codex = "[Codex]",
				cmp_tabnine      = "[TabNine]",
				dynamic          = "[Dynamic]",
			},
		}),
	},
	sources = {
		{ name = "luasnip", group_index = 2 },
		{
			name = "copilot",
			group_index = 2,
			trigger_characters = {
				".",
				":",
				"(",
				"'",
				'"',
				"[",
				",",
				"#",
				"*",
				"@",
				"|",
				"=",
				"-",
				"{",
				"/",
				"\\",
				"+",
				"?",
				" ",
			},
		},
		{ name = "nvim_lsp"          , group_index = 2 } ,
		{ name = "dynamic"           , group_index = 2 } ,
		{ name = "cmp_tabnine"       , group_index = 2 } ,
		{ name = "cmp_openai_codex"  , group_index = 2 } ,
		{ name = "path"              , group_index = 2 } ,
		{ name = "buffer"            , group_index = 2 } ,
		{ name = "neosnippet" } ,
	},
	confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false },
	window       = {
		documentation = cmp.config.window.bordered(),
		completion    = cmp.config.window.bordered(),
	},
	experimental = { ghost_text = false },
	-- view         = { entries = 'native' }
}

cmp.setup(SETTINGS)

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path"   , max_item_count = 5 },
	}, {
		{ name = "cmdline", max_item_count = 15 },
	}),
})

-- lsp_document_symbols
cmp.setup.cmdline("/", {
	sources = cmp.config.sources({
		{ name = "nvim_lsp_document_symbol", max_item_count = 8, keyword_length = 3 },
	}, {
		{ name = "buffer"                  , max_item_count = 5, keyword_length = 5 },
	}),
})

-- Database completion
vim.api.nvim_exec(
	[[
        " autocmd! FileType sql setlocal omnifunc=vim_dadbod_completion#omni
        autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
    ]],
	false
)

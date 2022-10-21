local status_ok, wk = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	plugins = {
		marks     = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling  = {
			enabled     = false, -- enabling this will show WhichKey when pressing z = to select spelling suggestions
			suggestions = 20,    -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators    = true,  -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions      = true,  -- adds help for motions
			text_objects = true,  -- help for text objects triggered after entering an operator
			windows      = false, -- default bindings on <c-w>
			nav          = true,  -- misc bindings to work with windows
			z            = true,  -- bindings for folds, spelling and others prefixed with z
			g            = true,  -- bindings for prefixed with g
		},
	},
	icons = {
		breadcrumb = "» ", -- symbol used in the command line area that shows your active key combo
		separator  = "➜ ", -- symbol used between a key and it's label
		group      = "+",  -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up   = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border   = "none",         -- none, single, double, shadow
		position = "bottom",       -- bottom, top
		margin   = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding  = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height  = { min = 4, max  = 25 }, -- min and max height of the columns
		width   = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3,                      -- spacing between columns
		align   = "left",                 -- align columns left, center or right
	},
	hidden             = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	ignore_missing     = false,  -- enable this to hide mappings for which you didn't specify a label
	show_help          = true,   -- show help message on the command line when the popup is visible
	triggers           = "auto", -- automatically setup triggers
	-- triggers           = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
	-- disable the WhichKey popup for certain buf types and file types.
	-- Disabled by deafult for Telescope
	disable = { buftypes = {}, filetypes = { "TelescopePrompt" } },
}

local n_opts = { prefix = "<leader>", mode = "n" }
local v_opts = { prefix = "<leader>", mode = "v" }
local i_opts = { prefix = "<leader>", mode = "i" }

local v_mappings = {
	["/"] = { ":'<,'>CommentToggle<CR>", "Comment Toggle" },
	I     = { '<cmd>lua require("plug.toggle").toggle()<CR>', "Toggle Inverse" },
	s     = {
		name = "Text",
		a    = { ":SimpleAlign ", "Align Text" },
		r    = {
			":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
			"Replace Instances",
		},
	},
}
-- local i_mappings = {
--     R = {"<ESC><cmd>TermExec cmd=\"clear && prog %\"<CR>", "Run Current File"}
-- }
local n_mappings = {
	["="] = { "<cmd>lua vim.lsp.buf.format { async = true }<CR>"   , "Format Document" }    ,
	["_"] = { "<C-w>s"                                             , "Split Horizontally" } ,
	["|"] = { "<C-w>v"                                             , "Split Vertically" }   ,
	["/"] = { "<cmd>CommentToggle<CR>"                             , "Comment Toggle" }     ,
	C     = { '<cmd>lua require("core.utils").choose_colors()<CR>' , "Choose Theme" }       ,
	I     = { '<cmd>lua require("plug.toggle").toggle()<CR>'       , "Inverse" }            ,
	y     = { "ggVGy"                                              , "Yank Full Document" } ,
	T     = {
		name = "Toggle Options"                                             ,
		a    = { "<cmd>set invlist<CR>"                                     , "Toggle Whitespace" }       ,
		l    = { "<cmd>set invcursorline<CR>"                               , "Toggle Cursor Line" }      ,
		d    = { "<cmd>set invcursorcolumn<CR>"                             , "Toggle Cursor Column" }    ,
		f    = { "<cmd>set invfoldenable<CR>"                               , "Toggle Fold" }             ,
		g    = { "<cmd>set invspell<CR>"                                    , "Toggle Spell" }            ,
		j    = { "<cmd>set invrelativenumber<CR>"                           , "Toggle Relative Numbers" } ,
		k    = { "<cmd>set invwrap<CR>"                                     , "Toggle Wrap" }             ,
		z    = { "<cmd>set invrnu invnu<CR>"                                , "Toggle Line Numbers" }     ,
		m    = { "<cmd>lua require'codewindow'.toggle_minimap()<CR>"        , "Toggle Minimap"}           ,
		c    = { '<cmd>lua require("core.utils").toggle_cmp()<CR>'          , "Toggle Completions" }      ,
		t    = { '<cmd>lua require("core.utils").toggle_transparency()<CR>' , "Toggle Transparency" }     ,
	},
	q     = {
		name = "File Options",
		q    = { "<cmd>q!<cr>"      , "Quit" }                ,
		Q    = { "<cmd>q<cr>"       , "Quit Without Saving" } ,
		w    = { "<cmd>wq<cr>"      , "Save & Quit" }         ,
		s    = { "<cmd>w<cr>"       , "Save" }                ,
		S    = { "<cmd>wa<cr>"      , "Save All Opened" }     ,
		x    = { "<cmd>bdelete<cr>" , "Close" }               ,
	},
	a = {
		name = "Coding Assistance",
		g    = { "<cmd>Copilot panel<CR>"                                             , "Copilot Panel" }          ,
		b    = { "<cmd>Cheatsheet<CR>"                                                , "Builtin Cheats" }         ,
		c    = { "<cmd>lua require('core.utils').cht()<CR>"                           , "Cheat.sh" }               ,
		s    = { "<cmd>lua require('core.utils').so_input()<CR>"                      , "StackOverflow" }          ,
		i    = { "<cmd>lua require('core.utils').interactive_cheatsheet_toggle()<CR>" , "Interactive Cheatsheet" } ,
		o    = { "<cmd>lua require('core.utils').complete()<CR>"                      , "OpenAI Codex"}
	},
	t = {
		name = "Terminal",
		t    = { '<cmd>TermExec size=10 direction=horizontal cmd="clear"<CR>' , "Split Below" }       ,
		f    = { '<cmd>TermExec size=30 direction=float cmd="clear"<CR>'      , "Floating Terminal" } ,
		l    = { "<cmd>LazyGit<CR>"                                           , "LazyGit" }           ,
	},
	p = {
		name = "Packer"                                ,
		r    = { "<cmd>PackerClean<cr>"                , "Remove Unused Plugins" } ,
		c    = { "<cmd>PackerCompile profile=true<cr>" , "Recompile Plugins" }     ,
		i    = { "<cmd>PackerInstall<cr>"              , "Install Plugins" }       ,
		p    = { "<cmd>PackerProfile<cr>"              , "Packer Profile" }        ,
		s    = { "<cmd>PackerSync<cr>"                 , "Sync Plugins" }          ,
		S    = { "<cmd>PackerStatus<cr>"               , "Packer Status" }         ,
		u    = { "<cmd>PackerUpdate<cr>"               , "Update Plugins" }        ,
	},
	s = {
		name = "Something Else",
		h    = { "<cmd>!chmod +x % && source %<CR>"                 , "Run Shell Script" }    ,
		o    = { "<cmd>lua require('core.utils').source_file()<CR>" , "Source Current File" } ,
	},
	l = {
		name = "LSP",
		R    = { "<cmd>Trouble lsp_references<cr>"                                  , "Trouble References" }        ,
		a    = { "<cmd>lua vim.lsp.buf.code_action()<CR>"                           , "Code Action" }               ,
		d    = { "<cmd>lua require('telescope.builtin').diagnostics()<CR>"          , "Diagnostics" }               ,
		f    = { "<cmd>Lspsaga lsp_finder<CR>"                                      , "Finder" }                    ,
		i    = { "<cmd>LspInfo<CR>"                                                 , "Lsp Info" }                  ,
		n    = { "<cmd>lua vim.lsp.buf.rename()<CR>"                                , "Rename" }                    ,
		r    = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>"       , "References" }                ,
		s    = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>" , "Document Symbols" }          ,
		t    = { "<cmd>TroubleToggle document_diagnostics<CR>"                      , "Trouble" }                   ,
		L    = { "<cmd>lua vim.lsp.codelens.refresh()<CR>"                          , "Refresh CodeLens" }          ,
		l    = { "<cmd>lua vim.lsp.codelens.run()<CR>"                              , "Run CodeLens" }              ,
		D    = { "<cmd>lua require('core.utils').toggle_diagnostics()<CR>"          , "Toggle Inline Diagnostics" } ,
	},
	f = {
		name     = "Telescope"                                                  ,
		["<CR>"] = { "<cmd>Telescope<cr>"                                       , "Telescope Itself" } ,
		b        = { '<cmd>lua require("plug.telescope").buffers()<cr>'         , "Buffers" }          ,
		d        = { '<cmd>lua require("plug.telescope").xdg_config()<cr>'      , "Dotfiles" }         ,
		n        = { '<cmd>lua require("plug.telescope").nvim_files()<cr>'      , "Nvim Files" }       ,
		r        = { '<cmd>lua require("plug.telescope").search_oldfiles()<cr>' , "Recently Opened" }  ,
		e        = { "<cmd>Telescope emoji<cr>"                                 , "Emoji Picker" }     ,
		f        = { "<cmd>Telescope find_files<cr>"                            , "Find Files" }       ,
		m        = { "<cmd>Telescope media_files<cr>"                           , "Find Media" }       ,
		g        = { "<cmd>Telescope live_grep<cr>"                             , "Find with Word" }   ,
		t        = { "<cmd>Telescope file_browser<cr>"                          , "Browser" }          ,
		o        = { "<cmd>lua require('fzf-lua').files()<cr>"                                           , "Open File (FZF)" }  ,
	},
	g = {
		name = "Goto"                                         ,
		d    = { "<Cmd>lua vim.lsp.buf.definition()<CR>"      , "Definition" }      ,
		D    = { "<Cmd>lua vim.lsp.buf.declaration()<CR>"     , "Declaration" }     ,
		h    = { "<cmd>lua vim.lsp.buf.signature_help()<CR>"  , "Signature Help" }  ,
		I    = { "<cmd>Telescope lsp_implementations<CR>"     , "Implementation" }  ,
		b    = { "<cmd>lua vim.lsp.buf.type_definition()<CR>" , "Type Definition" } ,
	},
}

local function code_keymap()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
			vim.schedule(CodeRunner)
		end,
	})

	function CodeRunner()
		local bufnr      = vim.api.nvim_get_current_buf()
		local ft         = vim.api.nvim_buf_get_option(bufnr, "filetype")
		local fname      = vim.fn.expand("%:p:t")
		local keymap_c   = {} -- normal key map
		local keymap_c_v = {} -- visual key map

		if ft == "python" then
			keymap_c = {
				name = "Code",
				i = { "<cmd>cexpr system('refurb --quiet ' . shellescape(expand('%'))) | copen<cr>", "Inspect" },
				r = {
					"<cmd>update<cr><cmd>lua require('core.utils').open_term([[python3 ]] .. vim.fn.shellescape(vim.fn.getreg('%'), 1), {direction = 'float'})<cr>",
					"Run",
				},
				m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
			}
		elseif ft == "cpp" then
			keymap_c = {
				name = "Code",
				r = {
					"<cmd>update<cr><cmd>lua require('core.utils').open_term([[g++ -std=c++20 ]] .. vim.fn.shellescape(vim.fn.getreg('%'), 1) .. [[ && ./a.out && rm -f a.out]], {direction = 'float'})<cr>",
					"Run",
				},
			}
		elseif ft == "lua" then
			keymap_c = {
				name = "Code",
				r = {
					"<cmd>update<cr><cmd>lua require('core.utils').open_term([[lua ]] .. vim.fn.shellescape(vim.fn.getreg('%'), 1), {direction = 'float'})<cr>",
					"Run",
				},
			}
		elseif ft == "rust" then
			keymap_c = {
				name = "Code",
				r    = { "<cmd>execute 'Cargo run' | startinsert<cr>" , "Run" }           ,
				D    = { "<cmd>RustDebuggables<cr>"                   , "Debuggables" }   ,
				h    = { "<cmd>RustHoverActions<cr>"                  , "Hover Actions" } ,
				R    = { "<cmd>RustRunnables<cr>"                     , "Runnables" }     ,
			}
		elseif ft == "json" then
            keymap_c = { name = "Code", p = { "<cmd>update<cr><cmd>%!jq<cr>", "Prettify" } }
		elseif ft == "go" then
			keymap_c = { name = "Code", r = { "<cmd>GoRun<cr>", "Run" } }
		elseif ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
			keymap_c = {
				name = "Code"                                                         ,
				o    = { "<cmd>TypescriptOrganizeImports<cr>"                         , "Organize Imports" }   ,
				r    = { "<cmd>TypescriptRenameFile<cr>"                              , "Rename File" }        ,
				i    = { "<cmd>TypescriptAddMissingImports<cr>"                       , "Import Missing" }     ,
				F    = { "<cmd>TypescriptFixAll<cr>"                                  , "Fix All" }            ,
				u    = { "<cmd>TypescriptRemoveUnused<cr>"                            , "Remove Unused" }      ,
				R    = { "<cmd>lua require('config.neotest').javascript_runner()<cr>" , "Choose Test Runner" } ,
			}
		elseif ft == "java" then
			keymap_c = {
				name = "Code"                                                  ,
				o    = { "<cmd>lua require('jdtls').organize_imports()<cr>"    , "Organize Imports" }    ,
				v    = { "<cmd>lua require('jdtls').extract_variable()<cr>"    , "Extract Variable" }    ,
				c    = { "<cmd>lua require('jdtls').extract_constant()<cr>"    , "Extract Constant" }    ,
				t    = { "<cmd>lua require('jdtls').test_class()<cr>"          , "Test Class" }          ,
				n    = { "<cmd>lua require('jdtls').test_nearest_method()<cr>" , "Test Nearest Method" } ,
			}
			keymap_c_v = {
				name = "Code"                                                   ,
				v    = { "<cmd>lua require('jdtls').extract_variable(true)<cr>" , "Extract Variable" } ,
				c    = { "<cmd>lua require('jdtls').extract_constant(true)<cr>" , "Extract Constant" } ,
				m    = { "<cmd>lua require('jdtls').extract_method(true)<cr>"   , "Extract Method" }   ,
			}
		end

		if fname == "package.json" then
			keymap_c.v = { "<cmd>lua require('package-info').show()<cr>"           , "Show Version" }
			keymap_c.c = { "<cmd>lua require('package-info').change_version()<cr>" , "Change Version" }
		end

		if fname == "Cargo.toml" then
			keymap_c.u = { "<cmd>lua require('crates').upgrade_all_crates()<cr>", "Upgrade All Crates" }
		end

		if next(keymap_c) ~= nil then
			local k = { c = keymap_c }
			local o = {
				mode    = "n",
				silent  = true,
				noremap = true,
				buffer  = bufnr,
				prefix  = "<leader>",
				nowait  = true,
			}
			wk.register(k, o)
		end

		if next(keymap_c_v) ~= nil then
			local k = { c = keymap_c_v }
			local o = {
				mode    = "v",
				silent  = true,
				noremap = true,
				buffer  = bufnr,
				prefix  = "<leader>",
				nowait  = true,
			}
			wk.register(k, o)
		end
	end
end

code_keymap()

wk.setup(opts)
wk.register(n_mappings, n_opts)
wk.register(v_mappings, v_opts)
-- wk.register(i_mappings, i_opts)

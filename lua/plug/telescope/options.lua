local status_ok, builtin = pcall(require, "telescope.builtin")
if not status_ok then
	return
end

local M = {}

M.xdg_config = function()
	builtin.find_files({
		prompt_title         = "XDG-CONFIG",
		-- prompt_prefix        = "▶  ",
		find_command         = { "fd", "--no-ignore-vcs" },
		sorting_strategy     = "ascending",
		file_ignore_patterns = { "lua-language-server", "chromium" },
		cwd                  = "~/.dotfiles",
		layout_config        = { width = 0.7, height = 0.3 },
		results_height       = 20,
		hidden               = true,
		previewer            = false,
		borderchars          = {
			{ "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		},
	})
end

M.buffers = function()
	builtin.buffers({
		prompt_title         = "BUFFERS",
		-- prompt_prefix        = "▶  ",
		sorting_strategy     = "ascending",
		file_ignore_patterns = { "lua-language-server", "chromium" },
		previewer            = false,
		layout_config        = { width = 0.5, height = 0.3 },
		hidden               = true,
	})
end

M.nvim_files = function()
	builtin.find_files({
		prompt_title         = "NVIM-FILES",
		-- prompt_prefix        = "▶  ",
		previewer            = false,
		find_command         = { "fd", "--no-ignore-vcs" },
		sorting_strategy     = "ascending",
		file_ignore_patterns = { ".git", "lua-language-server", "bin/" },
		cwd                  = "~/.config/nvim",
		hidden               = true,
	})
end

M.search_dotfiles = function()
	builtin.find_files({
		prompt_title     = "DOTFILES",
		-- prompt_prefix    = "▶  ",
		find_command     = { "fd", "--no-ignore-vcs" },
		shorten_path     = true,
		sorting_strategy = "ascending",
		cwd              = vim.env.DOTFILES,
		hidden           = true,
		previewer        = false,
		layout_config    = { height = 0.3, width = 0.5 },
	})
end

M.search_oldfiles = function()
	builtin.oldfiles({
		prompt_title     = "RECENT-FILES",
		-- prompt_prefix    = "▶  ",
		previewer        = false,
		shorten_path     = true,
		sorting_strategy = "ascending",
		hidden           = true,
		layout_config    = { height = 0.3, width = 0.5 },
	})
end

M.grep_dotfiles = function()
	builtin.live_grep({
        prompt_title     = "GREP-DOTFILES",
        -- prompt_prefix    = "▶  ",
        shorten_path     = true,
        sorting_strategy = "ascending",
        cwd              = vim.env.DOTFILES,
        hidden           = true,
	})
end

M.grep_wiki = function()
	builtin.live_grep({
	    hidden        = true,
	    search_dirs   = { "~/.dotfiles/wiki" },
	    --  prompt_prefix = "▶  ",
	    prompt_title  = "GREP-WIKI",
	    path_display  = { "smart" },
    })
end

M.git_branches = function()
	builtin.git_branches({
        -- prompt_prefix = "▶  ",
        prompt_title    = "GIT-BRANCHES",
        path_display    = { "smart" },
        attach_mappings = function(prompt_bufnr, map)
            map("i", "<c-d>", actions.git_delete_branch)
            map("n", "dd", actions.git_delete_branch)
            return true
        end,
	})
end

M.installed_plugins = function()
	builtin.find_files({
        hidden        = true,
        cwd           = vim.fn.stdpath("data") .. "/site/pack/packer/start/",
        -- prompt_prefix = "▶  ",
        prompt_title  = "INSTALLED-PLUGS",
        path_display  = { "smart" },
	})
end

return M
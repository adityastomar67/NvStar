local actions = require("telescope.actions")
local options = {
    defaults = {
        riprep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case"
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8
            },
            vertical = {mirror = false},
            width = 0.80,
            height = 0.85,
            preview_cutoff = 120
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {
            "luadisabled", "vimdisabled", "forks", ".backup", ".swap",
            ".langservers", ".session", ".undo", ".git/", "node_modules",
            "vendor", ".cache", ".vscode-server", ".Desktop", ".Documents",
            "classes", "quantumimage"
        },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = {"truncate"},
        winblend = 0,
        border = {},
        borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
        color_devicons = true,
        set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,
                ["<Tab>"] = actions.toggle_selection +
                    actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection +
                    actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist +
                    actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key -- keys from pressing <C-/>
            },

            n = {
                ["q"] = actions.close,
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                ["<Tab>"] = actions.toggle_selection +
                    actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection +
                    actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist +
                    actions.open_qflist,
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,
                ["?"] = actions.which_key
            }
        }
    },
    extensions = {
        emoji = {
            action = function(emoji)
                -- vim.fn.setreg("*", emoji.value)
                -- print([[Press p or "*p to paste this emoji]] .. emoji.value)

                -- insert emoji when picked
                vim.api.nvim_put({ emoji.value }, 'c', false, true)
            end
        },
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = {"png", "webp", "jpg", "jpeg"},
            find_cmd = "rg" -- find command (defaults to `fd`)
        }
    },
    extensions_list = {"themes", "terms"}
}

require("telescope").setup(options)
require("telescope").load_extension("emoji")
require("telescope").load_extension("media_files")

local M = {}
M.xdg_config = function()
    require("telescope.builtin").find_files({
        prompt_title         = "XDG-CONFIG",
        prompt_prefix        = "▶  ",
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
    require("telescope.builtin").buffers({
        prompt_title         = "BUFFERS",
        prompt_prefix        = "▶  ",
        sorting_strategy     = "ascending",
        file_ignore_patterns = { "lua-language-server", "chromium" },
        previewer            = false,
        layout_config        = { width = 0.5, height = 0.3 },
        hidden               = true,
    })
end

M.nvim_files = function()
    require("telescope.builtin").find_files({
        prompt_title         = "NVIM-FILES",
        -- prompt_prefix        = "▶  ",
        previewer            = false,
        find_command         = { "fd", "--no-ignore-vcs" },
        sorting_strategy     = "ascending",
        file_ignore_patterns = { ".git" },
        cwd                  = "~/.config/nvim",
        hidden               = true,
    })
end

M.search_dotfiles = function()
    require("telescope.builtin").find_files({
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
    require("telescope.builtin").oldfiles({
        prompt_title     = "OLDFILES",
        -- prompt_prefix    = "▶  ",
        previewer        = false,
        shorten_path     = true,
        sorting_strategy = "ascending",
        hidden           = true,
        layout_config    = { height = 0.3, width = 0.5 },
    })
end

M.grep_dotfiles = function()
    require("telescope.builtin").live_grep({
        prompt_title     = "GREP-DOTFILES",
        -- prompt_prefix    = "▶  ",
        shorten_path     = true,
        sorting_strategy = "ascending",
        cwd              = vim.env.DOTFILES,
        hidden           = true,
    })
end

M.grep_wiki = function()
    local opts = {}
    opts.hidden        = true
    opts.search_dirs   = { "~/.dotfiles/wiki" }
    -- opts.prompt_prefix = "▶  "
    opts.prompt_title  = "GREP-WIKI"
    opts.path_display  = { "smart" }
    require("telescope.builtin").live_grep(opts)
end

M.git_branches = function()
    local opts = {}
    -- opts.prompt_prefix = "▶  "
    opts.prompt_title  = "GIT-BRANCHES"
    opts.path_display  = { "smart" }
    opts.attach_mappings = function(prompt_bufnr, map)
        map("i", "<c-d>", actions.git_delete_branch)
        map("n", "dd", actions.git_delete_branch)
        return true
    end
    require("telescope.builtin").git_branches(opts)
end

M.installed_plugins = function()
    local opts = {}
    opts.hidden        = true
    opts.cwd           = vim.fn.stdpath("data") .. "/site/pack/packer/start/"
    -- opts.prompt_prefix = "▶  "
    opts.prompt_title  = "INSTALLED-PLUGS"
    opts.path_display  = { "smart" }
    require("telescope.builtin").find_files(opts)         
end

return M
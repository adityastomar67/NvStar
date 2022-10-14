local winsize = require("core.utils").winsize
local mode = require("core.constants").modes
local map = require("core.utils").map
local nvim_tree_events = require("nvim-tree.events")

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then return end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then return end

local tree_cb = nvim_tree_config.nvim_tree_callback
vim.g.nvim_tree_width = 25

local DEFAULT_WIDTH = 25

local function inc_width()
    local width, _height = winsize()
    local new_width = width + 10
    vim.cmd(string.format("NvimTreeResize %d", new_width))
end

local function dec_width()
    local width, _height = winsize()
    local new_width = width - 10
    if new_width < DEFAULT_WIDTH then return end
    vim.cmd(string.format("NvimTreeResize %d", new_width))
end

local SETTINGS = {
    renderer = {
        highlight_opened_files = "name",
        indent_markers = {enable = true},
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "✪",
                    unmerged = "☆",
                    renamed = "✺",
                    deleted = "",
                    untracked = "✵",
                    ignored = "°"
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = ""
                }
            },
            show = {git = true, folder = true, file = true, folder_arrow = true}
        }
    },
    actions = {
        open_file = {
            window_picker = {
                exclude = {
                    filetype = {"packer", "qf"},
                    buftype = {"terminal", "help"}
                }
            }
        }
    },
    filters = {exclude = {".git", "node_modules", ".cache"}},
    update_focused_file = {enable = true},
    hijack_directories = {enable = true},
    view = {
        mappings = {
            custom_only = false,
            list = {
                {key = {"l", "<CR>", "o"}, cb = tree_cb("edit")},
                {key = "h", cb = tree_cb("close_node")},
                {key = "<C-v>", action = "vsplit"},
                {key = "<C-x>", action = "split"},
                {key = "a", action = "create"},
                {key = "I", action = "toggle_ignored"},
                {key = "H", action = "toggle_dotfiles"},
                {key = "R", action = "refresh"},
                {key = "=", action = "preview"},
                {key = "X", action = "xdg_open", action_cb = xdg_open},
                {key = "d", action = "remove"}, 
                {key = "r", action = "rename"},
                {key = "y", action = "copy_name"},
                {key = "Y", action = "copy_path"},
                {key = "gy", action = "copy_absolute_path"},
                {key = "q", action = "close"},
                {key = "W", action = "collapse_all"},
                {key = "S", action = "search_node"},
                {key = "<C-k>", action = "toggle_file_info"},
                {key = ">", action = "more_wide", action_cb = inc_width},
                {key = "<", action = "less_wide", action_cb = dec_width}
            }
        }
    },
    open_on_setup = true
}

nvim_tree.setup(SETTINGS)

vim.cmd([[
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])

local status_ok, wk = pcall(require, "which-key")
if not status_ok then return end

local opts = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20 -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        }
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = '<c-d>', -- binding to scroll down inside the popup
        scroll_up = '<c-u>' -- binding to scroll up inside the popup
    },
    window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2}, -- extra window padding [top, right, bottom, left]
        winblend = 0
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left" -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = {"j", "k"},
        v = {"j", "k"}
    },
    -- disable the WhichKey popup for certain buf types and file types.
    -- Disabled by deafult for Telescope
    disable = {buftypes = {}, filetypes = {"TelescopePrompt"}}
}

local n_opts = {prefix = "<leader>", mode = "n"}
local v_opts = {prefix = "<leader>", mode = "v"}
local i_opts = {prefix = "<leader>", mode = "i"}

local v_mappings = {
    s = {
        name = "Text",
        a = {":SimpleAlign ", "Align Text"},
        r = {
            ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
            "Replace Instances"
        }
    }
}
local i_mappings = {
    r = {"<ESC><cmd>TermExec cmd=\"clear && prog %\"<CR>", "Run Current File"}
}
local n_mappings = {
    r = {"<cmd>TermExec cmd=\"clear && prog %\"<CR>", "Run Current File"},
    z = {"<cmd>set invrnu invnu<CR>", "Toggle Line Numbers"},
    q = {
        name = "File Options",
        q = {"<cmd>q!<cr>", "Quit"},
        Q = {"<cmd>q<cr>", "Quit Without Saving"},
        w = {"<cmd>wq<cr>", "Save & Quit"},
        s = {"<cmd>w<cr>", "Save"},
        S = {"<cmd>wa<cr>", "Save All Opened"},
        x = {"<cmd>bdelete<cr>", "Close"}
    },
    a = {
        name = "Coding Assistance",
        c = {"<cmd>Cheat<CR>", "Cheat.sh"},
        s = {"<cmd>lua require('core.utils').so_input()<CR>", "StackOverflow"}
    },
    f = {
        name = "Telescope",
        b = {'<cmd>lua require("core.file").buffers()<cr>', "Buffers"},
        d = {'<cmd>lua require("core.file").xdg_config()<cr>', "Dotfiles"},
        n = {'<cmd>lua require("core.file").nvim_files()<cr>', "Nvim Files"},
        e = {"<cmd>Telescope emoji<cr>", "Emoji Picker"},
        f = {"<cmd>Telescope find_files<cr>", "Find Files"},
        g = {"<cmd>Telescope oldfiles<cr>", "Recently Opened"},
        m = {"<cmd>Telescope media_files<cr>", "Find Media"},
        r = {"<cmd>Telescope live_grep<cr>", "Find String"}
    },
    t = {
        name = "Terminal",
        t = {
            '<cmd>TermExec size=10 direction=horizontal cmd="clear"<CR>',
            "Split Below"
        },
        f = {
            '<cmd>TermExec size=30 direction=float cmd="clear"<CR>',
            "Floating Terminal"
        },
        l = {"<cmd>LazyGit<CR>", "LazyGit"}
    },
    p = {
        name = "Packer",
        r = {"<cmd>PackerClean<cr>", "Remove Unused Plugins"},
        c = {"<cmd>PackerCompile profile=true<cr>", "Recompile Plugins"},
        i = {"<cmd>PackerInstall<cr>", "Install Plugins"},
        p = {"<cmd>PackerProfile<cr>", "Packer Profile"},
        s = {"<cmd>PackerSync<cr>", "Sync Plugins"},
        S = {"<cmd>PackerStatus<cr>", "Packer Status"},
        u = {"<cmd>PackerUpdate<cr>", "Update Plugins"}
    },
    s = {
        name = "Something Else",
        h = {"<cmd>!chmod +x % && source %<CR>", "Run Shell Script"},
        o = {"<cmd>so %<CR>", "Source Current File"}
    }
}

wk.setup(opts)
wk.register(n_mappings, n_opts)
wk.register(v_mappings, v_opts)
wk.register(i_mappings, i_opts)

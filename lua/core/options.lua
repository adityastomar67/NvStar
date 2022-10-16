local cmd = vim.cmd
local opt = vim.opt
local wo = vim.wo
local O = vim.o

---- :help options
opt.backup         = false                     -- creates a backup file
opt.icm            = 'split'                   -- To create a popup menu for selected search items
opt.clipboard      = "unnamedplus"             -- allows neovim to access the system clipboard
opt.completeopt    = { "menuone", "noselect" } -- mostly just for cmp
opt.fileencoding   = "utf-8"                   -- the encoding written to a file
opt.ignorecase     = true                      -- ignore case in search patterns
opt.mouse          = "a"                       -- allow the mouse to be used in neovim
opt.pumheight      = 10                        -- pop up menu height
opt.showmode       = false                     -- we don't need to see things like -- INSERT -- anymore
opt.smartcase      = true                      -- smart case
opt.smartindent    = true                      -- make indenting smarter again
opt.splitbelow     = false                     -- force all horizontal splits to go below current window
opt.splitright     = true                      -- force all vertical splits to go to the right of current window
opt.swapfile       = false                     -- creates a swapfile
opt.termguicolors  = true                      -- set term gui colors (most terminals support this)
opt.timeoutlen     = 1000                      -- time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile       = true                      -- enable persistent undo
opt.updatetime     = 300                       -- faster completion (4000ms default)
opt.expandtab      = true                      -- convert tabs to spaces
opt.shiftwidth     = 4                         -- the number of spaces inserted for each indentation
opt.tabstop        = 8                         -- insert 2 spaces for a tab
opt.number         = false                     -- set numbered lines
opt.relativenumber = false                     -- set relative numbered lines
opt.numberwidth    = 1                         -- set number column width to 2 {default 4}
opt.signcolumn     = "yes"                     -- always show the sign column, otherwise it would shift the text each time
opt.wrap           = true                      -- display lines as one long line
opt.scrolloff      = 8                         -- is one of my fav
opt.sidescrolloff  = 8                         -- how many lines to scroll when you scroll past the end of the screen
opt.scrollback     = 100000                    -- max number of screen lines to keep in scrollback
opt.writebackup    = false                     -- when file is edited by some program (or was written to file while editing with some program), it's not allowed to be edited
opt.background     = "dark"                    -- set the background color
opt.fillchars      = { eob = " " }             -- set the fill character for the end of the line
opt.laststatus     = 0                         -- set the last status line to 0
opt.hidden         = true                      -- hide the status line
opt.signcolumn     = "yes"                     -- show the sign column
opt.foldmethod     = "indent"
opt.foldnestmax    = 10
opt.foldenable     = false
opt.winblend       = 0
opt.foldlevel      = 2
opt.cole           = 1                         -- Conceal applied
opt.cursorline     = true                      -- highlight the current line
opt.cursorlineopt  = "number"                  -- show the line numbers highlighted
opt.formatoptions  = "l"
opt.formatoptions  = opt.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    + "q" -- Allow formatting comments w/ gq
    - "o" -- O and o, don't continue comments
    + "r" -- But do continue when pressing enter.
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- I'm not in gradeschool anymore
opt.shortmess:append "c"                    -- show the current cursor position
opt.whichwrap:append "<>[]hl"               -- set the wrap characters
opt.guicursor = {
    "n-v:block",
    "i-c-ci-ve:ver25",
    "r-cr:hor20",
    "o:hor50",
    "i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
    "sm:block-blinkwait175-blinkoff150-blinkon175",
}

O.hidden                      = true
O.fileencoding                = "utf-8"
O.splitbelow                  = true
O.splitright                  = true
opt.termguicolors             = true
-- O.conceallevel                = 0
O.showtabline                 = 2
O.showmode                    = false
O.backup                      = false
O.writebackup                 = false
O.updatetime                  = 300
O.timeoutlen                  = 1000
O.clipboard                   = "unnamedplus"
O.hlsearch                    = true
O.ignorecase                  = true
O.scrolloff                   = 0
O.sidescrolloff               = 5
O.mouse                       = "a"
wo.wrap                       = false
O.cursorline                  = true
O.tabstop                     = 4
O.shiftwidth                  = 0
vim.bo.shiftwidth                 = 0
O.autoindent                  = true
vim.bo.autoindent                 = true
O.expandtab                   = true
-- opt.fillchars:append("eob: ")
vim.bo.expandtab                  = true
vim.opt_local.bufhidden           = "wipe"
vim.opt_local.buflisted           = false
opt.laststatus                = 3
cmd("set lazyredraw")
cmd("filetype plugin indent on")

vim.g.lua_subversion = 0
vim.g.BetterLua_enable_emmylua = 0

local colorscheme = "nvstar"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

-- IMPROVE NEOVIM STARTUP
vim.g.loaded_python_provier     = 0
vim.g.loaded_python3_provider   = 0
vim.g.python_host_skip_check    = 1
vim.g.python_host_prog          = '/bin/python2'
vim.g.python3_host_skip_check   = 1
vim.g.python3_host_prog         = '/bin/python3'
vim.g.EditorConfig_core_mode    = 'external_command'
vim.g.matchparen_timeout        = 20
vim.g.matchparen_insert_timeout = 20
vim.g.do_filetype_lua           = 1
vim.g.did_load_filetypes        = 0
opt.pyxversion                  = 3
opt.pyxversion                  = 3

-- Give me some fenced codeblock goodness
vim.g.markdown_fenced_languages = {
    "html",
    "javascript",
    "javascriptreact",
    "typescript",
    "json",
    "css",
    "scss",
    "lua",
    "vim",
    "bash",
    "ts=typescript",
}

-- Disable builtins plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "matchit",
    "netrw",
    "netrwFileHandlers",
    "loaded_remote_plugins",
    "loaded_tutor_mode_plugin",
    "netrwPlugin",
    "netrwSettings",
    "rrhelper",
    "spellfile_plugin",
    "tar",
    "tarPlugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "matchparen", -- matchparen.nvim disables the default
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

local default_providers = {
	"node",
	"perl",
	"python3",
	"ruby",
}

for _, provider in ipairs(default_providers) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

vim.cmd([[let &statusline='%#Normal# ']])

-- Disable cmd area
vim.cmd([[lua vim.o.ch = 0]])

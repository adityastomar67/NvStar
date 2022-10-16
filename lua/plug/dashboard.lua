local status_ok, alpha = pcall(require, "alpha")
if not status_ok then 
	return 
end

local status_ok, dashboard = pcall(require, "alpha.themes.dashboard")
if not status_ok then 
	return 
end

math.randomseed(os.time())
local function pick_color()
    local colors = {"String", "Identifier", "Keyword", "Number"}
    return colors[math.random(#colors)]
end

local nvim_version_info = "        v" .. vim.version().major .. "." .. vim.version().minor .. "." ..	vim.version().patch

local function button(sc, txt, keybind, keybind_opts)
    local b = dashboard.button(sc, txt, keybind, keybind_opts)
    b.opts.hl          = "AlphaButton"
    b.opts.hl_shortcut = "AlphaFooter"
    return b
end

local logo = {
	"",	"",	"",	"",	"",	"",	"",	"",
    "███╗  ██╗         ╔██████╗████████╗ █████╗ ██████╗",
    "████╗ ██║██╗   ██╗║██╔═══╝╚══██╔══╝██╔══██╗██╔══██╗",
    "██╔██╗██║╚██╗ ██╔╝╚█████╗    ██║   ███████║██████╔╝",
    "██║╚████║ ╚████╔╝  ╚═══██╗   ██║   ██╔══██║██╔══██╗",
    "██║ ╚███║  ╚██╔╝  ██████╔╝   ██║   ██║  ██║██║  ██║",
    "╚═╝  ╚══╝   ╚═╝   ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝",
	"                                           " .. vim.fn.hostname(), "",
}

dashboard.section.header.val     = logo
dashboard.section.buttons.val    = {
    button("Leader + fr", "  Recent Files" , "<cmd>Telescope oldfiles<cr>"),
    button("Ctrl + b"   , "  File Explorer", "<cmd>NvimTreeToggle<cr>"),
    button("Leader + ff", "  Find File"    , "<cmd>Telescope find_files<cr>"),
    button("Leader + fr", "  Find Word"    , "<cmd>Telescope live_grep<cr>"),
    button("Leader + tf", "  Open Terminal", "<cmd>TermExec size=30 direction=float cmd=\"clear\"<CR>"),
    button("q/Q"        , "  Quit"         , ":qa<cr>")
}
dashboard.section.footer.val = {
	"",	"",	"",	"",	"",	"",	"",
	"I Dont want to be Horny,",
	" I Just wanna be happy. ",
	"          🚀            ",
	nvim_version_info, "",
  }
dashboard.section.header.opts.hl = pick_color()
dashboard.section.footer.opts.hl = pick_color()

local opts = {
    layout = {
        {type = "padding", val = 5}, dashboard.section.header,
        {type = "padding", val = 3}, dashboard.section.buttons,
        {type = "padding", val = 1}, dashboard.section.footer
    },
    opts = {margin = 5}
}
alpha.setup(dashboard.opts)

vim.cmd([[ autocmd FileType alpha setlocal nofoldenable]])
vim.api.nvim_create_augroup("alpha_tabline", {clear = true})
vim.api.nvim_create_autocmd("FileType", {
    group   = "alpha_tabline",
    pattern = "alpha",
    command = "set showtabline=0 laststatus=0 noruler"
})
vim.api.nvim_create_autocmd("FileType", {
    group    = "alpha_tabline",
    pattern  = "alpha",
    callback = function()
        vim.api.nvim_create_autocmd("BufUnload", {
            group   = "alpha_tabline",
            buffer  = 0,
            command = "set showtabline=2 ruler laststatus=3"
        })
    end
})

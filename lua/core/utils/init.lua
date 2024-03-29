local execute      = vim.api.nvim_command
local vim          = vim
local opt          = vim.opt -- global
local g            = vim.g   -- global for let options
local wo           = vim.wo  -- window local
local bo           = vim.bo  -- buffer local
local fn           = vim.fn  -- access vim functions
local cmd          = vim.cmd -- vim commands
local api          = vim.api -- access vim api
local API_KEY_FILE = vim.env.HOME .. "/.config/openai-codex/env"

vim.cmd([[
	function! Syn()
		for id in synstack(line("."), col("."))
		  echo synIDattr(id, "name")
		endfor
	  endfunction
	  command! -nargs=0 Syn call Syn()
]])

local M = {}

---@param c  string
local function hexToRgb(c)
	c = string.lower(c)
	return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
function M.blend(foreground, background, alpha)
	alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
	local bg = hexToRgb(background)
	local fg = hexToRgb(foreground)

	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.get_api_key()
    local file = io.open(API_KEY_FILE, "rb")
    if not file then return nil end
    local content = file:read "*a"
    content = string.gsub(content, "^%s*(.-)%s*$", "%1")
    file:close()
    return content
end

function M.trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function M.alias(func, alias, options)
    local opts = {args = false}

    if options then opts = vim.tbl_extend("force", opts, options) end

    if not opts.args then
        vim.cmd(string.format("command! %s lua %s()", alias, func))
        return
    end

    local tmpl = "command! -nargs=1 %s lua %s(make_arg_tbl(<q-args>))"
    local stmt = string.format(tmpl, alias, func)
    vim.cmd(stmt)
end

function M.make_arg_tbl(args)
    local result = {}
    local i = 1
    for arg in vim.gsplit(args, " ", false) do
        result[i] = arg
        i = i + 1
    end

    return unpack(result)
end

function M.check_back_space()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

function M.winsize()
    return unpack({
        vim.api.nvim_win_get_width(0), vim.api.nvim_win_get_height(0)
    })
end

function M.map(mode, mapping, cmd, options)
    local opts = {noremap = true}
    if options then opts = vim.tbl_extend("force", opts, options) end

    vim.api.nvim_set_keymap(mode, mapping, cmd, opts)
end

M.toggle_quicklist = function()
    if fn.empty(fn.filter(fn.getwininfo(), "v:val.quickfix")) == 1 then
        vim.cmd("copen")
    else
        vim.cmd("cclose")
    end
end

M.blockwise_clipboard = function()
    vim.cmd("call setreg('+', @+, 'b')")
    print("set + reg: blockwise!")
end

M.CountWordFunction = function()
    local hlsearch_status = vim.v.hlsearch
    local old_query = vim.fn.getreg("/") -- save search register
    local current_word = vim.fn.expand("<cword>")
    vim.fn.setreg("/", current_word)
    local wordcount = vim.fn.searchcount({maxcount = 1000, timeout = 500}).total
    local current_word_number = vim.fn.searchcount({
        maxcount = 1000,
        timeout = 500
    }).current
    vim.fn.setreg("/", old_query) -- restore search register
    print("[" .. current_word_number .. "/" .. wordcount .. "]")
    -- Below we are using the nvim-notify plugin to show up the count of words
    vim.cmd(
        [[highlight CurrenWord ctermbg=LightGray ctermfg=Red guibg=LightGray guifg=Black]])
    vim.cmd([[exec 'match CurrenWord /\V\<' . expand('<cword>') . '\>/']])
    -- require("notify")("word '" .. current_word .. "' found " .. wordcount .. " times")
end

M.flash_cursorline = function()
    local cursorline_state = lua
    print(vim.opt.cursorline:get())
    vim.opt.cursorline = true
    vim.cmd([[hi CursorLine guifg=#FFFFFF guibg=#FF9509]])
    vim.fn.timer_start(200, function()
        vim.cmd([[hi CursorLine guifg=NONE guibg=NONE]])
        if cursorline_state == false then vim.opt.cursorline = false end
    end)
end

M.ToggleQuickFix = function()
    if vim.fn.getqflist({winid = 0}).winid ~= 0 then
        vim.cmd([[cclose]])
    else
        vim.cmd([[copen]])
    end
end
vim.cmd(
    [[command! -nargs=0 -bar ToggleQuickFix lua require('core.utils').ToggleQuickFix()]])
vim.cmd([[cnoreab TQ ToggleQuickFix]])
vim.cmd([[cnoreab tq ToggleQuickFix]])

M.dosToUnix = function()
    M.preserve("%s/\\%x0D$//e")
    vim.bo.fileformat = "unix"
    vim.bo.bomb = true
    vim.opt.encoding = "utf-8"
    vim.opt.fileencoding = "utf-8"
end
vim.cmd([[command! Dos2unix lua require('core.utils').dosToUnix()]])

M.squeeze_blank_lines = function()
    if vim.bo.binary == false and vim.opt.filetype:get() ~= "diff" then
        local old_query = vim.fn.getreg("/") -- save search register
        M.preserve("sil! 1,.s/^\\n\\{2,}/\\r/gn") -- set current search count number
        local result = vim.fn.searchcount({maxcount = 1000, timeout = 500})
                           .current
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        M.preserve("sil! keepp keepj %s/^\\n\\{2,}/\\r/ge")
        M.preserve("sil! keepp keepj %s/^\\s\\+$/\\r/ge")
        M.preserve("sil! keepp keepj %s/\\v($\\n\\s*)+%$/\\r/e")
        if result > 0 then
            vim.api.nvim_win_set_cursor(0, {(line - result), col})
        end
        vim.fn.setreg("/", old_query) -- restore search register
    end
end

M.ReloadConfig = function()
    local hls_status = vim.v.hlsearch
    for name, _ in pairs(package.loaded) do
        if name:match("^cnull") then package.loaded[name] = nil end
    end
    dofile(vim.env.MYVIMRC)
    if hls_status == 0 then vim.opt.hlsearch = false end
end

M.preserve = function(arguments)
    local arguments = string.format("keepjumps keeppatterns execute %q",
                                    arguments)
    -- local original_cursor = vim.fn.winsaveview()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_command(arguments)
    local lastline = vim.fn.line("$")
    -- vim.fn.winrestview(original_cursor)
    if line > lastline then line = lastline end
    vim.api.nvim_win_set_cursor(0, {line, col})
end

M.changeheader = function()
    -- We only can run this function if the file is modifiable
    if not vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(),
                                       "modifiable") then return end
    if vim.fn.line("$") >= 7 then
        os.setlocale("en_US.UTF-8") -- show Sun instead of dom (portuguese)
        time = os.date("%a, %d %b %Y %H:%M")
        M.preserve("sil! keepp keepj 1,7s/\\vlast (modified|change):\\zs.*/ " ..
                       time .. "/ei")
    end
end

--------------------------- Colorscheme Choosing ---------------------------
M.choose_colors = function()
    local actions = require("telescope.actions")
    local actions_state = require("telescope.actions.state")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local sorters = require("telescope.sorters")
    local dropdown = require("telescope.themes").get_dropdown()

    function enter(prompt_bufnr)
        local selected = actions_state.get_selected_entry()

        local status_ok, _ = pcall(vim.cmd, "colorscheme " .. selected[1])
        if not status_ok then
            vim.notify("colorscheme " .. selected[1] .. " not found!")
            return
        end

        local cmd = "colorscheme " .. selected[1]
        vim.cmd(cmd)
        actions.close(prompt_bufnr)
    end

    function next_color(prompt_bufnr)
        actions.move_selection_next(prompt_bufnr)
        local selected = actions_state.get_selected_entry()
        local cmd = "colorscheme " .. selected[1]
        vim.cmd(cmd)
    end

    function prev_color(prompt_bufnr)
        actions.move_selection_previous(prompt_bufnr)
        local selected = actions_state.get_selected_entry()
        local cmd = "colorscheme " .. selected[1]
        vim.cmd(cmd)
    end

    -- local colors = vim.fn.getcompletion("", "color")

    local opts = {
        prompt_title = "Colorschemes",
        finder = finders.new_table({
            "nvstar", "wave", "onedark", "gruvbox", "tokyonight", "nord",
            "monokai", "everforest", "google-light", "edge", "sonokai",
            "material", "kanagawa", "dull"
        }),

        -- finder = finders.new_table(colors),
        sorter = sorters.get_generic_fuzzy_sorter({}),

        attach_mappings = function(prompt_bufnr, map)
            map("i", "<CR>", enter)
            map("i", "<C-j>", next_color)
            map("i", "<C-k>", prev_color)
            map("i", "<C-n>", next_color)
            map("i", "<C-p>", prev_color)
            return true
        end
    }

    local colors = pickers.new(dropdown, opts)

    colors:find()
end

--------------------------- Sourcing File ---------------------------
M.source_file = function()
    local buf = api.nvim_get_current_buf()
    local filename = api.nvim_buf_get_name(buf)
    local basename = fn.fnamemodify(filename, ":t")

    api.nvim_command("source " .. filename)
    api.nvim_command("lua require(\"notify\")(\"Sourced " .. basename .. "\", \"info\", {title = \"Neovim\"})")
end

--------------------------- Lazyloading Plugin ---------------------------
M.packer_lazy_load = function(plugin, timer)
    if plugin then
        timer = timer or 0
        vim.defer_fn(function() require("packer").loader(plugin) end, timer)
    end
end

return M

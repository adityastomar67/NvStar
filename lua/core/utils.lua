local execute = vim.api.nvim_command
local vim = vim
local opt = vim.opt -- global
local g = vim.g -- global for let options
local wo = vim.wo -- window local
local bo = vim.bo -- buffer local
local fn = vim.fn -- access vim functions
local cmd = vim.cmd -- vim commands
local api = vim.api -- access vim api

local M = {}

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

function M.warn(msg, name) vim.notify(msg, vim.log.levels.WARN, {title = name}) end

function M.error(msg, name) vim.notify(msg, vim.log.levels.ERROR, {title = name}) end

function M.info(msg, name) vim.notify(msg, vim.log.levels.INFO, {title = name}) end

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

M.map = function(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
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

local transparency = 0
M.toggle_transparency = function()
    if transparency == 0 then
        vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
        local transparency = 1
    else
        vim.cmd("hi Normal guibg=#0f0f0f ctermbg=NONE")
        local transparency = 0
    end
end
-- -- map('n', '<c-s-t>', '<cmd>lua require("core.utils").toggle_transparency()<cr>')

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

M.choose_colors = function()
    local actions = require("telescope.actions")
    local actions_state = require("telescope.actions.state")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local sorters = require("telescope.sorters")
    local dropdown = require("telescope.themes").get_dropdown()

    function enter(prompt_bufnr)
        local selected = actions_state.get_selected_entry()
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

        finder = finders.new_table({
            "nvstar", "wave", "onedark", "gruvbox", "tokyonight", "nord"
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

-- load plugin after entering vim ui
M.packer_lazy_load = function(plugin, timer)
    if plugin then
        timer = timer or 0
        vim.defer_fn(function() require("packer").loader(plugin) end, timer)
    end
end

-- For StackOverflow Assistance
function M.so_input()
    local buf = vim.api.nvim_get_current_buf()
    lang = ""
    file_type = vim.api.nvim_buf_get_option(buf, "filetype")
    vim.ui.input({prompt = "StackOverflow input: ", default = file_type .. " "},
                 function(input)
        local cmd = ""
        if input == "" or not input then
            return
        elseif input == "h" then
            cmd = "-h"
        else
            cmd = input
        end
        M.so_cmd(cmd)
    end)
end

local function open_split()
    vim.api.nvim_exec("vnew", true)
    vim.api.nvim_exec("terminal", true)
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(buf, "cheatsheet-" .. buf)
    vim.api.nvim_buf_set_option(buf, "filetype", "cheat")
    vim.api.nvim_buf_set_option(buf, "syntax", lang)
end

function M.so_cmd(cmd)
    open_split()
    local chan_id = vim.b.terminal_job_id
    local so_cmd = "clr && so " .. cmd
    vim.api.nvim_chan_send(chan_id, so_cmd .. "\n")
end

return M

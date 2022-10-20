local execute = vim.api.nvim_command
local vim = vim
local opt = vim.opt -- global
local g = vim.g -- global for let options
local wo = vim.wo -- window local
local bo = vim.bo -- buffer local
local fn = vim.fn -- access vim functions
local cmd = vim.cmd -- vim commands
local api = vim.api -- access vim api

local Job = require "plenary.job"

local M = {}

local API_KEY_FILE = vim.env.HOME .. "/.config/openai-codex/env"
local OPENAI_URL = "https://api.openai.com/v1/engines/davinci-codex/completions"
-- local OPENAI_URL = "https://api.openai.com/v1/engines/cushman-codex/completions"
local MAX_TOKENS = 300

local function get_api_key()
  local file = io.open(API_KEY_FILE, "rb")
  if not file then
    return nil
  end
  local content = file:read "*a"
  content = string.gsub(content, "^%s*(.-)%s*$", "%1") -- strip off any space or newline
  file:close()
  return content
end

local function trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

local Terminal = require("toggleterm.terminal").Terminal
local M = {}

local diagnostics_active = true
function M.toggle_diagnostics()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end

function M.open_term(cmd, opts)
    opts = opts or {}
    opts.size = opts.size or vim.o.columns * 0.5
    opts.direction = opts.direction or "vertical"
    opts.on_open = opts.on_open or default_on_open
    opts.on_exit = opts.on_exit or nil

    local new_term = Terminal:new{
        cmd = cmd,
        dir = "git_dir",
        auto_scroll = false,
        close_on_exit = false,
        start_in_insert = false,
        on_open = opts.on_open,
        on_exit = opts.on_exit
    }
    new_term:open(opts.size, opts.direction)
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

local cmp = 0
M.toggle_cmp = function()
    if cmp == 0 then
        vim.cmd("lua require('cmp').setup.buffer { enabled = false }")
        cmp = 1
    else
        vim.cmd("lua require('cmp').setup.buffer { enabled = true }")
        cmp = 0
    end
end

local transparency = 0
M.toggle_transparency = function()
    if transparency == 0 then
        vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
        vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
        vim.cmd("hi CursorLineNR guibg=NONE ctermbg=NONE")
        vim.cmd("hi StalineFilename guibg=NONE guifg=NONE")
        vim.cmd("hi TodoSignDONE guibg=NONE")
        vim.cmd("hi TodoSignFIX  guibg=NONE")
        vim.cmd("hi TodoSignHACK guibg=NONE")
        vim.cmd("hi TodoSignNOTE guibg=NONE")
        vim.cmd("hi TodoSignPERF guibg=NONE")
        vim.cmd("hi TodoSignTEST guibg=NONE")
        vim.cmd("hi TodoSignTODO guibg=NONE")
        vim.cmd("hi TodoSignWARN guibg=NONE")
        vim.cmd("hi VertSplit guibg=NONE")
        transparency = 1
    else
        vim.cmd("hi Normal guibg=#0f0f0f ctermbg=NONE")
        transparency = 0
    end
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
            "material", "kanagawa"
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

--------------------------- Coding Assistance ---------------------------
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
        M.open_term("clear && so " .. cmd, {direction = 'float'})
    end)
end

-- Cheatsheet
local lang = ""
local file_type = ""
local function cht_on_open(term)
    vim.cmd "stopinsert"
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>",
                                {noremap = true, silent = true})
    vim.api.nvim_buf_set_name(term.bufnr, "cheatsheet-" .. term.bufnr)
    vim.api.nvim_buf_set_option(term.bufnr, "filetype", "cheat")
    vim.api.nvim_buf_set_option(term.bufnr, "syntax", lang)
end

local function cht_on_exit(_) vim.cmd [[normal gg]] end

function M.cht()
    local buf = vim.api.nvim_get_current_buf()
    lang = ""
    file_type = vim.api.nvim_buf_get_option(buf, "filetype")
    vim.ui.input({prompt = "cht.sh input: ", default = file_type .. " "},
                 function(input)
        local cmd = ""
        if input == "" or not input then
            return
        elseif input == "h" then
            cmd = ""
        else
            local search = ""
            local delimiter = " "
            for w in (input .. delimiter):gmatch("(.-)" .. delimiter) do
                if lang == "" then
                    lang = w
                else
                    if search == "" then
                        search = w
                    else
                        search = search .. "+" .. w
                    end
                end
            end
            cmd = lang
            if search ~= "" then cmd = cmd .. "/" .. search end
        end
        cmd = "curl cht.sh/" .. cmd
        M.open_term(cmd, {direction = 'float' ,on_open = cht_on_open, on_exit = cht_on_exit})
    end)
end

-- Interactive CheatSheet
local navi = "navi fn welcome"

local interactive_cheatsheet = Terminal:new{
    cmd = navi,
    dir = "git_dir",
    hidden = true,
    direction = "float",
    float_opts = {border = "double"},
    close_on_exit = true
}

function M.interactive_cheatsheet_toggle() interactive_cheatsheet:toggle() end

-- OpenAI Codex
function M.complete(v)
    v = v or true
    local ft = vim.bo.filetype
    local buf = vim.api.nvim_get_current_buf()

    local api_key = get_api_key()
    if api_key == nil then
      vim.notify "OpenAI API key not found"
      return
    end

    local text = ""
    if v then
      local line1 = vim.api.nvim_buf_get_mark(0, "<")[1]
      local line2 = vim.api.nvim_buf_get_mark(0, ">")[1]
      text = vim.api.nvim_buf_get_lines(buf, line1 - 1, line2, false)
      text = trim(table.concat(text, "\n"))
    else
      text = trim(vim.api.nvim_get_current_line())
    end
    local cs = vim.bo.commentstring
    text = string.format(cs .. "\n%s", ft, text)

    -- vim.notify(text)

    local request = {}
    request["max_tokens"] = MAX_TOKENS
    request["top_p"] = 1
    request["temperature"] = 0
    request["frequency_penalty"] = 0
    request["presence_penalty"] = 0
    request["prompt"] = text
    local body = vim.fn.json_encode(request)

    local completion = ""
    local job = Job:new {
      command = "curl",
      args = {
        OPENAI_URL,
        "-H",
        "Content-Type: application/json",
        "-H",
        string.format("Authorization: Bearer %s", api_key),
        "-d",
        body,
      },
    }
    local is_completed = pcall(job.sync, job, 10000)
    if is_completed then
      local result = job:result()
      local ok, parsed = pcall(vim.json.decode, table.concat(result, ""))
      if not ok then
        vim.notify "Failed to parse OpenAI result"
        return
      end

      if parsed["choices"] ~= nil then
        completion = parsed["choices"][1]["text"]
        local lines = {}
        local delimiter = "\n"

        for match in (completion .. delimiter):gmatch("(.-)" .. delimiter) do
          table.insert(lines, match)
        end
        vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
      end
    end
  end

return M

local JOB = require "plenary.job"
local TERMINAL = require("toggleterm.terminal").Terminal
local API_KEY_FILE = vim.env.HOME .. "/.config/openai-codex/env"
local OPENAI_URL = "https://api.openai.com/v1/engines/davinci-codex/completions" -- {cushman-codex / davinci-codex}
local MAX_TOKENS = 300

local M = {}

-- For creating new Terminal Instance
function M.open_term(cmd, opts)
    opts = opts or {}
    opts.size = opts.size or vim.o.columns * 0.5
    opts.direction = opts.direction or "vertical"
    opts.on_open = opts.on_open or default_on_open
    opts.on_exit = opts.on_exit or nil

    local new_term = TERMINAL:new{
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

-- For StackOverflow Assistance
function M.so_input()
    local buf = vim.api.nvim_get_current_buf()
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
        M.open_term("so " .. cmd, {direction = 'float'})
    end)
end

-- Cheatsheet
local lang = ""
local file_type = ""
local function cht_on_exit(_) vim.cmd [[normal gg]] end
local function cht_on_open(term)
    vim.cmd "stopinsert"
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>",
                                {noremap = true, silent = true})
    vim.api.nvim_buf_set_name(term.bufnr, "cheatsheet-" .. term.bufnr)
    vim.api.nvim_buf_set_option(term.bufnr, "filetype", "cheat")
    vim.api.nvim_buf_set_option(term.bufnr, "syntax", lang)
end

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
        M.open_term(cmd, {
            direction = 'float',
            on_open = cht_on_open,
            on_exit = cht_on_exit
        })
    end)
end

-- Interactive CheatSheet
local navi = "navi fn welcome"
local interactive_cheatsheet = TERMINAL:new{
    cmd = navi,
    dir = "git_dir",
    hidden = true,
    direction = "float",
    float_opts = {border = "double"},
    close_on_exit = true
}
function M.interactive_cheatsheet_toggle() interactive_cheatsheet:toggle() end

-- OpenAI Codex
local function get_api_key()
    local file = io.open(API_KEY_FILE, "rb")
    if not file then return nil end
    local content = file:read "*a"
    content = string.gsub(content, "^%s*(.-)%s*$", "%1") -- strip off any space or newline
    file:close()
    return content
end
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

    local request = {}
    request["max_tokens"] = MAX_TOKENS
    request["top_p"] = 1
    request["temperature"] = 0
    request["frequency_penalty"] = 0
    request["presence_penalty"] = 0
    request["prompt"] = text
    local body = vim.fn.json_encode(request)

    local completion = ""
    local job = JOB:new{
        command = "curl",
        args = {
            OPENAI_URL, "-H", "Content-Type: application/json", "-H",
            string.format("Authorization: Bearer %s", api_key), "-d", body
        }
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

-- Tokei
local project_info = TERMINAL:new{
    cmd = "tokei",
    dir = "git_dir",
    hidden = true,
    direction = "float",
    float_opts = {border = "double"},
    close_on_exit = false
}

function M.project_info_toggle() project_info:toggle() end

-- howdoi
function M.howdoi()
    local buf = vim.api.nvim_get_current_buf()
    file_type = vim.api.nvim_buf_get_option(buf, "filetype")
    vim.ui.input({prompt = "howdoi input: "}, function(input)
        local cmd = ""
        if input == "" or not input then
            return
        elseif input == "h" then
            cmd = "-h"
        else
            cmd = input
        end
        M.open_term("howdoi " .. cmd .. " " .. file_type, {direction = 'float'})
    end)
end

return M
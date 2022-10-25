local cmp_status_ok, User = pcall(require, "core.user")
if not cmp_status_ok then
	return
end

local CMP          = User.completion
local TRANSPARENCY = User.transparency 
local DIAGNOSTIC   = User.diagnostic

local M = {}

-- Toggle Diagnostics
M.toggle_diagnostics = function()
    DIAGNOSTIC = not DIAGNOSTIC
    if DIAGNOSTIC then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end

-- Toggle Completions
M.toggle_cmp = function()
    if CMP ==  1 then
        vim.cmd("lua require('cmp').setup.buffer { enabled = false }")
        CMP = 0
    else
        vim.cmd("lua require('cmp').setup.buffer { enabled = true }")
        CMP = 1
    end
end

-- Toggle Transparency
M.toggle_transparency = function()
    if TRANSPARENCY ==  1 then
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
        TRANSPARENCY = 0
    else
        vim.cmd("hi Normal guibg=#0f0f0f ctermbg=NONE")
        TRANSPARENCY = 1
    end
end

return M
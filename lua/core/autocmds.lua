function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command("augroup " .. group_name)
        vim.api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten({"autocmd", def}), " ")
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command("augroup END")
    end
end

vim.cmd([[command! Realtime set autoread | au CursorHold * checktime | call feedkeys("lh")]])
vim.cmd([[command! CloneBuffer new | 0put =getbufline('#',1,'$')]])
vim.cmd([[command! Mappings drop ~/.config/nvim/lua/core/maps.lua]])
vim.cmd([[command! Scratch new | setlocal bt=nofile bh=wipe nobl noswapfile nu]])
vim.cmd([[command! Blockwise lua require('core.utils').blockwise_clipboard()]])
vim.cmd([[command! ReloadConfig lua require("core.utils").ReloadConfig()]])
vim.cmd([[command! Syntax sync minlines=64]]) -- faster syntax hl
vim.cmd([[command! SaveAsRoot w !doas tee %]])
vim.cmd([[cmap w!! w !doas tee % >/dev/null]]) -- save as root, in my case I use the command 'doas'
vim.cmd([[set iskeyword+=-]])
vim.cmd([[au BufNewFile,BufRead *.ejs set filetype=html]])
vim.cmd([[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]])
vim.cmd([[autocmd CursorMoved * exe exists("HlUnderCursor")?HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""]])
-- vim.api.nvim_create_autocmd({"VimEnter"}, {pattern = "*", command = "Limelight"})
-- vim.cmd([[autocmd InsertEnter * norm zz]]) -- Vertically center document when entering insert mode
-- vim.cmd([[command! Cls lua require("core.utils").preserve('%s/\\s\\+$//ge')]])
-- vim.cmd([[command! Reindent lua require('core.utils').preserve("sil keepj normal! gg=G")]])
-- vim.cmd([[command! BufOnly lua require('core.utils').preserve("silent! %bd|e#|bd#")]])
-- vim.cmd([[autocmd BufEnter *\(.out\|NvimTree*\)\@<! echo expand('%:t')]])
-- vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]])
-- vim.cmd("hi normal guibg=NONE ctermbg=NONE")
-- vim.cmd([[command! -bar -nargs=1 Grep silent grep <q-args> | redraw! | cw]])
-- vim.cmd([[hi ActiveWindow ctermbg=16 | hi InactiveWindow ctermbg=233]])
-- vim.cmd([[set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow]])



vim.api.nvim_create_user_command("DiffOrig",
                                 "vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis",
                                 {force = true})
-- Turn Syntax off for non-code files
vim.api.nvim_create_autocmd("BufEnter", {
    group = syntax_group,
    pattern = "*",
    callback = function()
        if vim.api.nvim_buf_line_count(0) > 10000 then
            vim.cmd [[ syntax off ]]
        end
    end
})

-- vim.api.nvim_create_augroup("highlighturl", { clear = true })
-- cmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
--   desc = "URL Highlighting",
--   group = "highlighturl",
--   pattern = "*",
--   callback = function() astronvim.set_url_match() end,
-- })

-- Highlight on yank
-- local yankGrp = api.nvim_create_augroup("YankHighlight", {clear = true})
-- api.nvim_create_autocmd("TextYankPost", {
--     command = "silent! lua vim.highlight.on_yank()",
--     group = yankGrp
-- })

-- Last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]]
})

-- show cursor line only in active window
-- local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
-- api.nvim_create_autocmd(
--   { "InsertLeave", "WinEnter" },
--   { pattern = "*", command = "set cursorline", group = cursorGrp }
-- )
-- api.nvim_create_autocmd(
--   { "InsertEnter", "WinLeave" },
--   { pattern = "*", command = "set nocursorline", group = cursorGrp }
-- )

local autocmds = {
    reload_vimrc = {
        {"BufWritePre", "$MYVIMRC", "lua require('core.utils').ReloadConfig()"}
    },
    dsa = {
        {
            "BufWritePre", "practice.cpp",
            [[!g++ -std=c++20 % && ./a.out && rm -f a.out]]
        }
    },
    clear_cmdline = {{"CmdlineLeave", "*", "echo ''"}},
    conceal_quotations = {
        {"BufEnter", "*", 'syntax match singlequotes "\'" conceal'},
        {"BufEnter", "*", "syntax match singlequotes '\"' conceal"}
    },
    general_settings = {
        {
            "Filetype", "cheat,copilot.*,qf,help,man,lspinfo,startuptime",
            ":nnoremap <silent> <buffer> q :close<CR>"
        }, {"Filetype", "qf", ":set nobuflisted"}
    },
    autoquickfix = {
        {"QuickFixCmdPost", "[^l]*", "cwindow"},
        {"QuickFixCmdPost", "l*", "lwindow"}
    },
    fix_commentstring = {
        {"Bufenter", "*config,*rc,*conf", "set commentstring=#%s"},
        {"Bufenter", "*config,*conf,sxhkdrc,bspwmrc", "set syntax=config"}
    },
    reload_bindings = {
        {"BufWritePost", "*sxhkdrc", "silent! !pkill -USR1 -x sxhkd"},
        {'BufWritePost', '*bspwmrc', [[silent! !bspc wm -r]]}
    },
    make_scripts_executable = {
        {"BufWritePost", "*.sh,*.py,*.zsh", [[silent !chmod +x %]]}
    },
    live_reload_webDev = {
        {"BufWritePost", "index.html,*.css", [[silent! !~/.scripts/refresh]]}
    },
    custom_updates = {
        {"BufWritePost", "~/.Xresources", "!xrdb -merge ~/.Xresources"},
        {"BufWritePost", "~/.Xdefaults", "!xrdb -merge ~/.Xdefaults"},
        {"BufWritePost", "fonts.conf", "!fc-cache"}
    },
    format_options = { -- :h fo-talbe (for help)
        {
            "BufWinEnter,BufRead,BufNewFile", "*",
            "setlocal formatoptions-=r formatoptions-=o"
        }
    },
    change_header = {
        {"BufWinLeave", "*", "lua require('core.utils').changeheader()"}
    },
    resize_windows_proportionally = {
        {"VimResized", "*", ":wincmd ="}, {"Filetype", "help", ":wincmd ="}
    },
    terminal_job = {
        {"TermOpen", "*", [[tnoremap <buffer> <Esc> <c-\><c-n>]]},
        {"TermOpen", "*", [[tnoremap <buffer> <leader>x <c-\><c-n>:bd!<cr>]]},
        {
            "TermOpen", "*",
            [[tnoremap <expr> <A-r> '<c-\><c-n>"'.nr2char(getchar()).'pi' ]]
        }, {"TermOpen", "*", "startinsert"},
        {"TermOpen", "*", [[nnoremap <buffer> <C-c> i<C-c>]]},
        {"TermOpen", "*", "setlocal listchars= nonumber norelativenumber"},
        {"TermOpen", "*", [[lua vim.opt_local.buflisted = false]]}
    },
    restore_cursor = {{"BufRead", "*", [[call setpos(".", getpos("'\""))]]}},
    save_shada = {
        {"VimLeave", "*", "wshada!"}, {"CursorHold", "*", [[rshada|wshada]]}
    },
    wins = {
        -- { "VimResized", "*", ":wincmd =" },
        -- { "WinEnter", "*", "wincmd =" },
        {"BufEnter", "NvimTree", [[setlocal cursorline]]}
    },
    toggle_search_highlighting = {
        {"InsertEnter  , InsertLeave", "*", [[set cul!]]},
        {"InsertEnter", "*", "setlocal nohlsearch"},
        {"InsertEnter", "*", [[call clearmatches()]]},
        {
            "InsertLeave", "*",
            [[highlight RedundantSpaces ctermbg=red guibg=red]]
        }, {"InsertLeave", "*", [[match RedundantSpaces /\s\+$/]]}
    },
    lua_highlight = {
        {
            "TextYankPost", "*",
            [[silent! lua vim.highlight.on_yank() {higroup="IncSearch", timeout=600}]]
        }
    },
    clean_trailing_spaces = {
        {
            "BufWritePre", "*",
            [[lua require("core.utils").preserve('%s/\\s\\+$//ge')]]
        }
    }
    -- autoskel = {
    -- {"BufNewFile", "*.lua,*.sh", 'lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i_skel<CR>",true,false,true),"m",true)' },
    -- },
    -- wrap_spell = {
    --     { "FileType", "markdown", ":setlocal wrap" },
    --     { "FileType", "markdown", ":setlocal spell" },
    -- },
    -- hicurrent_word = {
    --     { "CursorHold", "*", [[:exec 'match Search /\V\<' . expand('<cword>') . '\>/']] },
    -- },
    -- auto_exit_insertmode = {
    --     { "CursorHoldI", "*", "stopinsert" },
    -- },
    -- auto_working_directory = {
    --     { "BufEnter", "*", "silent! lcd %:p:h" },
    -- },
    -- ansi_esc_log = {
    --     { "BufEnter", "*.log", ":AnsiEsc" };
    -- };
    -- AutoRecoverSwapFile = {
    --     { "SwapExists", "*", [[let v:swapchoice = 'r' | let b:swapname = v:swapname]] },
    --     { "BufWinEnter", "*", [[if exists("b:swapname") | call delete(b:swapname) | endif]] },
    -- },
    -- flash_cursor_line = {
    --     { "WinEnter", "*", "lua require('core.utils').flash_cursorline()" },
    --     -- { "WinEnter", "*", "Beacon" },
    --     -- https://stackoverflow.com/a/42118416/2571881  - https://st.suckless.org/patches/blinking_cursor/
    --     { "VimLeave", "*", "lua vim.opt.guicursor='a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,n-v:hor20'"},
    -- },
    -- attatch_colorizer = {
    -- 	-- {BufReadPost *.conf setl ft=conf};
    -- 	{"BufReadPost", "config", "setl ft=conf"};
    -- 	{"FileType", "conf", "ColorizerAttachToBuffer<CR>"};
    -- };
}
nvim_create_augroups(autocmds)
-- autocommands END

local augroups = {}
augroups.buf_write_pre = {
    mkdir_before_saving = {
        event = {"BufWritePre", "FileWritePre"},
        pattern = "*",
        -- TODO: Replace vimscript function
        command = [[ silent! call mkdir(expand("<afile>:p:h"), "p") ]]
    },
    trim_extra_spaces_and_newlines = {
        event = "BufWritePre",
        pattern = "*",
        -- TODO: Replace vimscript function
        command = require("core.utils").preserve("%s/\\s\\+$//ge")
    }
}

augroups.misc = {
    highlight_yank = {
        event = "TextYankPost",
        pattern = "*",
        callback = function()
            vim.highlight.on_yank({
                higroup = "IncSearch",
                timeout = 400,
                on_visual = true
            })
        end
    },
    -- trigger_nvim_lint = {
    -- 	event = {"BufEnter", "BufNew", "InsertLeave", "TextChanged"},
    -- 	pattern = "<buffer>",
    -- 	callback = function ()
    -- 		require("lint").try_lint()
    -- 	end,
    -- },
    unlist_terminal = {
        event = "TermOpen",
        pattern = "*",
        callback = function()
            vim.opt_local.buflisted = false
            vim.opt.listchars = ""
            vim.cmd("startinsert")
        end
    }
}
local status_ok, wk = pcall(require, "which-key")
if not status_ok then
    return
end

wk.setup({})

local mappings = {
    q = {
        name = "File Options",
        q    = { "<cmd>q!<cr>"       , "Quit"                } ,
        Q    = { "<cmd>q<cr>"        , "Quit Without Saving" } ,
        w    = { "<cmd>wq<cr>"       , "Save & Quit"         } ,
        s    = { "<cmd>w<cr>"        , "Save"                } ,
        S    = { "<cmd>wa<cr>"       , "Save All Opened"     } ,
        x    = { "<cmd>bdelete<cr>"  , "Close"               } ,
    },
    a = {
        name = "Coding Assistance",
        c    = { "<cmd>Cheat<CR>"                                , "Cheat.sh"      } ,
        s    = { "<cmd>lua require('core.utils').so_input()<CR>" , "StackOverflow" } ,
    },
    f = {
        name = "Telescope",
        b    = { '<cmd>lua require("core.file").buffers()<cr>'    , "Buffers"         } ,
        d    = { '<cmd>lua require("core.file").xdg_config()<cr>' , "Dotfiles"        } ,
        n    = { '<cmd>lua require("core.file").nvim_files()<cr>' , "Nvim Files"      } ,
        e    = { "<cmd>Telescope emoji<cr>"                       , "Emoji Picker"    } ,
        f    = { "<cmd>Telescope find_files<cr>"                  , "Find Files"      } ,
        g    = { "<cmd>Telescope oldfiles<cr>"                    , "Recently Opened" } ,
        m    = { "<cmd>Telescope media_files<cr>"                 , "Find Media"      } ,
        r    = { "<cmd>Telescope live_grep<cr>"                   , "Find String"     } ,
    },
    t = {
        name = "Terminal",
        t    = { "<cmd>ToggleTerm<cr>"                                   , "Split Below"       } ,
        f    = { '<cmd>TermExec size=30 direction=float cmd="clear"<CR>' , "Floating Terminal" } ,
        l    = { "<cmd>LazyGit<CR>"                                      , "LazyGit"           } ,
    },
    p = {
        name = "Packer",
        r    = { "<cmd>PackerClean<cr>"                , "Remove Unused Plugins" } ,
        c    = { "<cmd>PackerCompile profile=true<cr>" , "Recompile Plugins"     } ,
        i    = { "<cmd>PackerInstall<cr>"              , "Install Plugins"       } ,
        p    = { "<cmd>PackerProfile<cr>"              , "Packer Profile"        } ,
        s    = { "<cmd>PackerSync<cr>"                 , "Sync Plugins"          } ,
        S    = { "<cmd>PackerStatus<cr>"               , "Packer Status"         } ,
        u    = { "<cmd>PackerUpdate<cr>"               , "Update Plugins"        } ,
    },
    s = {
        name = "Something Else",
        a    = { "<cmd>SimpleAlign "                                        , "Align Text"          } ,
        h    = { "<cmd>!chmod +x % && source %<CR>"                         , "Run Shell Script"    } ,
        o    = { "<cmd>so %<CR>"                                            , "Source Current File" } ,
        r    = { "<cmd>%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>" , "Replace Instances"   } ,
    },
}

local opts = { prefix = "<leader>", mode = "n" }
wk.register(mappings, opts)
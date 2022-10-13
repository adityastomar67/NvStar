local status_ok, Hydra = pcall(require, "hydra")
if not status_ok then return end

-- local function cmd(command)
-- 	return table.concat({ "<Cmd>", command, "<CR>" })
-- end

local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd

local hint = [[

        	      (``',
        	     / `''/
            o\/    /
            \,    /          _
            (    /         ,',`,
          /x`''7/_________r_ ,=,
         (x   //---, (------',=,
        / `''7'     \ \   ' ,=,
       /    /        \ \   '-'
      (    /          ) \
      `'''           /(o)\
              	    `|~~~|`
              	     |   |
              	    /     \
            ,-----'`       `'-----,
           `~~~~~~~~~~~~~~~~~~~~~~~`

]]

Hydra({
   name = 'Telescope',
   hint = hint,
   config = {
      color = 'teal',
      invoke_on_body = true,
      hint = {
         position = 'middle',
         border = 'none',
      },
   },
   mode = 'n',
   body = '<Leader>f',
   heads = {
		{ "b", cmd 'lua require("plug.telescope").buffers()' , { desc = "Buffers" } },
		{ "n", cmd 'lua require("plug.telescope").nvim_files()' , { desc = "Nvim Files" } },
		{ "d", cmd 'lua require("plug.telescope").xdg_config()' , { desc = "DotFiles" } },
		{ "e", cmd "Telescope emoji" , { desc = "Emoji Picker" } },
		{ "c", cmd "Telescope commands" , { desc = "execute command" } },
		{ "f", cmd "Telescope find_files <cr>"  },
		{ "t", cmd "Telescope file_browser"  },
		{ "m", cmd "Telescope media_files"  },
		{ "g", cmd "Telescope live_grep" , { desc = "Find with Word" } },
		{ "h", cmd "Telescope help_tags" , { desc = "vim help" } },
		{ "k", cmd "Telescope keymaps"  },
		{ "O", cmd "Telescope vim_options"  },
		{ "p", cmd "Telescope projects" , { desc = "projects" } },
		{ "r", cmd "Telescope oldfiles" , { desc = "recently opened files" } },
		{ "R", cmd "Telescope registers"  },
		{ "s", cmd "Telescope grep_string" , { desc = "Text under cursor" } },
		{ "S", cmd "Telescope symbols"  },
		{ "/", cmd "Telescope current_buffer_fuzzy_find" , { desc = "search in file" } },
		{ "?", cmd "Telescope search_history" , { desc = "search history" } },
		{ ";", cmd "Telescope command_history" , { desc = "command-line history" } },
		{ "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
		{ "q", nil, { exit = true, nowait = true }	},
   }
})

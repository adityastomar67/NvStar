--    +-------------------------------------------------------------------------------------------------+
--    | Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator | Terminal | Lang-Arg |
--    ---------------------------------------------------------------------------------------------------
--    | map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |    -     |    -     |
--    | nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |    -     |    -     |
--    | map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    -     |
--    | imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |    -     |    -     |
--    | cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |    -     |    -     |
--    | vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |    -     |    -     |
--    | xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |    -     |    -     |
--    | smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |    -     |    -     |
--    | omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |    -     |    -     |
--    | tmap / tnoremap  |    -   |   -    |    -    |   -    |   -    |    -     |    @     |    -     |
--    | lmap / lnoremap  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    @     |
--    +-------------------------------------------------------------------------------------------------+
-- Modes
	--   normal_mode       = "n"
	--   insert_mode       = "i"
	--   visual_mode       = "v"
	--   visual_block_mode = "x"
	--   term_mode         = "t"
	--   command_mode      = "c"

local opts      = {noremap = true, silent = true}
local term_opts = {silent = true}
local keymap    = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Reselect the previous visual block
keymap("n", "gV", "`[v`]", opts )

keymap("i", "<C-r>", "<ESC><cmd>TermExec cmd=\"clear && prog %\"<CR>", opts)

-- File creation date
keymap("n", "<F1>", 'oThis file was created on <C-R>=strftime("%b %d %Y %H:%M")<CR><ESC>', opts)
keymap("i", "<F1>", 'oThis file was created on <C-R>=strftime("%b %d %Y %H:%M")<CR>'     , opts)

-- Increment/decrement
keymap('n', '+', '<C-a>', opts)
keymap('n', '-', '<C-x>', opts)

-- Delete a word backwards
keymap('n', 'db', 'vb"_d', opts)

-- Remove the Highlighting from the search
keymap("n", "<CR>", ":noh<CR><CR>", opts)

-- Better Redo Option
keymap("n", "U", "<C-r>", opts)

-- Better Hoping then numerous keystrokes
-- keymap("n" , "fw"     , ":HopWord<CR>"      , opts)
-- keymap("n" , "fl"     , ":HopLine<CR>"      , opts)
-- keymap("i" , "<C-F>"  , "<ESC>:HopLine<CR>" , opts)

-- For not yanking when deleting chars
keymap('n', 'x', '"_x', opts)

-- Yank all content
keymap("n" , "Y" , "y$"    , opts)

-- Writing & exiting
keymap("n" , "Q"     , ":q!<CR>"     , opts)
keymap("n" , "<C-c>" , ":bw<CR>"     , opts)
keymap("n" , "<C-s>" , ":w<CR>"      , opts)
keymap("n" , "qo"    , ":on<CR>"     , opts)
keymap("i" , "<C-s>" , "<ESC>:w<CR>" , opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n" , "<C-Up>"    , ":resize +2<CR>"          , opts)
keymap("n" , "<C-Down>"  , ":resize -2<CR>"          , opts)
keymap("n" , "<C-Left>"  , ":vertical resize -2<CR>" , opts)
keymap("n" , "<C-Right>" , ":vertical resize +2<CR>" , opts)

-- Navigate buffers
keymap("n" , "<S-l>" , ":bnext<CR>"     , opts)
keymap("n" , "<S-h>" , ":bprevious<CR>" , opts)

-- Press qq/q fast to enter Normal Mode
keymap("i", "qq", "<ESC>", opts)
keymap("v", "q" , "<ESC>", opts)
keymap("x", "q" , "<ESC>", opts)

-- Getting Rid Of Bad Habbits
keymap("n" , "<Up>"    , "<Nop>" , opts)
keymap("i" , "<Up>"    , "<Nop>" , opts)
keymap("x" , "<Up>"    , "<Nop>" , opts)
keymap("v" , "<Up>"    , "<Nop>" , opts)
keymap("n" , "<Down>"  , "<Nop>" , opts)
keymap("i" , "<Down>"  , "<Nop>" , opts)
keymap("x" , "<Down>"  , "<Nop>" , opts)
keymap("v" , "<Down>"  , "<Nop>" , opts)
keymap("n" , "<Left>"  , "<Nop>" , opts)
keymap("i" , "<Left>"  , "<Nop>" , opts)
keymap("x" , "<Left>"  , "<Nop>" , opts)
keymap("v" , "<Left>"  , "<Nop>" , opts)
keymap("n" , "<Right>" , "<Nop>" , opts)
keymap("i" , "<Right>" , "<Nop>" , opts)
keymap("x" , "<Right>" , "<Nop>" , opts)
keymap("v" , "<Right>" , "<Nop>" , opts)

-- Better Navigation in insert mode
keymap("i" , "<C-h>" , "<Left>"  , opts)
keymap("i" , "<C-l>" , "<Right>" , opts)
keymap("i" , "<C-j>" , "<Down>"  , opts)
keymap("i" , "<C-k>" , "<Up>"    , opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v" , "<A-j>" , ":m .+1<CR>==" , opts)
keymap("v" , "<A-k>" , ":m .-2<CR>=="  , opts)
keymap("v" , "p"     , '"_dP'        , opts)

-- Move text up and down
keymap("x" , "J"     , ":move '>+1<CR>gv-gv" , opts)
keymap("x" , "K"     , ":move '<-2<CR>gv-gv"  , opts)
keymap("x" , "<A-k>" , ":move '<-2<CR>gv-gv"  , opts)
keymap("x" , "<A-j>" , ":move '>+1<CR>gv-gv" , opts)

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- File Tree Pawn
keymap('n', '<C-b>', ':NvimTreeToggle<CR>', opts) -- This works completely fine

-- For Conceal enable/disable
vim.keymap.set("n",  "<F10>" , function()
	if vim.o.conceallevel > 0 then
		vim.o.conceallevel = 0
	else
		vim.o.conceallevel = 2
	end
end, opts)

vim.keymap.set("n",  "<F11>" , function()
	if vim.o.concealcursor == "n" then
		vim.o.concealcursor = ""
	else
		vim.o.concealcursor = "n"
	end
end, opts)

-- TESTING
keymap("n","n", "nzzzv",opts)
keymap("n","N", "Nzzzv",opts)
keymap("n","G", "Gzz"  ,opts)


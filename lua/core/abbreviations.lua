vim.cmd([[cnoreab cls Cls]])
vim.cmd([[cnoreab Bo BufOnly]])
vim.cmd([[cnoreab W w]])
vim.cmd([[cnoreab W! w!]])
vim.cmd([[cnoreab Bw Blockwise]])
vim.cmd([[inoreab Fname <c-r>=expand("%:p")<cr>]])
vim.cmd([[inoreab Iname <c-r>=expand("%:p")<cr>]])
vim.cmd([[inoreab fname <c-r>=expand("%:t")<cr>]])
vim.cmd([[inoreab iname <c-r>=expand("%:t")<cr>]])
vim.cmd([[inoreabbrev idate <C-R>=strftime("%b %d %Y %H:%M")<CR>]])

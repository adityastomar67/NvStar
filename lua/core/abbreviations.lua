local cmd = vim.cmd

cmd([[cnoreab cls Cls]])
cmd([[cnoreab Bo BufOnly]])
cmd([[cnoreab W w]])
cmd([[cnoreab W! w!]])
cmd([[cnoreab Bw Blockwise]])
cmd([[inoreab Fname <c-r>=expand("%:p")<cr>]])
cmd([[inoreab Iname <c-r>=expand("%:p")<cr>]])
cmd([[inoreab fname <c-r>=expand("%:t")<cr>]])
cmd([[inoreab iname <c-r>=expand("%:t")<cr>]])
cmd([[inoreabbrev idate <C-R>=strftime("%b %d %Y %H:%M")<CR>]])
local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then return end

local SETTINGS = {
    options = {
        buffer_close_icon = '',
        modified_icon = '',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        separator_style = "thick",
        color_icons = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = false
            }
        }
    }
}

bufferline.setup(SETTINGS)

vim.cmd [[
  nnoremap <silent><TAB> :BufferLineCycleNext<CR>
  nnoremap <silent><S-TAB> :BufferLineCyclePrev<CR>
  ]]

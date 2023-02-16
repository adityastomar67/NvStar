-- {
--     "echasnovski/mini.indentscope",
--     version = false, -- wait till new 0.7.0 release to put it back on semver
--     event = { "BufReadPre", "BufNewFile" },
--     opts = {
--       -- symbol = "▏",
--       symbol = "│",
--       options = { try_as_border = true },
--     },
--     config = function(_, opts)
--       vim.api.nvim_create_autocmd("FileType", {
--         pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
--         callback = function()
--           vim.b.miniindentscope_disable = true
--         end,
--       })
--       require("mini.indentscope").setup(opts)
--     end,
--   },
local status_ok, indent = pcall(require, "mini.indentscope")
if not status_ok then return end

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason"
    },
    callback = function() vim.b.miniindentscope_disable = true end
})

local SETTINGS = {
    -- symbol = "▏",
    symbol = "│",
    options = {try_as_border = true}
}

indent.setup(SETTINGS)

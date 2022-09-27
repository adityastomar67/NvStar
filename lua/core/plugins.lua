local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({border = "rounded"})
        end
    }
})

-- Install your plugins here
return packer.startup(function(use)
    use("wbthomason/packer.nvim") -- Have packer manage itself
    use("folke/which-key.nvim")

    use({"akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons"})
    use({"lewis6991/impatient.nvim", config = "require('impatient')"})
    use("nvim-treesitter/nvim-treesitter")
    use("tamton-aquib/staline.nvim")
    use("kyazdani42/nvim-tree.lua")
    use({
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup({}) end,
        after = "nvim-cmp"
    })
    use("norcalli/nvim-colorizer.lua")
    use("xiyaowong/telescope-emoji.nvim")
    use("nvim-telescope/telescope-media-files.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")
    use("goolord/alpha-nvim")
    use("neovim/nvim-lspconfig")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/vim-vsnip")
    use("onsails/lspkind-nvim")
    use("elkowar/yuck.vim")
    use("dstein64/vim-startuptime")
    use("nathom/filetype.nvim")
    use("kyazdani42/nvim-web-devicons")
    use("williamboman/nvim-lsp-installer")
    use("akinsho/toggleterm.nvim")
    use("rcarriga/nvim-notify")
    use("kg8m/vim-simple-align")
    use("RishabhRD/nvim-cheat.sh")

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then require("packer").sync() end -- Put this at the end after all plugins
end)

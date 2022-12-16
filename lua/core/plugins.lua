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
            return require("packer.util").float({border = "none"})
        end
    }
})

-- Install your plugins here
return packer.startup(function(use)

    -- Core
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")
    use("lewis6991/impatient.nvim")
    use("folke/which-key.nvim")
    use("akinsho/toggleterm.nvim")
    use("kdheepak/lazygit.nvim")
    use("kyazdani42/nvim-tree.lua")
    use("anuvyklack/hydra.nvim")
    use("sindrets/winshift.nvim")

    -- Treesitter
    use("nvim-treesitter/nvim-treesitter")
    use("nvim-treesitter/nvim-treesitter-context")

    -- Telescope
    use("nvim-telescope/telescope.nvim")
    use("xiyaowong/telescope-emoji.nvim")
    use("nvim-telescope/telescope-media-files.nvim")
    use("nvim-telescope/telescope-ui-select.nvim")
    use("nvim-telescope/telescope-file-browser.nvim")
    use("nvim-telescope/telescope-project.nvim")
    use("nvim-telescope/telescope-frecency.nvim")

    -- More Navigation
    use("ibhagwan/fzf-lua")
    use("ThePrimeagen/harpoon")

    -- UI Elements
    use("junegunn/limelight.vim")
    use("kyazdani42/nvim-web-devicons")
    use("psliwka/vim-smoothie")
    use("akinsho/bufferline.nvim")
    use("tamton-aquib/staline.nvim")
    use("goolord/alpha-nvim")
    use("rcarriga/nvim-notify")
    use("lewis6991/gitsigns.nvim")
    use("folke/todo-comments.nvim")
    use("s1n7ax/nvim-window-picker")
    use("nvim-lua/popup.nvim")
    use("gorbit99/codewindow.nvim")
    use("folke/noice.nvim")
    use("MunifTanjim/nui.nvim")
    use("m-demare/hlargs.nvim")

    -- Colorscheme
    use("rebelot/kanagawa.nvim")
    use("navarasu/onedark.nvim")
    use("folke/tokyonight.nvim")
    use("shaunsingh/nord.nvim")
    use("marko-cerovac/material.nvim")
    use("sainnhe/sonokai")
    use("sainnhe/edge")
    use("projekt0n/github-nvim-theme")

    -- Coding Assistance
    use("RishabhRD/nvim-cheat.sh")
    use("RishabhRD/popfix")
    use("github/copilot.vim")
    use("sudormrfbin/cheatsheet.nvim")
    use("jackMort/ChatGPT.nvim")
    use({"tzachar/cmp-tabnine", run='./install.sh'})

    -- LSP, Linters, Formatters
    use("neovim/nvim-lspconfig")
    use("onsails/lspkind-nvim")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("mfussenegger/nvim-dap")
    use("jose-elias-alvarez/null-ls.nvim")
    use("williamboman/nvim-lsp-installer")
    use("folke/trouble.nvim")
    use("folke/lsp-trouble.nvim")
    use("glepnir/lspsaga.nvim")

    -- Snippets
    use("L3MON4D3/LuaSnip")
    use("rafamadriz/friendly-snippets")
    use("notomo/cmp-neosnippet")

    -- CMP
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-copilot")
    use("uga-rosa/cmp-dynamic")
    use("saadparwaiz1/cmp_luasnip")
    use("alpha2phi/cmp-openai-codex")
    use("kristijanhusak/vim-dadbod-completion")

    -- Docker
    use("vim-denops/denops.vim")
    use("skanehira/denops-docker.vim")
    use("jamestthompson3/nvim-remote-containers")
    use("kkvh/vim-docker-tools")

    -- Others
    use("kg8m/vim-simple-align")
    use("norcalli/nvim-colorizer.lua")
    use("terrortylor/nvim-comment")
    use("phaazon/hop.nvim")
    use("windwp/nvim-autopairs")
    use("antoinemadec/FixCursorHold.nvim")
    use("kosayoda/nvim-lightbulb")
    use("bennypowers/nvim-regexplainer")

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then require("packer").sync() end -- Put this at the end after all plugins
end)

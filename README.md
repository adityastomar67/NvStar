<div align = "center">

  <h1><a href="https://github.com/adityastomar67/nvstar">NvSTAR</a></h1>

  <a href="https://github.com/adityastomar67/nvstar/blob/main/LICENSE.md">
  <img alt="License" src="https://img.shields.io/github/license/adityastomar67/nvstar?style=flat&color=eee&label="> </a>

  <a href="https://github.com/adityastomar67/nvstar/graphs/contributors">
  <img alt="People" src="https://img.shields.io/github/contributors/adityastomar67/nvstar?style=flat&color=ffaaf2&label=People"> </a>

  <a href="https://github.com/adityastomar67/nvstar/stargazers">
  <img alt="Stars" src="https://img.shields.io/github/stars/adityastomar67/nvstar?style=flat&color=98c379&label=Stars"></a>

  <a href="https://github.com/adityastomar67/nvstar/network/members">
  <img alt="Forks" src="https://img.shields.io/github/forks/adityastomar67/nvstar?style=flat&color=66a8e0&label=Forks"> </a>

  <a href="https://github.com/adityastomar67/nvstar/watchers">
  <img alt="Watches" src="https://img.shields.io/github/watchers/adityastomar67/nvstar?style=flat&color=f5d08b&label=Watches"> </a>

  <a href="https://github.com/adityastomar67/nvstar/pulse">
  <img alt="Last Updated" src="https://img.shields.io/github/last-commit/adityastomar67/nvstar?style=flat&color=e06c75&label="> </a>

  [![](https://img.shields.io/badge/Neovim-0.8+-blueviolet.svg?style=for-the-badge&logo=Neovim&color=302D41&logoColor=green)](https://github.com/neovim/neovim)

  <h3>Personalized Development Environment ❤️👨‍💻</h3>
  Brief description of how this configuration actually works. Hit the ⭐ button if you found this useful.

</div>

## ❔ What is this
This is a v2 of my previous Neovim config - [Nvdots](https://github.com/adityastomar67/nvdots)

![Screenshot_Dashboard](https://user-images.githubusercontent.com/33474611/200270455-d1fc848e-3109-49f1-902a-a7909fb00661.png)
> For **Wallpaper**, Go to _[this](https://github.com/adityastomar67/Wallpapers)_ <br>Terminal is **ST**, for config go _[here](https://github.com/adityastomar67/.dotfiles/tree/master/.config/st)_ <br> For other stuff checkout my [Profile](https://github.com/adityastomar67)


#### Before we proceed, File Structure is like

If the reader is well versed or, has a general experience with shell scripting, Lua language or, know what they are doing then they may skip this section. But it advised to take a good understanding of the file structure before making any changes.

```
nvim
├── after
│   ├── queries
│   └── syntax
├── bin
├── colors
├── init.lua
├── lua
│   ├── core
│   │   ├── abbreviations.lua
│   │   ├── autocmds.lua
│   │   ├── colorscheme.lua
│   │   ├── colors.lua
│   │   ├── constants.lua
│   │   ├── maps.lua
│   │   ├── options.lua
│   │   ├── plugins.lua
│   │   ├── user.lua
│   │   └── utils
│   └── plug
│       ├── cheatsheet.lua
│       ├── cmp
│       ├── colorizer.lua
│       ├── fzf.lua
│       ├── hydra
│       ├── init.lua
│       ├── lsp
│       │   └── servers
│       ├── lspkind.lua
│       ├── mason.lua
│       ├── nvim-tree.lua
│       ├── other.lua
│       ├── telescope
│       ├── terminal.lua
│       ├── todo-comments.lua
│       ├── toggle.lua
│       ├── trouble.lua
│       ├── ts-context.lua
│       ├── ui
│       │   ├── bufferline.lua
│       │   ├── dashboard.lua
│       │   ├── git-sign.lua
│       │   ├── init.lua
│       │   ├── minimap.lua
│       │   ├── noice.lua
│       │   ├── notify.lua
│       │   └── statusline.lua
│       └── whichkey.lua
└── plugin
```

## 🚀 Install language servers

### Mostly available via npm
```bash
npm install -g typescript typescript-language-server vscode-langservers-extracted vls @tailwindcss/language-server yaml-language-server @prisma/language-server emmet-ls neovim graphql-language-service-cli graphql-language-service-server @astrojs/language-server bash-language-server
```

> TIP: [No sudo on global npm install](https://github.com/sindresorhus/guides/blob/main/npm-global-without-sudo.md)

### Lua, Pyright, Deno, Gopls and rust-analyzer available in Arch/Manjaro repos
```bash
sudo pacman -S lua-language-server pyright deno rust-analyzer gopls shellcheck
```

> Check your package manager for availability if not on an Arch based distro -
_brew, apt_ etc.

## 👌 Install formatters

[ prettier ](https://prettier.io/) with npm

```bash
npm i -g prettier
```

[ shfmt ](https://github.com/mvdan/sh) is in the AUR

```bash
sudo pacman -S shfmt                        # From the AUR
go install mvdan.cc/sh/v3/cmd/shfmt@latest  # With the help of GO
```

[ stylua ](https://github.com/JohnnyMorganz/StyLua) is in the AUR

```bash
sudo pacman -S stylua
```

> Check your package manager for availability if not on an Arch based distro -
_brew, apt_ etc.

[autopep8](https://pypi.org/project/autopep8/) for python is in Manjaro/Arch
repos

```bash
sudo pacman -S autopep8
```

> Check your package manager for availability if not on an Arch based distro -
_brew, apt_ etc.

[yamlfmt](https://pypi.org/project/yamlfmt/) for yaml available with pip

```bash
sudo pip install yamlfmt
```

# 🧨 Installation

```bash
  # move to home dir
  cd ~
  # back up current config
  cp -r ~/.config/nvim ~/.config/nvim.backup
  # clone repository
  git clone https://github.com/adityastomar67/nvstar.git ~/.config
  # Launch nvim for the first time with this command to install plugins
  nvim +PackerInstall
  # exit nvim and Then compile the loader file
  nvim +PackerCompile
```

## Additionals
### ⭐ Coding Assistance
#### [Github Copilot](https://github.com/features/copilot)
#### [OpenAI Codex](https://openai.com/blog/openai-codex/)
#### [StackOverflow](https://github.com/samtay/so)
#### [Cht.sh](https://cht.sh/)
#### [Navi](https://github.com/denisidoro/navi)
#### [Tokei](https://github.com/XAMPPRocky/tokei)
#### [howdoi](https://github.com/gleitz/howdoi)
#### [howto]()

### ⭐ Adding custom Snippets

The conifg uses [ luasnip ](https://github.com/saadparwaiz1/cmp_luasnip) paired
with [friendly-snippets](https://github.com/adityastomar67/friendly-snippets), my own fork for VS Code style snippets.
You can add your own snippets to the config [ snippets directory ](./snippets).
You'll also need to edit the [snippets/package.json](./snippets/package.json) to
be able to load your snippets in the correct filetype.
One test snippet is included as an example.

## Plugins

For a list of plugins, see the [plugins file](./lua/core/plugins.lua).

## More Info

Looking for my `zsh` and other `cli` configs? See [Dotfiles](https://github.com/adityastomar67/.dotfiles)

## Resources and inspiration

[Nvim Lua guide](https://github.com/nanotee/nvim-lua-guide)

[Ben Frain has a nice setup](https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f)

[Lunar Vim for inspiration](https://github.com/ChristianChiarulli/LunarVim)

[Ui Customization docs](https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter)

[Lua for Programmers](https://ebens.me/post/lua-for-programmers-part-1/)

[LSP config](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

[Awesome list of plugins](https://github.com/rockerBOO/awesome-neovim)

[Plugin Finder](https://neovimcraft.com/)
Noting really, if you have (Neo)vim installed then you can just backup your previous config if any, then just clone this repo and create a symlink of this configuration to your ~/.config/nvim

**SUGGESTION**

* Font: Cascursive - Courtesy of [@sainnhe](https://github.com/sainnhe/icursive-nerd-font) **(You can find fonts inside my dotfiles repo)**
* [dot_files](https://github.com/adityastomar67/.dotfiles/)
* [Wallpaper](https://github.com/adityastomar67/Wallpapers)

## For Complete Automated install
Run this code snippet in your terminal **(Coming soon...)**
```bash
curl -sL https://bit.ly/Fresh-Install | sh -s -- --vim

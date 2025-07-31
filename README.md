[![pipeline status](https://gitlab.com/TimenZan/dotfiles/badges/master/pipeline.svg)](https://gitlab.com/TimenZan/dotfiles/-/commits/master)

# dotfiles

Timen Zandbergen's dotfiles

## Usage
Pull the repository into your home folder and then create the symbolic links
with [GNU Stow](https://www.gnu.org/software/stow/).

```sh
cd ~/dotfiles
stow neovim starship # and any other programs
```

Make sure to install all the needed external programs for neovim.
```bash
# programs
paru -Syu neovim-git fzf ripgrep bat fd glow
# language servers
paru -Syu bash-language-server clang lua-language-server texlab yaml-language-server shellcheck pyright ltex-ls-plus-bin proselint lemminx typos-lsp
pip install --user --upgrade pynvim
```

# Other settings,

For sharper font rendering, add the following line to `/etc/environment`:
```
FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"
```

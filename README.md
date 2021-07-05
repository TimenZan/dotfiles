[![pipeline status](https://gitlab.com/TimenZan/dotfiles/badges/master/pipeline.svg)](https://gitlab.com/TimenZan/dotfiles/-/commits/master)

# dotfiles

Timen Zandbergen's dotfiles

## Usage
Pull the repository into your home folder and then create the symbolic links
with [GNU Stow](https://www.gnu.org/software/stow/)

```sh
git clone git@gitlab.com:TimenZan/dotfiles.git ~/.dotfiles
./install.sh
```
Or you can only use the configs that you want to use
```sh
cd ~/.dotfiles
stow neovim starship # and any other programs
```

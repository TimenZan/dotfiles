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
yay -Syu neovim-git fzf ripgrep bat fd glow
# language servers
yay -Syu bash-language-server clang rust-analyzer lua-language-server texlab vim-language-server yaml-language-server shellcheck pyright jedi-language-server efm-langserver haskell-language-server-static ltex-ls-bin proselint vint
pip install --user --upgrade pynvim
```


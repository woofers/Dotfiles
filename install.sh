#!/bin/bash

# Setup Repos
sudo apt-get install software-properties-common
sudo apt-get install python-dev python-pip python3-dev python3-pip
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update

# Install Core Components
sudo apt-get install neovim
sudo apt-get install python-pip
sudo pip install powerline-shell
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo apt-get install exuberant-ctags

# Install TMUX
sudo apt-get install libevent-dev
sudo apt-get install libncurses5-dev libncursesw5-dev
cd $HOME
wget https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz
tar -zxvf tmux-2.6.tar.gz
cd tmux-2.6
./configure && make
sudo make install
cd ..
rm -rf tmux-2.6
rm tmux-2.6.tar.gz

# Install Powerline Fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Generate TMUX Config
tmux
tmux show -g | cat > ~/.tmux.conf
exit

# Export DEV Path
export DEV="/mnt/d/Documents/Development"

# VIM Copy to Windows Copy Buffer
sudo ln -s "$DEV/src/Dotfiles/vim/bin/win32yank.exe" "/usr/bin/win32yank"

# Setup BASH Config
rm "$HOME/.bashrc"
ln -s "$DEV/src/Dotfiles/shell/.bashrc" "$HOME/.bashrc"
rm -rf "$HOME/.bash"
ln -s "$DEV/src/Dotfiles/shell/.bash" "$HOME"

# Setup ZSH Config
rm "$HOME/.zshrc"
ln -s "$DEV/src/Dotfiles/shell/.zshrc" "$HOME/.zshrc"
rm -rf "$HOME/.oh-my-zsh/themes"
ln -s "$DEV/src/Dotfiles/shell/.oh-my-zsh/themes" "$HOME/.oh-my-zsh/"

# Setup Git Config
rm "$HOME/.gitconifg"
ln -s "$DEV/src/Dotfiles/git/.gitconifg" "$HOME/.gitconfig"

# Setup TMUX Config
rm "$HOME/.tmux.conf"
ln -s "$DEV/src/Dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
rm -rf "$HOME/.tmux"
ln -s "$DEV/src/Dotfiles/tmux/.tmux" "$HOME"

# Setup Directory Colors
rm "$HOME/dircolors.ansi-darkorange"
ln -s "$DEV/src/Dotfiles/shell/dircolors.ansi-darkorange" "$HOME"

# Setup VIM config
rm -rf "$HOME/.config/nvim"
ln -s "$DEV/src/Dotfiles/vim/nvim" "$HOME/.config/nvim"

# Setup ranger config
rm -rf "$HOME/.config/ranger"
ln -s "$DEV/src/Dotfiles/ranger/" "$HOME/.config/ranger"

# Install TMUX Plug-In Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install ZSH Syntax
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

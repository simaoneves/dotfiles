#!/bin/bash

# DONT RUN AS ROOT

# Install Homebrew and apps
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sudo xcodebuild -license accept

brew update


brew install bat
brew install diff-so-fancy
brew install yabai
brew install spacebar
brew install cloc
brew install cowsay
brew install crystal-lang
brew install ctags
brew install docker-compose
brew install elixir
brew install fzf
brew install htop-osx
brew install jq
brew install kotlin
brew install lolcat
brew install mongodb
brew install pipes-sh
brew install python
brew install rabbitmq
brew install reattach-to-user-namespace
brew install ripgrep
brew install skhd
brew install the_silver_searcher
brew install tmux
brew install tree
brew install vim
brew install watch
brew install yarn

brew tap homebrew/cask

brew cask install alfred
brew cask install atom
brew cask install coconutbattery
brew cask install discord
brew cask install docker
brew cask install evernote
brew cask install flux
brew cask install google-chrome
brew cask install intellij-idea
brew cask install iterm2
brew cask install lastpass
brew cask install macvim
brew cask install rescuetime
brew cask install sizeup
brew cask install skype
brew cask install slack
brew cask install spotify
brew cask install vagrant
brew cask install virtualbox
brew cask install vlc
brew cask install whatsapp

# Create directories needed
mkdir ~/.git-templates
# mkdir ~/Dev/
# cd ~/Dev/
# git clone https://github.com/simaoneves/dotfiles.git

# Symlink everything needed
ln -s ~/Dev/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/Dev/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/Dev/dotfiles/.gvimrc ~/.gvimrc
ln -s ~/Dev/dotfiles/.vimrc ~/.vimrc
ln -s ~/Dev/dotfiles/coc-settings.json ~/.vim/coc-settings.json
ln -s ~/Dev/dotfiles/.ideavimrc ~/.ideavimrc
ln -s ~/Dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/Dev/dotfiles/.skhdrc ~/.skhdrc
ln -s ~/Dev/dotfiles/.yabairc ~/.yabairc
ln -s ~/Dev/dotfiles/.spacebarrc ~/.spacebarrc
ln -s ~/Dev/dotfiles/.limelightrc ~/.limelightrc
ln -s ~/Dev/dotfiles/.atom/ ~/.atom
ln -s ~/Dev/dotfiles/bin/.git-completion.bash ~/.git-completion.bash
ln -s ~/Dev/dotfiles/karabiner.json ~/.config/karabiner/assets/complex_modifications/karabiner.json
ln -s ~/Dev/dotfiles/git_commit_message.txt ~/.git-templates/git_commit_message.txt

# Install RVM
\curl -sSL https://get.rvm.io | bash -s stable --ruby

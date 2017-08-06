#!/bin/bash

# DONT RUN AS ROOT

# Install Homebrew and apps
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sudo xcodebuild -license accept

brew update

brew install cloc
brew install cowsay
brew install crystal-lang
brew install ctags
brew install elixir
brew install fzf
brew install htop-osx
brew install reattach-to-user-namespace
brew install the_silver_searcher
brew install tmux
brew install vim --with-lua --override-system-vim
brew install watchman
brew install mongodb

brew tap caskroom/cask

brew cask install alfred
brew cask install atom
brew cask install coconutbattery
brew cask install evernote
brew cask install flux
brew cask install google-chrome
brew cask install intellij-idea
brew cask install iterm2
brew cask install macvim
brew cask install sizeup
brew cask install skype
brew cask install slack
brew cask install spotify
brew cask install vagrant
brew cask install virtualbox
brew cask install vlc

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
ln -s ~/Dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/Dev/dotfiles/.atom/ ~/.atom
ln -s ~/Dev/dotfiles/./commit-msg ~/.atom
ln -s ~/Dev/dotfiles/bin/.git-completion.bash ~/.git-completion.bash
# Add git-stats file to home

# Install RVM
\curl -sSL https://get.rvm.io | bash -s stable --ruby

# Install with NPM
npm install -g diff-so-fancy
npm install -g git-stats


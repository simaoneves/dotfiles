#!/bin/bash

# Install Homebrew and apps
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update

brew install reattach-to-user-namespace
brew install the_silver_searcher
brew install cloc
brew install cowsay
brew install crystal-lang
brew install ctags
brew install elixir
brew install fzf
brew install htop-osx
brew install tmux
brew install vim

brew tap caskroom/cask

brew cask install alfred
brew cask install atom
brew cask install coconutbattery
brew cask install evernote
brew cask install google-chrome
brew cask install iterm2
brew cask install macvim
brew cask install skype
brew cask install spotify
brew cask install sizeup
brew cask install vagrant
brew cask install virtualbox
brew cask install vlc
brew cask install slack
brew cask install flux

# Create directories needed
mkdir ~/.git-templates
mkdir ~/Dev/
cd ~/Dev/
git clone https://github.com/simaoneves/dotfiles.git

# Symlink everything needed
ln -s ~/Dev/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/Dev/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/Dev/dotfiles/.gvimrc ~/.gvimrc
ln -s ~/Dev/dotfiles/.vimrc ~/.vimrc
ln -s ~/Dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/Dev/dotfiles/.atom/ ~/.atom
ln -s ~/Dev/dotfiles/./commit-msg ~/.atom
ln -s ~/Dev/dotfiles/bin/.git-completion.bash ~/.git-completion.bash

# Install RVM
\curl -sSL https://get.rvm.io | bash -s stable --ruby

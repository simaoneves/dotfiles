#!/bin/bash
function check_if_executable_exists() {
    [[ -x "$(command -v $1)" ]]
}

# Install Homebrew
if ! [[ $(check_if_executable_exists brew) -eq 0 ]]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (! $(check_if_executable_exists brew)) && echo "Install script error: $1 is not installed." >&2 && return 1
else
    echo "Homebrew already installed"
fi

# Make sure we have homebrew in PATH
# (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/simon/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "Installing Xcode... Might prompt for password"
sudo xcodebuild -license accept

echo "Updating Homebrew..."
brew update

brew tap zdcthomas/tools # for dmux

# make a list and install everything in one command
brew install bat
brew install cloc
brew install cowsay
brew install crystal-lang
brew install ctags
brew install diff-so-fancy
brew install docker-compose
brew install dmux
brew install elixir
brew install fzf
brew install graphviz
brew install htop-osx
brew install jq
brew install koekeishiya/formulae/skhd
brew install node
brew install kotlin
brew install lolcat
brew install pipes-sh
brew install python
brew install rabbitmq
brew install reattach-to-user-namespace
brew install ripgrep
brew install cmacrae/formulae/spacebar
brew install the_silver_searcher
brew install tmux
brew install tree
brew install vim
brew install watch
brew install yabai
brew install yarn

# make a list and install everything in one command
brew install --cask alfred
brew install --cask coconutbattery
brew install --cask discord
brew install --cask docker
brew install --cask evernote
brew install --cask flux
brew install --cask google-chrome
brew install --cask intellij-idea-ce
brew install --cask iterm2
brew install --cask karabiner-elements
brew install --cask lastpass
brew install --cask logi-options-plus
brew install --cask macvim
brew install --cask sizeup
brew install --cask slack
brew install --cask spotify
brew install --cask todoist
brew install --cask vagrant
brew install --cask virtualbox
brew install --cask vlc
brew install --cask whatsapp
brew install --cask dbeaver-community

# Create directories needed
echo "Creating necessary directories..."
mkdir ~/.git-templates
mkdir -p ~/.config/nvim/
mkdir -p ~/Dev/
cd ~/Dev/

echo "Cloning dotfiles..."
git clone https://github.com/simaoneves/dotfiles.git 

# Symlink everything needed
echo "Symlinking dotfiles..."
ln -sF ~/Dev/dotfiles/.bash_profile ~/.bash_profile
ln -sF ~/Dev/dotfiles/.gitconfig ~/.gitconfig
ln -sF ~/Dev/dotfiles/.gvimrc ~/.gvimrc
ln -sF ~/Dev/dotfiles/.vimrc ~/.vimrc
ln -sF ~/Dev/dotfiles/init.lua ~/.config/nvim/init.lua
ln -sF ~/Dev/dotfiles/coc-settings.json ~/.vim/coc-settings.json
ln -sF ~/Dev/dotfiles/.ideavimrc ~/.ideavimrc
ln -sF ~/Dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -sF ~/Dev/dotfiles/.global.gitignore ~/.global.gitignore
ln -sF ~/Dev/dotfiles/.skhdrc ~/.skhdrc
ln -sF ~/Dev/dotfiles/.yabairc ~/.yabairc
ln -sF ~/Dev/dotfiles/.spacebarrc ~/.spacebarrc
ln -sF ~/Dev/dotfiles/.limelightrc ~/.limelightrc
ln -sF ~/Dev/dotfiles/karabiner ~/.config
ln -sF ~/Dev/dotfiles/bin/.git-completion.bash ~/.git-completion.bash
ln -s ~/Dev/dotfiles/git_commit_message.txt ~/.git-templates/git_commit_message.txt

echo "Installing vim plugins..."
vim +PlugInstall +qall

echo "Installing Tmux Plugin Manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install RVM
if ! [[ $(check_if_executable_exists "rvm") -eq 0 ]]; then
  echo "Installing RVM..."
  curl -sSL https://get.rvm.io | bash -s stable --ruby
else
  echo "RVM already installed"
fi

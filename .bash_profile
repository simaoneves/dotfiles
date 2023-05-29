_fzf_complete_app() {
  _fzf_complete "--multi --reverse" "$@" < <(td apps | grep -e 'prd' -e 'qa' -e 'stg')
}

_fzf_complete_app_post() {
    sed 's/\([a-z\-]*\)\w*\([a-z\-]*\)/-r td-us-1 -a \1 -e \2/'
}

_fzf_complete_app_notrigger() {
    FZF_COMPLETION_TRIGGER='' _fzf_complete_app
}
[ -n "$BASH" ] && complete -o bashdefault -o default -F _fzf_complete_app_notrigger td && complete -o bashdefault -o default -F _fzf_complete_app_notrigger deploy_script

HISTFILESIZE=10000
HISTSIZE=10000

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color';
fi;

prompt_git() {
	local s='';
	local branchName='';
	local branchColor=${green};

	# Get the short symbolic ref.
	# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
	# Otherwise, just give up.
	branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
		git rev-parse --short HEAD 2> /dev/null || \
		echo '(unknown)')";

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				# s+='+';
				branchColor=${yellow};
			fi;

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				# s+='!';
				branchColor=${yellow};
			fi;

			# Check if there are unpushed commits on the current branch
			# if [ -n "$(git log origin/$branchName..$branchName --oneline)" ]; then
				# s+=" ${green}✓${reset}";
				# branchColor=${yellow};
			# fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				# s+='*';
				branchColor=${yellow};
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+=" ${branchColor}●${reset}";
				# branchColor=${yellow};
			fi;

		fi;

		[ -n "${s}" ] && s="${s}";

		echo -e "${1}${branchColor} ${branchName}${s}${reset}";
	else
		echo ""
	fi;
}

if tput setaf 1 &> /dev/null; then
    tput sgr0; # reset colors
    bold=$(tput bold);
    reset=$(tput sgr0);
    black=$(tput setaf 0);
    red=$(tput setaf 1);
    green=$(tput setaf 2);
    yellow=$(tput setaf 3);
    blue=$(tput setaf 4);
    magenta=$(tput setaf 5);
    cyan=$(tput setaf 6);
    white=$(tput setaf 7);
    orange=$(tput setaf 166);
    purple=$(tput setaf 125);
else
	bold='';
	reset="\e[0m";
	black="\e[1;30m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[1;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Shortcuts
alias db="cd ~/Dropbox"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias d="cd ~/Dev"
alias dotfiles="cd ~/Dev/dotfiles"

alias ls="ls -Gpah"
alias mkdir="mkdir -v"
alias rm="rm -v"
alias rdr="rm -Rfv"
alias rdss="find . -name \".DS_Store\" -delete"
alias th="history | awk '{CMD[\$2]++;count++;}END { for (a in CMD)print CMD[a] \" \" CMD[a]/count*100 \"% \" a;}' | grep -v \"./\" | column -c3 -s \" \" -t | sort -nr | nl |  head -n20"
alias ip="ifconfig | grep 'inet '"
alias ta="tmux attach-session"
alias tn="tmux new-session -s"
alias tdt="tmux detach"
alias grep="grep --color=auto"

alias gs="git status"
alias gb="git branch -v"
alias gd="git diff --color | diff-so-fancy | less --tabs=4 -RFX"
alias gdi="git diff --color --cached | diff-so-fancy | less --tabs=4 -RFX"
alias gds="git diff --stat"
alias gdis="git diff --stat --cached"
alias gco="git checkout"
alias gaf='git add $(git ls-files -m | _fzf_git_fzf --ansi -m --height 40% --header="Git add modified files" --preview="git diff --color=always {}")'
alias gcf='git checkout $(git ls-files -m | _fzf_git_fzf -m --height 40% --header="Git checkout modified files")'
alias stash="git stash save -u"
alias pop="git stash pop"
alias gpll="git pull"
alias gaa="git add . && echo 'To create a good commit message, complete the following sentence:' && echo 'If applied, this commit will..'"
alias gc="git commit"
alias gcm="git commit -m"
function gwa() {
    # maybe get root of git directory to prepend to .wt/new_name
    git worktree add .wt/$1 $1
    cd .wt/$1
}
function gwr() {
    git worktree remove .wt/$1
}
function gws() {
    tree=$(git worktree list | fzf | cut -d " " -f1)
    [[ ! -z "$tree" ]] && cd "$tree"
}
alias gwl="git worktree list"
alias gl="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glb="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias amend="git commit --amend"
alias unstage="git reset HEAD --"
alias undo_last_commit="git reset --soft HEAD~1"
alias sync_remote_branch='git reset --hard origin/$(git branch | grep \* | cut -d " " -f2)'
alias in_branch="git branch -a --contains"

alias mamp_start="/Applications/MAMP/bin/start.sh"
alias mamp_stop="/Applications/MAMP/bin/stop.sh"
alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias ios_sim="open -a '/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'"
alias pro="vim ~/Dev/dotfiles/.bash_profile"
alias reload="source ~/.bash_profile && echo Profile reloaded"
alias rpi="ssh simon@raspberrypi"
alias r="ruby"
alias r.="rubocop ."
alias cr="crystal"
alias v="vim"
alias sd="sudo"
alias mk="make"
alias mkt="make test"
alias mkb="make build"
alias dbm="rake db:migrate"
alias bi="bundle install"
alias be="bundle exec"
alias bers="bundle exec rails server"
alias rc="rails console"
alias dc="docker-compose"
alias dcr="docker-compose run"
alias dcb="docker-compose build"
alias drt="docker-compose run tests"
alias drw="docker-compose run --service-port dev"
alias dbrt="docker-compose build tests && docker-compose run tests"
alias dbr="docker-compose build $1 && docker-compose run $1"
alias htop="sudo htop"
alias coffee="caffeinate -dim -t 14400"
alias ys="yarn start"
alias yt="yarn test"
alias yb="yarn build"
alias yi="yarn install"
alias yl="yarn lint"
alias ns="npm start"
alias nt="npm test"
alias ni="npm install"
alias nr="npm run"
alias na="npm run android"
alias nios="npm run ios"
alias nox="npm run oxc"
alias nios5="react-native run-ios --simulator 'iPhone 5'"
alias nios6="react-native run-ios --simulator 'iPhone 6 Plus'"
alias nios7="react-native run-ios --simulator 'iPhone 7'"
alias logs="heroku logs -t -a"
alias saver='pipes.sh -r 5000 -r0 -p6 -K'

alias sub="subl"
alias gvim="/Applications/MacVim.app/Contents/bin/mvim"
alias a.="atom ."
alias v.="vim ."
alias v,="vim ."
alias .v="vim ."
alias ,v="vim ."
alias g.="gvim ."

# Functions
function github() {
	repo=`git config --get remote.origin.url | sed -e 's/\.git//'`
	open -a Google\ Chrome $repo
}
function deployed() {
    in_branch $1 | grep heroku_$2
}

_fzf_git_fzf() {
  fzf-tmux -p80%,60% -- \
    --layout=reverse --multi --height=50% --min-height=20 --border \
    --color='header:italic:underline' \
    --preview-window='right,50%,border-left' \
    --bind='ctrl-/:change-preview-window(down,50%,border-top|hidden|)' "$@"
}

function mergefiles() {
	if [ $# -lt 3 ]
    then
        echo "Not enough arguments!"
        echo "Command should be like:"
        echo "mergefiles file1 file2 new_file_name"
    else
        echo "Merging $1 with $2 to $3.."
        touch empty_temp_file
        git merge-file -p $1 empty_temp_file $2 > $3
        echo "Done!"
        command rm empty_temp_file
        number_conflicts=`cat $3 | grep "<<<<" | wc -l | xargs`
        if [ $number_conflicts -gt 1 ]
            then
                echo "CONFLICTS! We've got $number_conflicts problems, but a bitch ain't one!"
        fi
  fi
}

# gcb - git commit browser, using diff-so-fancy
# https://gist.github.com/junegunn/f4fca918e937e6bf5bad
gcb() {
  git log --all --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | diff-so-fancy | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# gfcb - git file commits browser, based on
# https://gist.github.com/junegunn/f4fca918e937e6bf5bad
gfcb() {
  git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" -- $1 | \
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | diff-so-fancy | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

function conflict_files() {
    git diff --name-only --diff-filter=U --relative
}

# Set the terminal title to the current working directory.
PS1="\[\033]0;\w\007\]";
# PS1+="\[${bold}\]\n"; # newline
PS1+="\[${magenta}\]\u: "; # username
PS1+="\[${blue}\]\w "; # working directory
PS1+="\$(prompt_git) "; # Git repository details
PS1+="\n";
PS1+="\[${white}\]→ \[${reset}\]"; # `$` (and reset color)
export PS1;

PS2="\[${yellow}\]→ \[${reset}\]";
export PS2;

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Editor setting preference
export EDITOR='vim'

if [ -f ~/Dev/dotfiles/bin/.git-completion.bash ]; then
  . ~/Dev/dotfiles/bin/.git-completion.bash

  # Add git completion to aliases
  __git_complete gco _git_checkout
  __git_complete gpll _git_pull
  __git_complete gwa _git_checkout
  __git_complete gwr _git_checkout
  __git_complete treemux_create_worktree _git_checkout
fi

# Get FZF shortcuts
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Load treemux
[ -f ~/Dev/dotfiles/bin/testing.sh ] && source ~/Dev/dotfiles/bin/testing.sh

# MacPorts Installer addition on 2015-10-22_at_13:07:27: adding an appropriate PATH variable for use with MacPorts.
export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/Cellar/:$PATH"
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Use AG in FZF
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
# Make it so that FZF is case insensitive by default
export FZF_DEFAULT_OPTS="-i --pointer=→ --marker='● ' --prompt='→ '"

# Load local definitions
if [ -f ~/bash_profile.local ]; then
  source ~/bash_profile.local
fi
if [ -f ~/.profile ]; then
  source ~/.profile
fi

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.jenv/bin:$PATH"

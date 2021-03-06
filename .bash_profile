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

# sqlplus for psi configurations
export SQLPATH=/Applications/sqlplus
export DYLD_LIBRARY_PATH=$SQLPATH
export TNS_ADMIN=$SQLPATH
export PATH=$PATH:$SQLPATH
export NLS_LANG=.AL32UTF8

# Shell prompt based on the Solarized Dark theme.
# Screenshot: http://i.imgur.com/EkEtphC.png
# Heavily inspired by @necolas’s prompt: https://github.com/necolas/dotfiles
# iTerm → Profiles → Text → use 13pt Monaco with 1.1 vertical spacing.

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

	# bold=$(tput bold);
	# reset=$(tput sgr0);
	# # Solarized colors, taken from http://git.io/solarized-colors.
	# black=$(tput setaf 0);
	# blue=$(tput setaf 33);
	# cyan=$(tput setaf 37);
	# green=$(tput setaf 64);
	# orange=$(tput setaf 166);
	# purple=$(tput setaf 125);
	# red=$(tput setaf 124);
	# violet=$(tput setaf 61);
	# white=$(tput setaf 15);
	# yellow=$(tput setaf 136);
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

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${red}";
else
	userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}";
else
	hostStyle="${yellow}";
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
alias dot="cd ~/Dev/dotfiles"
alias sabe="cd ~/Dev/sabe/sabe-online-web"
alias gh="cd ~/Dev/gymhopper"
alias gha="cd ~/Dev/gymhopper/gymhopper"
alias ghs="cd ~/Dev/gymhopper/gymhopper-server"
alias vvs="cd ~/Dev/vvs/"
alias tc="cd ~/Dev/tc/"

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
alias gaf='git add $(git ls-files -m | fzf -m --height 40%)'
alias stash="git stash save -u"
alias pop="git stash pop"
alias gpll="git pull"
alias gaa="git add . && echo 'To create a good commit message, complete the following sentence:' && echo 'If applied, this commit will..'"
alias gc="git commit"
alias gcm="git commit -m"
alias amend="git commit --amend"
alias unstage="git reset HEAD --"
alias sync_remote_branch='git reset --hard origin/$(git branch | grep \* | cut -d " " -f2)'
alias gl="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias in_branch="git branch -a --contains"
alias rebase_master="git rebase origin/master"

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
alias dc="docker-compose"
alias dcr="docker-compose run"
alias dcb="docker-compose build"
alias drt="docker-compose run tests"
alias drw="docker-compose run --service-port dev"
alias dbrt="docker-compose build tests && docker-compose run tests"
alias dbr="docker-compose build $1 && docker-compose run $1"
alias htop="sudo htop"
alias coffee="caffeinate -dim -t 14400"
alias sql="sqlplus psi24@difcul"
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

alias sub="subl"
alias gvim="/Applications/MacVim.app/Contents/bin/mvim"
alias a.="atom ."
alias v.="vim ."
alias v,="vim ."
alias .v="vim ."
alias ,v="vim ."
alias g.="gvim ."
alias jess="java -cp jess.jar jess.Main"
alias gcc="ssh fc45681@gcc.alunos.di.fc.ul.pt"
alias antlr4='java -jar /usr/local/lib/antlr-4.6-complete.jar'
alias saver='pipes.sh -r 5000 -r0 -p6 -K'

# Functions
function github() {
	repo=`git config --get remote.origin.url | sed -e 's/\.git//'`
	open -a Google\ Chrome $repo
}
function deployed() {
    in_branch $1 | grep heroku_$2
}

function gstat() {
	git-stats -g && git log --format='%aN' | sort -u | { echo -en "Name\tLines Added\tLines Deleted\tTotal Lines\n"; echo -en "----\t-----------\t-------------\t-----------\n"; while read name; do git log --author="$name" --pretty=tformat: --numstat | awk -v name="$name" '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "%s\t%d\t%d\t%d\n", name, add, subs, loc }' - ; done } | column -ts $'\t' | cowsay -n | lolcat
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
function battery_charge() {
  if [ -e ~/Dev/dotfiles/bin/batcharge.py ]
  then
      echo `python ~/Dev/dotfiles/bin/batcharge.py`
  else
      echo '';
  fi
}

function get_pwd() {
    result="${PWD/$HOME/~}"
    echo ${#result}
}

function get_git() {
    pepe=`prompt_git`
    result=0
    if [ ${#pepe} != 0 ]; then
        result=$(( ${#pepe} - 11 ))
    else
        result=0
    fi
    echo $result
}

function get_bat() {
    lolo=`battery_charge`
    result=0
    if [ ${#lolo} != 0 ]; then
        result=$(( ${#lolo} - 4 ))
    else
        result=0
    fi
    echo $result
}

function put_spacing() {
    get_pwd_number=`get_pwd`
    get_bat_number=`get_bat`
    get_git_number=`get_git`
    local termwidth=0
    (( termwidth = ${COLUMNS} - 3 - ${#LOGNAME} - ${get_pwd_number} - ${get_git_number} - ${get_bat_number} ))
    echo $termwidth
}

function last_command_color() {
    if [[ $? = 0 ]]; then
    # if [[ $? -eq 0 ]]; then
        status=${white}
    else
        status=${red}
    fi;
    echo $status
}

function save_output() {
    if [[ $? = 0 ]]; then
    # if [[ $? -eq 0 ]]; then
        export LAST=0;
    else
        export LAST=1;
    fi;
}

# Set the terminal title to the current working directory.
PS1="\[\033]0;\w\007\]";
# PS1+="\$(save_output)"; # `$` (and reset color)
# PS1+="\[${bold}\]\n"; # newline
PS1+="\[${magenta}\]\u: "; # username
# PS1+="\[${white}\] at ";
# PS1+="\[${holtStyle}\]\h"; # host
# PS1+="\[${white}\] in ";
PS1+="\[${blue}\]\w "; # working directory
# PS1+='$(printf %$(put_spacing)s)'; # Add spacings
PS1+="\$(prompt_git) "; # Git repository details
# PS1+="\$(battery_charge)"; # batery
PS1+="\n";
PS1+="\[${white}\]→ \[${reset}\]"; # `$` (and reset color)
# PS1+="\$(last_command_color)→ \[${reset}\]"; # `$` (and reset color)
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
fi

# Source bashrc to get FZF shortcuts
source ~/.bashrc

# MacPorts Installer addition on 2015-10-22_at_13:07:27: adding an appropriate PATH variable for use with MacPorts.
export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/Cellar/:$PATH"
export PATH="/Users/simao.neves/Dev/kotlin-language-server/server/build/install/server/bin/:$PATH"
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export CLASSPATH=".:/usr/local/lib/antlr-4.0-complete.jar:$CLASSPATH"
export PATH=".:/usr/local/lib/antlr-4.0-complete.jar:$PATH"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# Load local definitions
if [ -f ~/bash_profile.local ]; then
  source ~/bash_profile.local
fi

# export PAGER=most
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

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
	local branchColor=${red};

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='+';
				branchColor=${red};
			fi;
			
			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+='!';
				branchColor=${red};
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+='*';
				branchColor=${red};
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+='$';
				branchColor=${yellow};
			fi;

		fi;

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		[ -n "${s}" ] && s=": ${s}";

		echo -e "${1}${branchColor}[${branchName}${s}]";
	else
		echo ""
	fi;
}

if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	# Solarized colors, taken from http://git.io/solarized-colors.
	black=$(tput setaf 0);
	blue=$(tput setaf 33);
	cyan=$(tput setaf 37);
	green=$(tput setaf 64);
	orange=$(tput setaf 166);
	purple=$(tput setaf 125);
	red=$(tput setaf 124);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 136);
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

alias ls="ls -Ga"
alias mkdir="mkdir -v"
alias rm="rm -v"

alias gs="git status"
alias gb="git branch -v"
alias gd="git diff $1"
alias gc="git checkout $1"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias mamp_start="/Applications/MAMP/bin/start.sh"
alias mamp_stop="/Applications/MAMP/bin/stop.sh"
alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias ios_sim="open -a 'iPhone Simulator'"
alias pro="sub ~/Dev/dotfiles/.bash_profile"
alias reload="source ~/.bash_profile && echo Profile reloaded"

alias sd="cd ~/Dropbox\ \(Personal\)/'FCUL DB'/'Sistemas Distribuídos'/Projectos"
alias sabe="cd ~/Dev/sabe/sabe-online-web"

# Functions
sub() {
	open $1 -a "Sublime Text 2"
}

github() {
	repo_name=`basename "${PWD}"`
	open -a Google\ Chrome http://www.github.com/simaoneves/$repo_name
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
		result=$(( ${#lolo} - 10 ))
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
PS1+="\[${bold}\]\n"; # newline
PS1+="\[${cyan}\]\u: "; # username
# PS1+="\[${white}\] at ";
# PS1+="\[${hostStyle}\]\h"; # host
# PS1+="\[${white}\] in ";
PS1+="\[${yellow}\]\w"; # working directory
PS1+='$(printf %$(put_spacing)s)'; # Add spacings
PS1+="\$(prompt_git) "; # Git repository details
PS1+="\$(battery_charge)"; # batery
PS1+="\n";
PS1+="\$(last_command_color)→ \[${reset}\]"; # `$` (and reset color)
export PS1;

PS2="\[${yellow}\]→ \[${reset}\]";
export PS2;

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# Editor setting preference
# export EDITOR="sub"


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

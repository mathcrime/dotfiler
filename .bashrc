# .bashrc

if [[ $- != *i* ]]; then
	# Shell is non-interactive.  Be done now!
    return
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histappend

set -o ignoreeof
set -o noclobber

shopt -s autocd
shopt -s cdspell
shopt -s checkjobs

shopt -s hostcomplete
shopt -s globstar
shopt -s extglob

export HISTCONTROL=ignoredups

export EDITOR=vim
export PAGER=less

export TERM=xterm-256color

# Set up environment's PATH 
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

if [ -f /usr/local/share/bash-completion/bash_completion ]
then
    . /usr/local/share/bash-completion/bash_completion
fi

# Change the window title of X terminals 
case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|interix|tmux*)
		PS1='\[\033]0;\u@\h:\w\007\]'
		;;
	screen*)
		PS1='\[\033k\u@\h:\w\033\\\]'
		;;
	*)
		unset PS1
		;;
esac

lowercase(){
    echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

OS=`lowercase \`uname\``
OSTYPE=''
KERNEL=`uname -r`
MACH=`uname -m`
DISTRO=''

f [[ "$OSTYPE" =~ ^darwin ]]; then

case $OS in
	windows*)
		export OS_TYPE=windows;;
	linux*)
		export OS_TYPE=linux;;
	*bsd*)
		if [[ "$OS" =~ ^freebsd ]]; then
			export OS_TYPE=freebsd
		else
			export OS_TYPE=bsd
		fi
	darwin*)
		export OS_TYPE=darwin;;
	cygwin*)
		export OS_TYPE=cygwin;;
	solaris*)
		export OS_TYPE=solaris;;
	msys*)
		export OS_TYPE=windows;;
	*)
		export OS_TYPE=unknown;;
esac
		
# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.
# We run dircolors directly due to its changes in file syntax and
# terminal name patching.
use_color=false
if type -P dircolors >/dev/null ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	LS_COLORS=
	if [[ -f ~/.dir_colors ]] ; then
		eval "$(dircolors -b ~/.dir_colors)"
	elif [[ -f /etc/DIR_COLORS ]] ; then
		eval "$(dircolors -b /etc/DIR_COLORS)"
	else
		eval "$(dircolors -b)"
	fi
	# Note: We always evaluate the LS_COLORS setting even when it's the
	# default.  If it isn't set, then `ls` will only colorize by default
	# based on file attributes and ignore extensions (even the compiled
	# in defaults of dircolors). #583814
	if [[ -n ${LS_COLORS:+set} ]] ; then
		use_color=true
	else
		# Delete it if it's empty as it's useless in that case.
		unset LS_COLORS
	fi
else
	# Some systems (e.g. BSD & embedded) don't typically come with
	# dircolors so we need to hardcode some terminals in here.
	case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|screen|tmux|cons25|*color) use_color=true;;
	esac
fi

if ${use_color} ; then
	if [[ ${EUID} == 0 ]] ; then
		PS1+='\[\033[01;31m\]\h\[\033[01;34m\] \w \$\[\033[00m\] '
	else
		PS1+='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
	fi
else
	# show root@ when we don't have colors
	PS1+='\u@\h \w \$ '
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# quick ssh hostname completion
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# User specific aliases and functions
#if [ -d ~/.bashrc.d ]; then
#	for rc in ~/.bashrc.d/*; do
#		if [ -f "$rc" ]; then
#			. "$rc"
#		fi
#	done
#fi

if [ -d ~/.bashrc.d ]; then
	. ~/.bashrc.d/bash_aliases
	. ~/.bashrc.d/bash_functions
#	. ~/.bashrc.d/bash_colors
fi
unset rc

if [ -f $HOME/.cargo/env ]
	. "$HOME/.cargo/env"
fi

# Colors for less
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Prompt
RESET="\e[0m"
GREEN="\e[32m"
YELLOW="\e[93m"
RED="\e[91m"
BLUE="\e[34m"

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Try to keep environment pollution down, EPA loves us.
unset use_color sh

# BEGIN_KITTY_SHELL_INTEGRATION
# if test -e "$HOME/src/kitty/shell-integration/kitty.bash"; then source "$HOME/src/kitty/shell-integration/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

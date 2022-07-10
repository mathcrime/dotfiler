# .bashrc

if [[ $- != *i* ]]; then
    return
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
set -o ignoreeof

shopt -s autocd
shopt -s cdspell
shopt -s checkjobs

shopt -s hostcomplete
shopt -s globstar
shopt -s extglob
shopt -s no_empty_cmd_completion

shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histappend

export HISTCONTROL=ignoredups

export EDITOR=vim
export PAGER=less

export TERM=xterm-256color

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

if [ -f /usr/local/share/bash-completion/bash_completion ]
then
    . /usr/local/share/bash-completion/bash_completion
fi


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
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


# BEGIN_KITTY_SHELL_INTEGRATION
# if test -e "$HOME/src/kitty/shell-integration/kitty.bash"; then source "$HOME/src/kitty/shell-integration/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

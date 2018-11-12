#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

if [ -e ~/.bashrc.aliases ] ; then
   source ~/.bashrc.aliases
fi

export BROWSER=/usr/bin/google-chrome-stable
export EDITOR=/usr/bin/nvim
export TERM=xterm-256color

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

base16_eighties

POWERLINE_SHELL="$HOME/.bash-powerline.sh"
[[ -s $POWERLINE_SHELL ]] && source $POWERLINE_SHELL

# [[ $TERM != "screen" ]] && exec tmux

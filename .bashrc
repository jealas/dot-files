#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

TERM=rxvt-unicode-256color

alias ls='ls --color=auto'

BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
alias colorme='source $BASE16_SHELL'
[[ -s $BASE16_SHELL ]] && colorme


POWERLINE_SHELL="$HOME/.bash-powerline.sh"
[[ -s $POWERLINE_SHELL ]] && source $POWERLINE_SHELL
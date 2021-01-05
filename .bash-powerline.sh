#!/usr/bin/env bash

__powerline() {

    # Unicode symbols
    readonly GIT_BRANCH_SYMBOL='⑂ '
    readonly GIT_BRANCH_CHANGED_SYMBOL='+'
    readonly GIT_NEED_PUSH_SYMBOL='⇡'
    readonly GIT_NEED_PULL_SYMBOL='⇣'

    # Color Scheme
    readonly FG_WHITE="\[$(tput setaf 15)\]"
    readonly FG_BLACK="\[$(tput setaf 18)\]"

    readonly BG_VENV="\[$(tput setab 18)\]"
    readonly FG_VENV="\[$(tput setaf 3)\]"

    readonly BG_DIRECTORY="\[$(tput setab 7)\]"
    readonly BG_GIT="\[$(tput setab 19)\]"
    readonly FG_GIT_AHEAD="\[$(tput setaf 12)\]"
    readonly FG_GIT_BEHIND="\[$(tput setaf 13)\]"

    readonly BG_EXIT="\[$(tput setab 18)\]"
    readonly FG_EXIT_SUCCESS="\[$(tput setaf 2)\]"
    readonly FG_EXIT_FAIL="\[$(tput setaf 1)\]"

    readonly BOLD_TEXT="\[$(tput bold)]"
    readonly RESET="\[$(tput sgr0)\]"

    __git_info() { 
        [ -x "$(which git)" ] || return    # git not found

        git rev-parse --git-dir 2> /dev/null 1> /dev/null
        if [ $? -ne 0 ]; then
          printf " $USER "
          return
        fi

        local git_eng="env LANG=C git"   # force git output in English to make our work easier
        # get current branch name or short SHA1 hash for detached head
        local branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null || $git_eng describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || exit  # git branch not found

        local marks

        # branch is modified?
        [ -n "$($git_eng status --porcelain)" ] && marks+=" $GIT_BRANCH_CHANGED_SYMBOL"

        # how many commits local branch is ahead/behind of remote?
        local stat="$($git_eng status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        local aheadN="$(echo $stat | grep -o 'ahead [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
        local behindN="$(echo $stat | grep -o 'behind [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
        [ -n "$aheadN" ] && marks+=" $FG_GIT_AHEAD$GIT_NEED_PUSH_SYMBOL$aheadN"
        [ -n "$behindN" ] && marks+=" $FG_GIT_BEHIND$GIT_NEED_PULL_SYMBOL$behindN"

        # print the git branch segment without a trailing newline
        printf " $GIT_BRANCH_SYMBOL$branch$marks "
    }

    __check_venv() {
      if [ -n "$VIRTUAL_ENV" ]; then
          printf " venv "
      fi
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly. 
        local exit_code=$?;
        if [ $exit_code -eq 0 ]; then
            local FG_EXIT="$FG_EXIT_SUCCESS"
            local PS_SYMBOL='$'
        else
            local FG_EXIT="$FG_EXIT_FAIL"
            local PS_SYMBOL="${exit_code}"
        fi

        PS1="\n"
        PS1+="$BG_VENV$FG_VENV$(__check_venv)$RESET"
        PS1+="$BG_DIRECTORY$FG_BLACK \W $RESET"
        PS1+="$BG_GIT$FG_WHITE$(__git_info)$RESET"
        PS1+="$BG_EXIT$FG_EXIT $PS_SYMBOL $RESET "
    }

    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline

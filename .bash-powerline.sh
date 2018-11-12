#!/usr/bin/env bash

__powerline() {

    # Unicode symbols
    readonly PS_SYMBOL='$'
    readonly GIT_BRANCH_SYMBOL='⑂ '
    readonly GIT_BRANCH_CHANGED_SYMBOL='+'
    readonly GIT_NEED_PUSH_SYMBOL='⇡'
    readonly GIT_NEED_PULL_SYMBOL='⇣'

    # Color Scheme
    readonly FG_WHITE="\[$(tput setaf 15)\]"
    readonly FG_BLACK="\[$(tput setaf 18)\]"

    readonly BG_DIRECTORY="\[$(tput setab 4)\]"
    readonly BG_GIT="\[$(tput setab 5)\]"
    readonly BG_VENV="\[$(tput setab 19)\]"

    readonly BG_EXIT_SUCCESS="\[$(tput setab 2)\]"
   readonly BG_EXIT_FAIL="\[$(tput setab 1)\]"

    readonly RESET="\[$(tput sgr0)\]"

    __git_info() { 
        [ -x "$(which git)" ] || return    # git not found

        local git_eng="env LANG=C git"   # force git output in English to make our work easier
        # get current branch name or short SHA1 hash for detached head
        local branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null || $git_eng describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || return  # git branch not found

        local marks

        # branch is modified?
        [ -n "$($git_eng status --porcelain)" ] && marks+=" $GIT_BRANCH_CHANGED_SYMBOL"

        # how many commits local branch is ahead/behind of remote?
        local stat="$($git_eng status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        local aheadN="$(echo $stat | grep -o 'ahead [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
        local behindN="$(echo $stat | grep -o 'behind [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
        [ -n "$aheadN" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
        [ -n "$behindN" ] && marks+=" $GIT_NEED_PULL_SYMBOL$behindN"

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
        if [ $? -eq 0 ]; then
            local BG_EXIT="$BG_EXIT_SUCCESS"
        else
            local BG_EXIT="$BG_EXIT_FAIL"
        fi

        PS1="\n"
        PS1+="$BG_VENV$FG_WHITE$(__check_venv)$RESET"
        PS1+="$BG_DIRECTORY$FG_WHITE \W $RESET"
        PS1+="$BG_GIT$FG_WHITE$(__git_info)$RESET"
        PS1+="$BG_EXIT$FG_WHITE $PS_SYMBOL $RESET "
    }

    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline

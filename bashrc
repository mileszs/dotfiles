# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

### COLORS ###
          RED="\[\033[0;31m\]"
    LIGHT_RED="\[\033[1;31m\]"
       YELLOW="\[\033[1;33m\]"
       ORANGE="\[\033[0;33m\]"
         BLUE="\[\033[0;34m\]"
   LIGHT_BLUE="\[\033[1;34m\]"
        GREEN="\[\033[0;32m\]"
  LIGHT_GREEN="\[\033[1;32m\]"
         CYAN="\[\033[0;36m\]"
   LIGHT_CYAN="\[\033[1;36m\]"
       PURPLE="\[\033[0;35m\]"
 LIGHT_PURPLE="\[\033[1;35m\]"
        WHITE="\[\033[1;37m\]"
   LIGHT_GRAY="\[\033[0;37m\]"
        BLACK="\[\033[0;30m\]"
         GRAY="\[\033[1;30m\]"
     NO_COLOR="\[\e[0m\]"

### PROMPT ###
function prompt_func() {

  git diff --quiet HEAD &>/dev/null
  if [[ $? == 1 ]]; then
    # Add an asterisk if we have uncommited changes
    export PS1="${GREEN}\u@\h${WHITE}:${CYAN}\w ${LIGHT_RED}\$(__git_ps1 \"(%s*)\")${NO_COLOR}\$ "
    #echo "${RED}$branch*${NO_COLOR}"
  else
    export PS1="${GREEN}\u@\h${WHITE}:${CYAN}\w ${ORANGE}\$(__git_ps1 \"(%s)\")${NO_COLOR}\$ "
    #echo "${ORANGE}$branch${NO_COLOR}"
  fi
}

PROMPT_COMMAND=prompt_func

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# tab completion only for directories when using 'cd'
complete -d cd

# vi editing mode in bash
set -o vi

# ^p check for partial match in history
bind -m vi-insert "\C-p":dynamic-complete-history
# ^n cycle through the list of partial matches
bind -m vi-insert "\C-n":menu-complete

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# aliases
source ~/.bash/aliases.sh

# environment variables
source ~/.bash/env.sh

# functions
source ~/.bash/funcs.sh

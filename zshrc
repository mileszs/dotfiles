# This borrows from my .bashrc, of course, and also heavily from
#  claytron: http://github.com/claytron/dotfiles

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

UNAME=$(uname)
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="miloshadzic"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(rails ruby git osx zsh-syntax-highlighting chruby vi-mode)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export EDITOR=vim
export NODE_PATH="/usr/local/lib/node"

export CDPATH=$CDPATH:$HOME:$HOME/code

# use vi mode
bindkey -v

# use home and end in addition to ^e and ^a
bindkey -M viins '^A' vi-beginning-of-line
bindkey -M viins '^E' vi-end-of-line
if [ $UNAME = "Linux" ]; then
  bindkey -M viins '^[OH' vi-beginning-of-line
  bindkey -M viins '^[OF' vi-end-of-line
else
  bindkey -M viins '^[[H' vi-beginning-of-line
  bindkey -M viins '^[[F' vi-end-of-line
fi
# use delete as forward delete
bindkey -M viins '\e[3~' vi-delete-char
# line buffer
bindkey -M viins '^B' push-line-or-edit
# change the '-' for up in history, always kills my command editing.
bindkey -M vicmd '^[OA' vi-up-line-or-history
# change the shortcut for expand alias
bindkey -M viins '^X' _expand_alias

# edit current command in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Load the zmv module for some awesome file renaming
autoload -U zmv

setopt NO_BEEP
# Changing Directories
setopt AUTO_CD
setopt CDABLE_VARS
setopt AUTO_PUSHD

# History
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY

setopt EXTENDED_GLOB

for a in `ls $HOME/.zsh/*.sh`; do
  source $a
done

unsetopt auto_name_dirs
unset GREP_OPTIONS

typeset -U path cdpath fpath

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export PATH="/usr/local/bin:$PATH"

# chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# NVM
source ~/.nvm/nvm.sh

# For GNU utils from homebrew
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

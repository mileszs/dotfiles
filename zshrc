# This borrows from my .bashrc, of course, and also heavily from
#  claytron: http://github.com/claytron/dotfiles

typeset -U path cdpath fpath manpath

# ---------------------------------------------------------------------------
# Platform
#
# IS_MACOS / IS_LINUX are used throughout ~/.zsh/*.sh too, so they are set
# before anything else and exported for the scripts in ~/.bin.
# ---------------------------------------------------------------------------
case "$(uname -s)" in
  Darwin) IS_MACOS=1; IS_LINUX=0 ;;
  Linux)  IS_MACOS=0; IS_LINUX=1 ;;
  *)      IS_MACOS=0; IS_LINUX=0 ;;
esac
export IS_MACOS IS_LINUX

# ---------------------------------------------------------------------------
# PATH, before oh-my-zsh so plugins can find these tools
# ---------------------------------------------------------------------------

# Homebrew: Apple Silicon, Intel, or Linuxbrew — whichever is actually here.
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [[ -x $brew_bin ]]; then
    eval "$($brew_bin shellenv)"
    break
  fi
done
unset brew_bin

# GNU coreutils/sed from Homebrew, so scripts behave the same on both machines.
if (( IS_MACOS )) && [[ -n ${HOMEBREW_PREFIX:-} ]]; then
  for gnu_pkg in coreutils gnu-sed; do
    [[ -d $HOMEBREW_PREFIX/opt/$gnu_pkg/libexec/gnubin ]] &&
      path=($HOMEBREW_PREFIX/opt/$gnu_pkg/libexec/gnubin $path)
    [[ -d $HOMEBREW_PREFIX/opt/$gnu_pkg/libexec/gnuman ]] &&
      manpath=($HOMEBREW_PREFIX/opt/$gnu_pkg/libexec/gnuman $manpath)
  done
  unset gnu_pkg

  # Rosetta build of Homebrew, when there is one to alias.
  [[ -x /usr/local/bin/brew ]] && alias ibrew='arch -x86_64 /usr/local/bin/brew'
fi

# asdf. Version managers changed shape at 0.16: older releases are a shell
# function sourced from asdf.sh, newer ones are a Go binary that only needs
# its shim directory on PATH.
ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
if [[ -f ${ASDF_DIR:-$HOME/.asdf}/asdf.sh ]]; then
  source "${ASDF_DIR:-$HOME/.asdf}/asdf.sh"
elif [[ -n ${HOMEBREW_PREFIX:-} && -f $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh ]]; then
  source "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh"
elif (( $+commands[asdf] )); then
  path=($ASDF_DATA_DIR/shims $path)
  [[ -d $ASDF_DATA_DIR/completions ]] && fpath=($ASDF_DATA_DIR/completions $fpath)
fi

path=($HOME/.bin $HOME/.local/bin $path)

# ---------------------------------------------------------------------------
# oh-my-zsh
# ---------------------------------------------------------------------------
export ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=${ZSH_CUSTOM:-$ZSH/custom}

# starship draws the prompt (see the Tools section below) and oh-my-zsh is kept
# for plugins only, so no theme. Boxes without starship fall back to muse.
if (( $+commands[starship] )); then
  export ZSH_THEME=""
else
  # Look in ~/.oh-my-zsh/themes/
  export ZSH_THEME="muse"
fi

plugins=(git vi-mode)
(( IS_MACOS )) && plugins+=(macos)

# These two are separate clones; ./install fetches them. Loading a plugin that
# isn't there makes oh-my-zsh complain on every new shell, so check first.
# zsh-syntax-highlighting has to stay last.
for zsh_plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  [[ -d $ZSH_CUSTOM/plugins/$zsh_plugin ]] && plugins+=($zsh_plugin)
done
unset zsh_plugin

if [[ -r $ZSH/oh-my-zsh.sh ]]; then
  source $ZSH/oh-my-zsh.sh
else
  print -u2 "oh-my-zsh not found at $ZSH — run the dotfiles ./install script"
  autoload -Uz compinit && compinit
fi

# oh-my-zsh defines its own clipcopy/clippaste, and its versions hard-fail on a
# headless Linux box ("Platform linux-gnu not supported"). Drop them so the
# scripts in ~/.bin win by PATH lookup — those fall back to tmux and OSC 52.
unfunction clipcopy clippaste 2>/dev/null

# ---------------------------------------------------------------------------
# Environment
# ---------------------------------------------------------------------------
export EDITOR=nvim
export VISUAL=$EDITOR

cdpath=($HOME $HOME/code)
export DEFAULT_USER="mileszs"

# Ruby/OpenSSL fork safety, needed for opensearch access from ruby on Apple
# Silicon. Meaningless on Linux.
(( IS_MACOS )) && export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# ---------------------------------------------------------------------------
# Keybindings
# ---------------------------------------------------------------------------

# use vi mode
bindkey -v

# use home and end in addition to ^e and ^a
bindkey -M viins '^A' vi-beginning-of-line
bindkey -M viins '^E' vi-end-of-line
# Terminals disagree about Home/End; bind both the application-cursor and the
# normal-cursor forms rather than guessing from the OS.
for home_key in '^[OH' '^[[H' '^[[1~' '^[[7~'; do
  bindkey -M viins "$home_key" vi-beginning-of-line
done
for end_key in '^[OF' '^[[F' '^[[4~' '^[[8~'; do
  bindkey -M viins "$end_key" vi-end-of-line
done
unset home_key end_key

# use delete as forward delete
bindkey -M viins '\e[3~' vi-delete-char
# line buffer
bindkey -M viins '^B' push-line-or-edit
# change the '-' for up in history, always kills my command editing.
bindkey -M vicmd '^[OA' vi-up-line-or-history
# change the shortcut for expand alias
bindkey -M viins '^X' _expand_alias
# restore history search ability using Ctrl-R
bindkey "^R" history-incremental-search-backward

# edit current command in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Load the zmv module for some awesome file renaming
autoload -U zmv

# ---------------------------------------------------------------------------
# Options
# ---------------------------------------------------------------------------
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

unsetopt auto_name_dirs

# ---------------------------------------------------------------------------
# Aliases, functions, and the rest of ~/.zsh
# ---------------------------------------------------------------------------
# (N) so an empty or missing ~/.zsh doesn't abort the rest of this file.
for zsh_conf in $HOME/.zsh/*.sh(N); do
  source $zsh_conf
done
unset zsh_conf

# ---------------------------------------------------------------------------
# Tools
# ---------------------------------------------------------------------------

# fzf gained `fzf --zsh` in 0.48; fall back to the generated ~/.fzf.zsh.
if (( $+commands[fzf] )) && fzf --zsh >/dev/null 2>&1; then
  source <(fzf --zsh)
elif [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# Prompt. Config lives at config/starship.toml -> ~/.config/starship.toml.
(( $+commands[starship] )) && eval "$(starship init zsh)"

(( $+commands[wt] )) && eval "$(command wt config shell init zsh)"

# peon-ping quick controls
if [[ -d $HOME/.claude/hooks/peon-ping ]]; then
  alias peon="bash $HOME/.claude/hooks/peon-ping/peon.sh"
  [[ -f $HOME/.claude/hooks/peon-ping/completions.bash ]] &&
    source $HOME/.claude/hooks/peon-ping/completions.bash
fi

# Flag a shell that ended up under Rosetta.
if (( IS_MACOS )) && [[ "$(arch)" == i386 ]]; then
  export PS1="%F{red}[rosetta]%f $PS1"
fi

unset GREP_OPTIONS

# ---------------------------------------------------------------------------
# Machine-specific overrides — not tracked in the dotfiles repo
# ---------------------------------------------------------------------------
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

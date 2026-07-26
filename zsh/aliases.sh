alias reload='source ~/.zshrc'

# lsd if it's installed, otherwise fall back to a colourised plain ls. BSD ls
# spells colour -G, GNU ls spells it --color=auto, hence the split.
if (( $+commands[lsd] )); then
  alias ls='lsd'
elif (( $+commands[eza] )); then
  alias ls='eza'
elif (( IS_MACOS )); then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi

alias ll='ls -l'
alias la='ls -A'
alias l='ls -lA'
alias lla='ls -la'

alias t='tree -L 1 -C -h'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../..'
alias grep='grep --color'

alias mkdir='mkdir -p'

alias v='nvim'
alias sv='sudo nvim'

alias hg='history | grep'

# Debian renames these binaries to avoid collisions; give them their real names.
if (( ! $+commands[fd] && $+commands[fdfind] )); then
  alias fd='fdfind'
fi
if (( ! $+commands[bat] && $+commands[batcat] )); then
  alias bat='batcat'
fi

# Rails
alias b='bundle exec'
alias bi='bundle install'
alias bake='noglob bin/rake'
alias server='bin/rails server'
alias console='bin/rails console'
alias generate='bin/rails generate'
alias rspec='bundle exec rspec'
alias rs='bin/rspec'
alias migrate='bin/rake db:migrate db:test:prepare'
alias rc='bin/rake rubycritic:local'

# Ruby
# zsh globbing interferes with passing arguments using square brackets
# Ex. rake new_post[some blog post title]
alias rake='noglob rake'

# show sorted directory sizes for all directories
# -d 1 rather than --max-depth=1: BSD du only understands the short form.
alias dua='du -ch -d 1'
alias duv='du -sch ./*'
alias duh='du -sch ./.*'

# human df
alias dfh='df -h'

# system monitoring
# `sort -n +2` is the obsolete pre-POSIX form and GNU sort rejects it outright.
alias topcpu='ps aux | sort -rnk 3 | head -10'  # top 10 cpu processes
alias topmem='ps aux | sort -rnk 4 | head -10'  # top 10 memory processes
alias psg='ps aux | grep'

# show what ports are open locally
if (( IS_LINUX )) && (( $+commands[ss] )); then
  alias local_ports='ss -tulpn'
else
  alias local_ports='sudo nmap -sT -O localhost'
fi

# Postgresql — Homebrew runs it out of the prefix, Linux runs it as a service.
if (( IS_MACOS )); then
  alias pggo="pg_ctl -D ${HOMEBREW_PREFIX:-/usr/local}/var/postgres -l ${HOMEBREW_PREFIX:-/usr/local}/var/postgres/server.log start"
  alias pgstop="pg_ctl -D ${HOMEBREW_PREFIX:-/usr/local}/var/postgres stop -s -m fast"
else
  alias pggo='sudo systemctl start postgresql'
  alias pgstop='sudo systemctl stop postgresql'
fi

# Redis
if (( IS_MACOS )); then
  alias rgo="redis-server ${HOMEBREW_PREFIX:-/usr/local}/etc/redis.conf"
else
  alias rgo='sudo systemctl start redis-server'
fi

# thesaurus (linked to ~/.thesaurus.rb by ./install)
alias thes='ruby ~/.thesaurus.rb'

solarize()
{
  highlight -O rtf --style=solarized-dark --line-numbers "$1" | clipcopy
}

# kubernetes
alias k=kubectl

# Homebrew
if (( $+commands[brew] )); then
  alias bri='brew install'
  alias brf='brew info'
  alias brs='brew search'
elif (( $+commands[apt] )); then
  alias bri='sudo apt install'
  alias brf='apt show'
  alias brs='apt search'
fi

# Claude Code
alias ccdanger='claude --dangerously-skip-permissions'
alias cc=claude

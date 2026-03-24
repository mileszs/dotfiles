alias reload='source ~/.zshrc'

alias ls='lsd'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -Gla'
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
alias dua='du -ch --max-depth=1'
alias duv='du -sch ./*'
alias duh='du -sch ./.*'

# human df
alias dfh='df -h'

# system monitoring
alias topcpu='ps aux | sort -n +2 | tail -10'  # top 10 cpu processes
alias topmem='ps aux | sort -n +3 | tail -10'  # top 10 memory processes
alias psg='ps aux | grep'

# show what ports are open locally
alias local_ports='sudo nmap -sT -O localhost'

# Postgresql
alias pggo='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# Redis
alias rgo='redis-server /usr/local/etc/redis.conf'

# thesaurus
alias thes='ruby ~/dotfiles/thesaurus.rb'

solarize()
{
  highlight -O rtf --style=solarized-dark --line-numbers "$1" | pbcopy
}

# kubernetes
alias k=kubectl

# Homebrew
alias bri='brew install'
alias brf='brew info'
alias brs='brew search'

# Claude Code
alias ccdanger='claude --dangerously-skip-permissions'
alias cc=claude

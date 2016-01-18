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

alias v='vim'
alias gv='mvim'
alias sv='sudo vim'
alias apache='sudo /etc/init.d/apache2'

# Rails
alias b='bundle exec'
alias bi='bundle install'
alias bake='noglob bin/rake'
alias server='bin/rails server'
alias server-thin='bin/rails server thin'
alias console='bin/rails console'
alias production-console='bin/rails console production'
alias generate='bin/rails generate'
alias test='bundle exec ruby -Itest'
alias unit-tests='bin/rake test:units'
alias functional-tests='bin/rake test:functionals'
alias integration-tests='bin/rake test:integration'
alias tests='bin/rake test'
alias specs='bin/rake spec && bundle exec cucumber -f progress'
alias migrate="bin/rake db:migrate db:test:prepare"

alias cuke='b cucumber'
alias testntell='b rake test:all && b rake cucumber && terminal-notifier -message "Tests are finished, mother fucker! Nice fucking job! Buy yourself a goddamned latte." -title "Tests"'

alias zues='zeus'

# Ruby
# zsh globbing interferes with passing arguments using square brackets
# Ex. rake new_post[some blog post title]
alias rake='noglob rake'

# RVM
alias rvmp='rvm-prompt'

# Heroku staging
alias heroku-console='heroku run console'
alias heroku-ps='watch heroku ps'
alias heroku-releases='heroku releases'
alias heroku-tail='heroku logs --tail'

# Heroku databases
alias db-pull='heroku db:pull'
alias db-backup='heroku pgbackups:capture'


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

# Mongo
alias mongogo='mongod run --config /usr/local/etc/mongod.conf'

alias gsd='sudo get-shit-done'

# thesaurus
alias thes='ruby ~/dotfiles/thesaurus.rb'

solarize()
{
  highlight -O rtf --style=solarized-dark --line-numbers "$1" | pbcopy
}

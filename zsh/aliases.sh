alias ll='ls -l'
alias la='ls -A'
alias l='ls -G'
alias lla='ls -la'

alias t='tree -L 1 -C -h'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../..'
alias grep='grep --color'

alias mkdir='mkdir -p'

# Ubuntu/Debian package management
# alias as="apt-cache search"
# alias ash="apt-cache show"
# alias ai="sudo apt-get install"
# alias ar="sudo apt-get remove"
# alias aud="sudo apt-get update"
# alias aug="sudo apt-get upgrade"
# alias auall="sudo apt-get update && sudo apt-get upgrade"
# alias installed="sudo dpkg --get-selections | grep"

alias v='vim'
alias gv='mvim'
alias sv='sudo vim'
alias apache='sudo /etc/init.d/apache2'

# RubyGems
alias gemu="sudo gem update"
alias gemi="sudo gem install --no-ri --no-rdoc"
alias gemun="sudo gem uninstall"
alias gemus="sudo gem update --system"
# install or search for a similarly named gem
function geminst() {
  sudo gem install $1 || gem search $1 -r ;
}

# Rails 3
alias b='bundle exec'
alias bi='bundle install'
alias bake='noglob bundle exec rake'
alias server='bundle exec rails server'
alias server-thin='bundle exec rails server thin'
alias console='bundle exec rails console'
alias production-console='bundle exec rails console production'
alias generate='bundle exec rails generate'
alias test='bundle exec ruby -Itest'
alias unit-tests='bundle exec rake test:units'
alias functional-tests='bundle exec rake test:functionals'
alias integration-tests='bundle exec rake test:integration'
alias tests='bundle exec rake test'
alias specs='bundle exec rake spec && bundle exec cucumber -f progress'
alias migrate="bundle exec rake db:migrate db:test:prepare"

alias cuke='b cucumber'
alias testntell='b rake spec && b rake cucumber && growlnotify -s -m "Scenarios and specs are finished, mother fucker! Nice fucking job! Buy yourself a goddamned latte."'
alias fuck='testntell'

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
alias apache_process='ps -ef | grep apache | grep -v grep | wc -l'
alias topcpu='ps aux | sort -n +2 | tail -10'  # top 10 cpu processes
alias topmem='ps aux | sort -n +3 | tail -10'  # top 10 memory processes
alias psg='ps aux | grep'

# systat - http://perso.orange.fr/sebastien.godard/index.html
alias sar2='sar -u 2 0'
alias sar5='sar -u 5 0'

# show what ports are open locally
alias local_ports='sudo nmap -sT -O localhost'

# GNU Screen
alias scrails='screen -c ~/.rails.screen'
alias s='screen -X screen'

# Postgresql
alias pggo='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# Redis
alias rgo='redis-server /usr/local/etc/redis.conf'

# Mongo
alias mongogo='mongod run --config /usr/local/etc/mongod.conf'

# probably not a best practice, but works for a specific project
alias deliver='gpp && cap staging deploy'

alias gsd='sudo get-shit-done'

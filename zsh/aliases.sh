alias ll='ls -l'
alias la='ls -A'
alias l='ls -G'
alias lla='ls -la'

alias t='tree -L 1 -C -h'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../..'
alias grep='grep --color'

# Ubuntu/Debian package management
# alias as="apt-cache search"
# alias ash="apt-cache show"
# alias ai="sudo apt-get install"
# alias ar="sudo apt-get remove"
# alias aud="sudo apt-get update"
# alias aug="sudo apt-get upgrade"
# alias auall="sudo apt-get update && sudo apt-get upgrade"
# alias installed="sudo dpkg --get-selections | grep"

# RubyGems
alias gemu="sudo gem update"
alias gemi="sudo gem install --no-ri --no-rdoc"
alias gemun="sudo gem uninstall"
alias gemus="sudo gem update --system"
# install or search for a similarly named gem
function geminst() {
  sudo gem install $1 || gem search $1 -r ;
}

# Rails' script/[command] stuff
alias sst='script/server thin'
alias sgen='script/generate'
alias sc='script/console'

# Rails 3 analogues for the above
alias b='bundle exec'
alias rs='rails server'
alias rst='rs thin'
alias rc='rails console'
alias rcp='rails console production'
alias rg='rails generate'

# Now with bundle exec
alias brs='b rails server'
alias brst='b rs thin'
alias brc='rails console'
alias brcp='rails console production'
alias brg='rails generate'
alias brtu='rake test:units'
alias brtf='rake test:functionals'
alias brti='rake test:integration'
alias brt='rake test'
alias brdm='rake db:migrate'

alias cuke='cucumber'
alias testntell='rake spec && rake cucumber && growlnotify -s -m "Scenarios and specs are finished, mother fucker! Nice fucking job! Buy yourself a goddamned latte."'
alias fuck='testntell'

alias rtu='rake test:units'
alias rtf='rake test:functionals'
alias rt='rake test'
alias rpd='rake production deploy'
alias rdm='rake db:migrate'

# autotest
alias atf='autotest -f'

alias v='vim'
alias gv='mvim'
alias sv='sudo vim'
alias apache='sudo /etc/init.d/apache2'

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

# my personal default options when using pwsafe
alias pwsf='sudo pwsafe -upE'

# GNU Screen
alias scrails='screen -c ~/.rails.screen'
alias s='screen -X screen'

# Postgresql
alias pggo='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# cURL
# alias jcurl='curl -i -H "Content-Type: application/json" -X POST -d'

function jcurl() {
  curl -i -H "Content-Type: application/json" -X POST -d $1 $2
}

function find_grep() {
  find $1 -name $2 | xargs egrep -nC3 $3 | less
}

alias mkdir='mkdir -p'

function touch {
  dir=`expr "$1" : '\(.*\/\)'`
  if [ $dir ]
    then
mkdir -p $dir
  fi
  /usr/bin/touch $1
}

# probably not a best practice, but works for a specific project
alias deliver='gpp && cap staging deploy'

alias gsd='sudo get-shit-done'

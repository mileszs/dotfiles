# bash aliases
# included by .bashrc

# the motley crew of ls stuffs
#
# Better LS_COLORS
eval $(dircolors)
# Add color to less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias dir='ls --color=auto --format=vertical'
  alias vdir='ls --color=auto --format=long'
fi
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -la'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../..'
alias grep='grep --color'

# Ubuntu/Debian package management
alias as="apt-cache search"
alias ash="apt-cache show"
alias ai="sudo apt-get install"
alias ar="sudo apt-get remove"
alias aud="sudo apt-get update"
alias aug="sudo apt-get upgrade"
alias auall="sudo apt-get update && sudo apt-get upgrade"
alias installed="sudo dpkg --get-selections | grep"

# RubyGems
alias gemu="sudo gem update"
alias gemi="sudo gem install"
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

# Rails: migrate and clone to test, 'cause autotest needs it NOW
alias do-db='rake db:auto:migrate && rake db:test:clone'

alias rtu='rake test:units'
alias rtf='rake test:functionals'
alias rt='rake test'

# autotest
alias atf='autotest -f'

alias svim='sudo vim'
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
alias psg='ps auxf | grep'

# systat - http://perso.orange.fr/sebastien.godard/index.html
alias sar2='sar -u 2 0'
alias sar5='sar -u 5 0'

# show what ports are open locally
alias local_ports='sudo nmap -sT -O localhost'

# my personal default options when using pwsafe
alias pwsf='sudo pwsafe -upE'

# GNU Screen
alias scrails='screen -c ~/.rails.screen'
alias screrb='screen -c ~/.merb.screen'
alias s='screen -X screen'

# Git
alias grma='git ls-files --deleted | xargs git rm'


function find_grep() {
  find $1 -name $2 | xargs egrep -nC3 $3 | less
}

# probably not a best practice, but works for a specific project
alias deliver='git push && cap deploy'

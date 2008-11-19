# bash aliases
# included by .bashrc

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -la'
alias grep='grep --color'

# Ubuntu/Debian package management
alias apts="apt-cache search"
alias aptsh="apt-cache show"
alias aptinst="sudo apt-get install"
alias aptr="sudo apt-get remove"
alias aptupd="sudo apt-get update"
alias aptupg="sudo apt-get upgrade"
alias aptupall="sudo apt-get update && sudo apt-get upgrade"

# RubyGems
alias gemu="sudo gem update"
alias gemi="sudo gem install"
alias gemun="sudo gem uninstall"
alias gemus="sudo gem update --system"

alias svim='sudo vim'
alias apache='sudo /etc/init.d/apache2'

# show sorted directory sizes for all directories
alias dua='du -ch --max-depth=1'
alias duv='du -sch ./*'
alias duh='du -sch ./.*'

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
alias pwsf='sudo pwsafe -upE -f'

# start screen with the rails config file
alias scrails='screen -c ~/.rails.screen'

# start screen with the merb config file
alias screrb='screen -c ~/.merb.screen'

function find_grep() {
  find $1 -name $2 | xargs egrep -nC3 $3 | less
}

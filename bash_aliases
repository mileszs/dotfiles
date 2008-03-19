# bash aliases
# included by .bashrc

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Ubuntu/Debian package management
alias apts="apt-cache search"
alias aptsh="apt-cache show"
alias aptinst="sudo apt-get install"
alias aptr="sudo apt-get remove"
alias aptupd="sudo apt-get update"
alias aptupg="sudo apt-get upgrade"
alias aptup-all="sudo apt-get update && sudo apt-get upgrade"

alias svim='sudo vim'
alias apache='sudo /etc/init.d/apache2'
# show sorted directory sizes for all directories
alias dua='du -ch --max-depth=1'
alias duv='du -sch ./*'
alias duh='du -sch ./.*'
# view processes -- requires argument
alias pg='sudo ps auxf | grep'
# show what ports are open locally
alias local_ports='sudo nmap -sT -O localhost'

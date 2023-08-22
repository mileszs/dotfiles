# functions -- sourced by zshrc

# cURL
# alias jcurl='curl -i -H "Content-Type: application/json" -X POST -d'

function jcurl() {
  curl -i -H "Content-Type: application/json" -X POST -d $1 $2
}

function find_grep() {
  find $1 -name $2 | xargs egrep -nC3 $3 | less
}

function touch {
  dir=`expr "$1" : '\(.*\/\)'`
  if [ $dir ]
    then
mkdir -p $dir
  fi
  /usr/bin/touch $1
}

# File & String Related Functions

# Find a file with the string $1 in the name
function ff() { find . -name '*'$1'*' ; }

# Find a file with the string $1 in the name and exec $2 on it
function fe() { find . -name '*'$1'*' -exec $2 {} \; ; }

# Find a file ending in $2 and search for string $1 in it
function fstr() # find a string in a set of files
{
  if [ $# -ne 2 ]; then
    echo "Usage: fstr \"pattern\" [files] "
    return;
  fi
  SMSO=$(tput smso)
  RMSO=$(tput rmso)
  find . -type f -name "*${2}" -print | xargs grep -sin "$1" | \
  sed "s/$1/$SMSO$1$RMSO/gI"
}

# Move filenames to lowercase
function lowercase()
{
  for file ; do
    filename=${file##*/}
    case "$filename" in
      */*) dirname==${file%/*} ;;
      *) dirname=.;;
    esac
    nf=$(echo $filename | tr A-Z a-z)
    newname="${dirname}/${nf}"
    if [ "$nf" != "$filename" ]; then
      mv "$file" "$newname"
    else
      echo "lowercase: $file not changed."
    fi
  done
}

# Swap spaces for underscores in file names
function nospace()
{
  mv "$1" "`echo $1 | tr ' ' '_'`"
}


# Swap file $1 with $2
function swap() {
local TMPFILE=tmp.$$
mv $1 $TMPFILE
mv $2 $1
mv $TMPFILE $2
}

# Process/System related functions

# Helper function for pp
function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

# Show all processes owned by me
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

# get IP address
function myip()
{
  IP=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`;
  echo $IP
}

# get current host related info
function ii()
{
  echo -e "\nYou are logged on ${BLUE}$HOSTNAME${NC}"
  echo -e "\nAdditionnal information:$NC " ; uname -a
  echo -e "\n${RED}Users logged on:$NC " ; w -h
  echo -e "\n${RED}Current date :$NC " ; date
  echo -e "\n${RED}Machine stats :$NC " ; uptime
  echo -e "\n${RED}Memory stats :$NC " ; free
  myip > /dev/null 2>&1
  echo -e "\n${RED}Local IP Address :$NC" ; echo ${IP:-"Not connected"}
  echo
}

function untar()
{
  FT=$(file -b $1 | awk '{print $1}')
  if [ "$FT" = "bzip2" ]; then
    tar xvjf "$1"
  elif [ "$FT" = "gzip" ]; then
    tar xvzf "$1"
  fi
}

function hack()
{
  CURRENT=`git branch | grep '\*' | awk '{print $2}'`
  git checkout main
  git pull origin main
  git checkout ${CURRENT}
  git rebase main
}

function ship()
{
  CURRENT=`git branch | grep '\*' | awk '{print $2}'`
  git checkout main
  git merge ${CURRENT}
  git push origin main
  git checkout ${CURRENT}
}

function rserv()
{
  rport=3000
  port_taken=`lsof -i tcp:${rport}`
  while [ $port_taken ]
  do
    echo "Port ${rport} taken..."
    (( rport++ ))
    port_taken=`lsof -i tcp:${rport}`
  done
  echo "Port ${rport} free, starting server..."
  rails s -p ${rport}
}

function pod_ssh {
  if [[ $1 == "production" ]]
  then
    kubectl config use-context production-1-27
  elif [[ $1 == "staging" ]]
  then
    kubectl config use-context staging-1-27
  else
    kubectl config use-context testing-1-27
  fi

  POD_ID=$(kubectl get pods --field-selector=status.phase=Running | grep -m1 -E "$1-.{9,10}-" | awk '{print $1}')
  echo "Found pod: '$POD_ID'"
  echo "..."
  kubectl exec -it $POD_ID -- /bin/bash
}

function bender_update {
  if [[ $1 == "production" ]]
  then
    aws eks update-kubeconfig --name production-1-27 --alias production-1-27
  elif [[ $1 == "staging" ]]
  then
    aws eks update-kubeconfig --name staging-1-27 --alias staging-1-27
  else
    aws eks update-kubeconfig --name testing-1-27 --alias testing-1-27
  fi

}

function bender_login {
  aws sso login
  bender_update($1)
  pod_ssh($1)
}

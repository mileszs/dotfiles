# functions -- sourced by bashrc

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

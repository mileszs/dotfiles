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
  # :h is zsh's dirname; it yields "." for a bare filename, which needs no mkdir.
  local dir=${1:h}
  [[ -n $dir && $dir != "." && $dir != $1 ]] && mkdir -p $dir
  # `command` rather than /usr/bin/touch, so the GNU coreutils build wins on
  # macOS when it's first on PATH.
  command touch "$@"
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
#
# The old 'inet addr:' format came from net-tools ifconfig and no longer shows
# up on either platform: modern Linux uses ip(8), and macOS ifconfig prints
# a plain 'inet '. Handle both, skipping loopback.
function myip()
{
  if (( $+commands[ip] )); then
    IP=$(ip -4 -oneline addr show scope global | awk '{split($4, a, "/"); print a[1]}')
  else
    IP=$(ifconfig | awk '/inet / && $2 != "127.0.0.1" { print $2 }')
  fi
  echo $IP
}

# get current host related info
function ii()
{
  echo -e "\nYou are logged on ${BLUE}$HOST${NC}"
  echo -e "\nAdditionnal information:$NC " ; uname -a
  echo -e "\n${RED}Users logged on:$NC " ; w -h
  echo -e "\n${RED}Current date :$NC " ; date
  echo -e "\n${RED}Machine stats :$NC " ; uptime
  echo -e "\n${RED}Memory stats :$NC "
  # free(1) is Linux-only; vm_stat is the macOS equivalent.
  if (( $+commands[free] )); then
    free -h
  else
    vm_stat
  fi
  echo -e "\n${RED}Local IP Address :$NC" ; myip
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
  bender_update "$1"
  pod_ssh "$1"
}

# Watch a GitHub PR and notify when checks complete
function pr_watch {
  PR=${1:-$(gh pr view --json number -q .number 2>/dev/null)}

  if [ -z "$PR" ]; then
    echo "Usage: pr_watch [PR number]"
    echo "Or run from a branch with an open PR"
    return 1
  fi

  echo -n "Watching PR #$PR"

  while true; do
    STATUS=$(gh pr checks "$PR" --json state -q '.[].state' 2>/dev/null | sort -u)

    if echo "$STATUS" | grep -q "PENDING"; then
      echo -n "."
      sleep 60
    else
      echo ""
      # notify (in ~/.bin) uses terminal-notifier, notify-send, or the bell.
      if echo "$STATUS" | grep -qv "SUCCESS"; then
        notify "PR #$PR" "Some checks failed"
      else
        notify "PR #$PR" "All checks passed!"
      fi
      break
    fi
  done
}

# goto [-f] <host> [command...]
#
# ssh, with the terminfo dance handled for you. Ghostty ships its own terminfo
# entry, so a plain `ssh beorn` forwards TERM=xterm-ghostty to a box whose
# ncurses has never heard of it and curses programs there draw garbage.
# ~/.bin/ssh-terminfo fixes a host for good, but only if you remember to run it.
# This runs it the first time you visit a host, then gets out of the way.
#
# The marker is per host *and* per TERM, so switching terminal emulators
# re-syncs rather than silently reusing a stale entry. `goto -f host` recopies.
function goto {
  local force=0
  if [[ $1 == -f || $1 == --force ]]; then
    force=1
    shift
  fi

  local host=$1
  if [[ -z $host ]]; then
    print -u2 "usage: goto [-f] <host> [command...]"
    return 64
  fi
  shift

  # Entries every ncurses already carries need no copying. tmux-256color is
  # deliberately not in this list: it postdates ncurses 6 and is exactly the
  # kind of entry an older server is missing.
  case ${TERM:-} in
    ''|xterm|xterm-256color|screen|screen-256color|vt100|dumb)
      ssh "$host" "$@"
      return
      ;;
  esac

  local cache=${XDG_CACHE_HOME:-$HOME/.cache}/ssh-terminfo
  local marker=$cache/$host.$TERM

  if (( force )) || [[ ! -f $marker ]]; then
    if ssh-terminfo "$host"; then
      mkdir -p $cache && command touch $marker
    else
      # No tic on the far end, or nowhere to write it. Connecting with the real
      # TERM would draw garbage, so claim one the remote is sure to know.
      print -u2 "goto: no terminfo on $host — falling back to TERM=xterm-256color"
      TERM=xterm-256color ssh "$host" "$@"
      return
    fi
  fi

  ssh "$host" "$@"
}

# Hostname completion, straight from ssh's own completer.
(( $+functions[compdef] )) && compdef goto=ssh

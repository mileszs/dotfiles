# bash aliases for Git
# included by .bashrc
# I stole all of this shit from jqr/Elijah Miller

alias g='git'

alias gi='git init; printf "*.swp\n.DS_Store\nThumbs.db\n" >> .gitignore'

# http://www.jukie.net/~bart/blog/pimping-out-git-log
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%an %cr)%Creset' --abbrev-commit --date=relative"
alias glp='gl -p'
alias gls='git shortlog -s --'

alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdh='git diff HEAD'

alias ga='git add'
alias gai='git add -i'
alias gc='git commit -v'
alias gca='gc -a'
alias gm='git merge'

alias gp='git pull'
alias gpa='git pull --all'
alias gpp='gp && git push origin `current_git_branch`'
alias gprp='gp && rake && gpp'
alias gri='git rebase -i origin/master^'
alias grc='git rebase --continue'

alias gst='git stash'
alias g{='gst'
alias gsa='gst apply'
alias g}='gsa'
alias gps='gst && gp && gsa'
alias g{p}='gps'

alias gfp='git format-patch'
alias gf1='git format-patch -1'

alias gco='git checkout'
# complete -o default -o nospace -F _git_branch gco

alias gb='git branch'
# complete -o default -o nospace -F _git_branch gb

alias gtrack='git branch --track'

alias gcb='git checkout -b'
# complete -o default -o nospace -F _git_branch gcb

alias grma='git ls-files --deleted | xargs git rm'
alias glu='git ls-files --other --exclude-standard'
alias glud='git ls-files --other --exclude-standard | xargs rm'
alias glua='git ls-files --other --exclude-standard | xargs git add'

alias gw='git whatchanged'

alias gnext='git checkout $(git rev-list HEAD..master | tail -n 1)'
alias gprev='git checkout HEAD~1'

# Heroku
alias pushroku='git push heroku master'

function gtb() {
  git checkout -b $1 --track origin/$1
}

function ggc() {
  set -- `du -ks`
  before=$1
  git reflog expire --expire=1.minute refs/heads/master && git fsck --unreachable && git prune && git gc
  set -- `du -ks`
  after=$1
  echo "Cleaned up $((before-after)) kb."
}

function grb() {
  git push origin `current_git_branch`:refs/heads/$1
  git fetch origin &&
  git checkout -b $1 --track origin/$1
}

function current_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function gnuke() {
  if [ ! -d .git ]; then
    echo "Error: must run this script from the root of a git repository"
    exit 1
  fi

  # remove all paths passed as arguments from the history of the repo
  files=$@
  git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch $files" HEAD

  # remove the temporary history git-filter-branch otherwise leaves behind for a long time
  rm -rf .git/refs/original/ && git reflog expire --all &&  git gc --aggressive --prune
}

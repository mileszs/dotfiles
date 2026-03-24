# aliases for Git
# included by .bashrc/.zshrc
# I stole most of this shit from jqr/Elijah Miller

alias g='git'

# http://www.jukie.net/~bart/blog/pimping-out-git-log
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%an %cr)%Creset' --abbrev-commit --date=relative"
alias glp='gl -p'
# alias gls='git shortlog -s --'
alias merges='git log --merges --first-parent master --pretty=format:"%h %<(10,trunc)%aN %C(white)%<(15)%ar%Creset %C(red bold)%<(15)%D%Creset %s"'

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
alias gpp='gp && git push origin `current_git_branch`'
alias push='git push -u origin `current_git_branch`'
alias gprp='gp && rake && gpp'
alias grc='git rebase --continue'

alias gst='git stash'
alias gsa='gst apply'
alias gps='gst && gp && gsa'

alias gco='git checkout'

alias gb='git branch'
alias gbl='git branch --sort=-committerdate'

alias gtrack='git branch --track'
alias gtracksame='git branch --set-upstream-to=origin/`current_git_branch` `current_git_branch`'

alias gcb='git checkout -b'

alias grma='git ls-files --deleted | xargs git rm'
alias glu='git ls-files --other --exclude-standard'
alias glud='git ls-files --other --exclude-standard | xargs rm'
alias glua='git ls-files --other --exclude-standard | xargs git add'

alias gw='git whatchanged'

alias gcl='git clone'
alias grs='git reset'
alias gsh='git show'
alias gpr='gh pr'

alias gnext='git checkout $(git rev-list HEAD..master | tail -n 1)'
alias gprev='git checkout HEAD~1'

alias refetch='git fetch && git reset --hard FETCH_HEAD'

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

# Environment variables

# Don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# set the default editor
 export EDITOR=vim
# NOTE!  This is set to /usr/local/bin/vim due to an issue
# with Ubuntu 8.04's version of vim and rails.vim -- I installed
# from source a newer version of vim in /usr/local/bin/vim.  Typically,
# you'll just want the line noted above.
#export EDITOR=/usr/local/bin/vim

# For ODBC stuff
export ODBCINI=/etc/
export ODBCSYSINI=/etc/
export FREETDSCONF=/etc/freetds/freetds.conf

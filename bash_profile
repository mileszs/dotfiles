# ~/.bash_profile: executed by bash(1) for login shells.

# include .bashrc
source ~/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# added by Anaconda3 2019.03 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/mileszs/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/mileszs/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/mileszs/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/mileszs/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

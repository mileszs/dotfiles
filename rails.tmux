#!/bin/bash

SESSION=$1

if [[ ! -z "$TMUX" ]] || [[ ! -z "$TMUX_PANE" ]]; then
  echo "Already inside a tmux session, do not know what to do"
  exit 1
fi

tmux has-session -t $SESSION 2>/dev/null
if [ "$?" -eq 0 ] ; then
  tmux attach -t $SESSION
  exit 0
fi

tmux new-session -d -s $SESSION
tmux split-window  -t $SESSION:1.0 -v
tmux split-window  -t $SESSION:1.1 -h
tmux new-window -t $SESSION:2
tmux split-window -t $SESSION:2.0 -h
tmux select-pane -t $SESSION:2.0
tmux send-keys -t $SESSION 'server' Enter

tmux select-window -t $SESSION:1
tmux select-pane -t $SESSION:1.2
tmux send-keys -t $SESSION 'console' Enter

tmux select-window -t $SESSION:1
tmux select-pane -t $SESSION:1.0
tmux send-keys -t $SESSION 'vim Gemfile' Enter

tmux attach-session -t $SESSION

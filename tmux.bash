source ~/df/bash_aliases
source ~/df/bash-preexec.sh

preexec() {
    set +m
    setenv_panename "$(echo $1|cut -f1 -d ' '|sed 's/\s/_/g')" "x" &
}

precmd() {
    # set +m
    bind "set vi-ins-mode-string \"$USER@$HOSTNAME:$(echo $PWD|sed "s+$HOME+~+") \$ \1\e[1;32m\2[I]\1\e[0m\2\""; 
    bind "set vi-cmd-mode-string \"$USER@$HOSTNAME:$(echo $PWD|sed "s+$HOME+~+") \$ \1\e[1;31m\2[N]\1\e[0m\2\"";
    setenv_panename "$PWD" "/"
}
PS1=' '; bind 'set show-mode-in-prompt on'; set -o vi

function setenv_panename() {
    # echo DB: $1 $2
    active_window=$(tmux list-window | grep active | cut -f1 -d:)
    active_pane=$(tmux list-panes | grep active | cut -f1 -d:)
    tmux set-environment PANENAME_S${active_window}_P${active_pane} $1
    # echo DB: tmux set-environment PANENAME_S${active_window}_P${active_pane} $1
    update_window_name $2
}

function update_window_name() {
    # echo DB: update_window_name: 1 2 : $1 $2
    # echo DB: 1: $1
    active_window=$(tmux list-window|grep active|cut -f1 -d:)
    active_pane=$(tmux list-panes | grep active | cut -f1 -d:)
    pane_count=$(tmux list-panes | wc -l | sed -e 's/ //g')
    # import PANENAME variables
    eval $(tmux show-environment|grep PANENAME)
    for (( i=1; i <= $pane_count; i++ )); do
        eval pane_name="\$PANENAME_S${active_window}_P$i"
        if echo $pane_name | grep -q '^/'; then
            symbol="/"
            pane_name=$(echo $pane_name |sed "s+$HOME+~+"|sed "s+.*/++")
            if [ $pane_name == "~" ]; then
                symbol=""
            fi
        else
            symbol=""
        fi
        if [ $i -eq 1 ]; then
            window_name="$pane_name$symbol"
        else
            window_name="$window_name $pane_name$symbol"
        fi
    done
    # window_name="${window_name}"
    tmux rename-window "$window_name"
    # echo "$window_name"
}

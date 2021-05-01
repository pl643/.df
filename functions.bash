# These bash functions are ment to be called as argument 1
# ie: bash "$df"/functions.bash toggleALT

# mapped as alt-enter from tmux
function toggleALT() {
    ALTSTAT=$(tmux showenv TMUX_ALT_HJKL|cut -f2 -d=)
    tmux setenv TMUX_ALT_HJKL $((ALTSTAT ^= 1))
    if [ $ALTSTAT -eq 0 ]; then # currently off run on script
       tmux bind-key -n M-h select-pane -L \; bind-key -n  M-j select-pane -D \; bind-key -n M-k select-pane -U \; \
            bind-key -n  M-l select-pane -R \; set -g prefix C-a \; bind-key -n M-o next-window \; bind-key -n  M-i previous-window \; \
        set-option -g status-right "ALT #[bg=colour237,fg=colour239 nobold, nounderscore, noitalics]#[bg=colour239,fg=colour246] %Y-%m-%d  %H:%M #[bg=colour239,fg=colour248,nobold,noitalics,nounderscore]#[bg=colour248,fg=colour237] #h "
    else 
        tmux unbind -n M-h \; unbind -n M-j \; unbind -n M-k \; unbind -n M-l \; set -g prefix C-b \; unbind-key -n M-o \; unbind-key -n M-i \; \
        set-option -g status-right "#[bg=colour237,fg=colour239 nobold, nounderscore, noitalics]#[bg=colour239,fg=colour246] %Y-%m-%d  %H:%M #[bg=colour239,fg=colour248,nobold,noitalics,nounderscore]#[bg=colour248,fg=colour237] #h "
    fi
}

function shell_key_mapping() {
    if tmux show-env | grep '^SHELL=fish'; then
        tmux bind-key  s split-window -h '$df/bin/fish -C "source $df/fishrc" -i'
        tmux bind-key  S split-window -v '$df/bin/fish -C "source $df/fishrc" -i'
    else
        tmux bind-key  s split-window -h '$df/bin/bash --rcfile "$df"/bashrc'
        tmux bind-key  S split-window -v '$df/bin/bash --rcfile "$df"/bashrc'
    fi
}

[ ! -z $1 ] && $1

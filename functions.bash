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

function set_fishshell_location() {
	if grep -q CentOS-7 /etc/os-release; then
	   export FISH=$df/bin/centos7/fish
    fi
	if grep -q CentOS-8 /etc/os-release; then
	   export FISH=$df/bin/centos8/fish
    fi
}

function shell_key_mapping() {
    set_fishshell_location
    if tmux show-env | grep -q '^SHELL=fish'; then
        tmux bind-key  s split-window -h "$FISH -C \"source $df/fishrc\" -i"
        tmux bind-key  S split-window -v "$FISH -C \"source $df/fishrc\" -i"
    else
        tmux bind-key  s split-window -h 'bash --rcfile "$df"/bashrc'
        tmux bind-key  S split-window -v 'bash --rcfile "$df"/bashrc'
    fi
}

function run_nvim() {
    # set -x
    if [ ! -d "$df/nvim-linux64" ] ; then
        wget -O "$df/nvim-linux64.tar.gz" https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
        tar xfz "$df/nvim-linux64.tar.gz" -C "$df"
        rm -f "$df/nvim-linux64.tar.gz"
        "$df/nvim-linux64/bin/nvim" -u "$df/vimrc" -c PlugInstall -c q -c :q
    fi
    if [ -f "$df/vimrc" ] && [ -f "$df/nvim-linux64/bin/nvim" ]; then
        export EDITOR="$df/nvim-linux64/bin/nvim -u $df/vimrc"
    fi
    if [ $# -eq 0 ] ; then
        $EDITOR
    else
        $EDITOR $@
    fi
    # set +x
    # echo EDITOR: $EDITOR
    # export VISUAL=$EDITOR
}

[ ! -z $1 ] && $1

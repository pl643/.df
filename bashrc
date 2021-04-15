[ -f $df/fetch/fetch ] && $df/fetch/fetch
history -c
set +o history
HISTCONTROL=ignorespace
export df=$DF/.df
[ -z $USER ] && export USER=$(whoami)
export PATH=$df/bin:$PATH
export HISTFILE="$df/HISTFILE"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

reset_readline_prompt_mode_strings () {
    bind "set vi-ins-mode-string \"$USER@$HOSTNAME:$(echo $PWD|sed "s+$HOME+~+") \$ \1\e[1;32m\2[I]\1\e[0m\2\""
    bind "set vi-cmd-mode-string \"$USER@$HOSTNAME:$(echo $PWD|sed "s+$HOME+~+") \$ \1\e[1;31m\2[N]\1\e[0m\2\""
}

bind 'set show-mode-in-prompt on'
bind -m vi-insert 'Control-l: clear-screen'
bind -m vi-insert "\C-a.":beginning-of-line
bind -m vi-insert "\C-e.":end-of-line
bind -m vi-insert "\C-w.":backward-kill-word
bind 'TAB':menu-complete
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"

set -o vi
shopt -s autocd histappend

calc() {
    bc -l <<< "$@"
}

e() {
    echo eval \$$@
    eval \$$@
}

ft() {  # find text
    grep -iIHrn --color=always "$1" . | less -R -r -X   # less -X don't clear after exit
}

duplicatefind ()
{
    find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate
}

generateqr ()
{
    printf "$@" | curl -F-=\<- qrenco.de
}

lazygit() {
   local message="$1"
   local push_branch="${2:-$(git rev-parse --abbrev-ref HEAD)}"
   echo "Commit Message: $message"
   echo "Push Branch: ${push_branch}"
   git add --all
   git commit -m "$message"
   git push origin "$push_branch"
}

vn() { # start vim with file:33 to jump to line 33
    file=$(echo $1|cut -f1 -d:)
    line=$(echo $1|cut -f2 -d:)
    $EDITOR $file -c :$line
}

installfzf() {
    set -x
    [ ! -f "$df/bin/fzf" ] && \
        wget -O $df/fzf.tgz https://github.com/junegunn/fzf/releases/download/0.26.0/fzf-0.26.0-linux_amd64.tar.gz && \
        tar xfz $df/fzf.tgz -C $df/bin && rm -f $df/fzf.tgz
}

run_nvim() {
    # set -x
    if [ ! -d "$df/nvim-linux64" ]; then 
        wget -O $df/nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
        tar xfz $df/nvim-linux64.tar.gz -C $df
        rm -f $df/nvim-linux64.tar.gz
        $df/nvim-linux64/bin/nvim -u $df/vimrc -c PlugInstall -c q -c :q
    fi
    if [ -f $df/vimrc ] && [ -f $df/nvim-linux64/bin/nvim ]; then
        export EDITOR="$df/nvim-linux64/bin/nvim -u $df/vimrc"
    fi
    if [ $# -ne 0 ] ; then
        $EDITOR
    else
        $EDITOR $@
    fi
    # set +x
    # echo EDITOR: $EDITOR
    # export VISUAL=$EDITOR
}

tnew () { 
    if [ $# = 0 ]; then
        printf "Usage: tnew sesion-name, strats new tmux\n" 
        return
    fi
    if [ -f $df/tmux.bash ]; then
        tmux new -d -s "$1" bash --rcfile $df/tmux.bash
        tmux switch -t "$1"
    fi
}

# alias dX to $dirhistoryfile sorted by usage
bash_history() {  # cd alias
    top=30
    echo Creating alias in $HISTFILE for top $top usage..
    # set -x
    history -a
    i=1
    while read -r line; do
        length=$(echo -n "$line"|wc -c) 
        if [ $length -gt 5 ] && [ $length -lt 80 ] ; then
            printf "h%2d $line\n" $i
            eval alias h$i=\"$line\"
            let i=i+1
        fi
    done < <(sort $HISTFILE|uniq -c|sort -r|cut -b 9-)
    return
}

# alias dX to $dirhistoryfile sorted by usage
dir_history() {  # cd alias
    if [ $# -ne 0 ] ; then
        eval \$d$@
        return
    fi
    i=1
    while read -r line; do
        line=$(echo $line | sed 's/ /\\ /g')
        # eval alias d$i=\"$line\"
        eval alias $i='$line'
        printf "%3d $line\n" $i
        let i=i+1
    done < <(sort $dirhistoryfile |grep -v -e '^/$' -e "$HOME"|uniq -c|sort -r|cut -b 9-)
    return
    # echo DB: dp: $#
    # dirlist=$(sort $dirhistoryfile |grep -v -e '^/$' -e "$HOME"|uniq -c|sort -r|cut -b 9-)
    i=1
    for e in $dirlist; do 
        # echo DB: \"$e\"; 
        # set -x
        eval alias d$i=\"$e\"
        eval alias $i=\"$e\"
        # set +x
        echo $i $e
        let i=i+1
    done
    # set -x
    # echo UU 41
    # eval alias uu='echo 41'
    # set -x
}

function cdf() {
    # echo DB: $@
    if [ $# -eq 0 ]; then
        echo Usage: cdf '/full/path/to/a/file'
        return
    fi
    dir=$(echo $@|sed 's,/*[^/]\+/*$,,')
    echo cd \"$dir\"
    if [ -d "$dir" ]; then
        eval builtin cd \"$dir\"
    else
        echo \"$dir\" does not exist
    fi
}

clean_up() {
    ARG=$?
    [ -f "$df/.keep" ] && return
    read -p "Keep $DF? " -rsn1 input
    if [ "$input" = "y" ]; then
        touch "$df/.keep"
        exit 0
    fi
    echo "Cleaning up.."
    set -x
    rm -rf "$DF"
    exit $ARG
} 
trap clean_up EXIT

dirhistoryfile="$df/.dirhistoryfile"
[ -d "$df" ] && touch $dirhistoryfile
cd() {
    builtin cd "$@" && (/bin/ls -lhF --color=always | less)
    [ $# -eq 0 ] && return
    cdcmpstr=$(echo $@ | sed 's/--//')
    [ "$cdcmpstr" = "-" ] && return
    [ "$cdcmpstr" = ".." ] && return
    # set -x
    pwd >> $dirhistoryfile
    # set +x
}

tmux_prefix_set() {
    [ $# -eq 0 ] && echo "Usage: tmux_prefix_set X - X = ctrl-X" && return
    set -x
    tmux set -g prefix C-$@
    set +x
}

tmux_toggle_alt_keys() {
    set -x
    # tmux list-keys|grep M-j|grep root
    # if tmux list-keys|grep M-j|grep -q root; then
    # if tmux list-keys|grep M-j|grep -v M-l; then
    tmux list-keys|grep M-j|grep -v M-l
    return
    if tmux list-keys|grep M-j|grep -v M-l; then
        echo bind: yes
        tmux unbind -n M-h \; unbind -n M-j \; unbind -n M-k \; unbind -n M-l
    else
        echo bind: no
        tmux bind-key -n M-h select-pane -L \; bind-key -n  M-j select-pane -D \; bind-key -n M-k select-pane -U \; bind-key -n  M-l select-pane -R
    fi
    set +x
}

# dirbookmarkfile="$df/.dirbookmark"
# alias sdb="echo source $dirbookmarkfile; source $dirbookmarkfile"
# db() { # bookmark current directory as alias for quick access
#     if [ $# -eq 0 ]; then
#         [ -f $dirbookmarkfile ] && cat $dirbookmarkfile
#         return
#     fi
#     newalias=$1
#     eval alias $newalias=\'echo cd $PWD\; "cd $PWD"\'
#     alias $newalias >> $df/.dirbookmark
# }

ma() { # make new alias for the previous command
    newalias=$1
    prevcmd=$(fc -ln -2|head -1|sed 's/^\s*//')
    eval alias $newalias=\'echo $prevcmd\; "$prevcmd"\'
    eval echo alias $newalias=\'$prevcmd\' >> "$df/aliases"
}

[ -f $df/localrc ]    && echo Note: source $df/localrc && source $df/localrc
[ -f ~/.bashrc ]      && echo Note: source ~/.bashrc && source ~/.bashrc
[ -f ~/.ssh/aliases ] && echo Note: source ~/.ssh/aliases && source ~/.ssh/aliases

# telemetry-parser -g 1 -f /mnt/nvm/NVMeMgr/Packages/Latest/fw_trace_fmt_strings.txt -d /dev/nvme0
alias -- -='set -x'
alias +='set +x'
alias a='alias'
alias A='ansible'
alias b='echo -n "cd -: " ; builtin cd -'
alias c=cd
alias d='echo Directory alias from $dirhistoryfile; dir_history'
alias fd='eval $(sort $dirhistoryfile|uniq|sed -e s/--// -e s/\\s// -e 's/^\/$//'|fzf)'
alias DF='echo cd $df; cd $df'
alias D='docker'
alias ff="git ls-files | grep"
alias G='git'
alias Ga='git add'
alias Gd='git diff'
alias Gh='git push'
alias Gi='git config --global user.email "peter.wt.ly@gmail.com"; git config --global user.name "Peter Ly"'
alias Gl='git pull'
alias Gldf='cd $df; git pull; cd -'
alias Gc='git commit'
alias Gcm='git commit -m'
alias Gs='git status'
alias gg='ga && git commit --fixup=HEAD && GIT_SEQUENCE_EDITOR=: git rebase HEAD~2 -i --autosquash' # https://dev.to/heroku/what-are-your-preferred-bash-aliases-1m8a
alias h='bash_history'
alias hi='history'
alias la='echo ls -alhF; ls -alhF --color=always | less'
alias lg='lazygit'
# alias ll='echo ls -lhF; ls -lhF --color=always | less'
alias le='less'
alias np="echo $USER ALL\=\(ALL\) NOPASSWD:ALL"
alias ni='nix-env -i'
alias nqi='nix-env --query --installed'
alias rdf="[ -d $DF ] && echo rm -rf $DF && rm -rf $DF"
alias s='echo ls -CF; ls -CF --color=always | less'
alias so='source'
alias sa='ls -aCF --color=always | less'
alias sl='ls -aCF --color=always | less'
alias sb='echo source $df/bashrc; source $df/bashrc'
alias S='sudo'
alias SD='sudo $(fc -ln -1)'
alias lt='ls -1tr  --color=always | less'
alias ta='tmux -2 attach'
alias tn='tmux rename-window'
alias tpb='tmux set -g prefix C-b'
alias tpe='tmux set -g prefix C-e'
alias tp='tmux_prefix_set'
alias tsb='echo tmux set-option -g status-position bottom >> $df/localrc; tmux set-option -g status-position bottom'
alias tst='echo tmux set-option -g status-position top    >> $df/localrc; tmux set-option -g status-position top'
alias t='tmux -2 attach || tmux -2 -f $df/tmux.conf new bash --rcfile $df/bashrc'
alias u='echo cd ..; builtin cd ..; ls -CF --color=always | less'
alias v='run_nvim'
alias v.='run_nvim .'
set -o history

[ -f "$df/fzf-key-bindings.bash" ] && source "$df/fzf-key-bindings.bash"
if [ ! -z $TMUX ]; then
    [ -f "$df/tmux.bash" ] && source "$df/tmux.bash"
    tmux source $df/tmux.conf
    tmux source $df/tmux.gruvbox
fi

# bash insert/normal indicator prompt introduced in ver 4.4
BASHVER=${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]}
if (( $(echo "${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]} < 4.4" | bc -l) )); then
    export LESS="-FXRM" # F follow 
    eval echo "'Note: installed bash $BASHVER < 4.4, and will not support [I|N]' prompt"
    export PS1='\u@\h:\w (vi): '
else
    PROMPT_COMMAND=reset_readline_prompt_mode_strings
    export PS1=' ' 
    export LESS="-FXRM" # F follow 
fi

[ -f $df/bashrc ]     && echo Note: last line in $df/bashrc

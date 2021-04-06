history -c
set +o history
HISTCONTROL=ignorespace
df=$DF/.df
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

PROMPT_COMMAND=reset_readline_prompt_mode_strings
# bash insert/normal indicator prompt introduced in ver 4.4
BASHVER=${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]}
if (( $(echo "${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]} >= 4.4" | bc -l) )); then
    PS1=' ' 
    export LESS="-FXRM" # F follow 
else
    PS1='\u@\h:\w (vi): '
    export LESS="-FRM" # F follow 
fi

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

installnvim() {
    set -x
    [ ! -d "$df/nvim-linux64" ] && \
        wget -O $df/nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz && \
        tar xfz $df/nvim-linux64.tar.gz -C $df && rm -f $df/nvim-linux64.tar.gz
    if [ -f $df/vimrc ] && [ -f $df/nvim-linux64/bin/nvim ]; then
        export EDITOR="$df/nvim-linux64/bin/nvim -u $df/vimrc"
        $EDITOR -c PlugInstall -c q -c :q
    else
        export EDITOR="nvim"
    fi
    set +x
    echo EDITOR: $EDITOR
    export VISUAL=$EDITOR
}

tnew () { 
    if [ -f $df/tmux.windows.name.update.sh ]; then
        tmux new -d -s "$1" bash --rcfile $df/tmux.windows.name.update.sh
    else
        tmux new -d -s "$1" bash
    fi
}

# alias dX to $dirhistoryfile sorted by usage
bash_history() {  # cd alias
    top=20
    echo Creating alias in $HISTFILE for top $top usage..
    # set -x
    history -a
    list=$(sort $HISTFILE|uniq -c|sort -r|cut -b 9-)
    i=1
    for e in $list; do 
        [ $i -ge $top ] && return
        length=$(echo -n "$e"|wc -c) 
        # echo DBO: "$e $length"
        if [ $length -gt 5 ] && [ $length -lt 80 ] ; then
            # echo DBI: "$e"
            alias h$i="$e"
            echo "  h$i $e"
            let i=i+1
        fi
    done
    # set +x
}

# alias dX to $dirhistoryfile sorted by usage
dir_history() {  # cd alias
    if [ $# -ne 0 ] ; then
        eval \$d$@
        return
    fi
    echo DB: dp: $#
    dirlist=$(sort $dirhistoryfile |grep -v -e '^/$' -e "$HOME"|uniq -c|sort -r|cut -b 9-)
    i=1
    for e in $dirlist; do 
        # echo "$e"; 
        # set -x
        alias d$i="$e"
        # set +x
        echo $i $e
        let i=i+1
    done
    # set -x
    # echo UU 41
    # eval alias uu='echo 41'
    # set -x
}

clean_up() {
    ARG=$?
    pdf="$(echo $df|sed 's,/*[^/]\+/*$,,')"  # parent of df
    [ -f "$df/.keep" ] && return
    read -p "Keep $pdf? " -rsn1 input
    if [ "$input" = "y" ]; then
        touch "$df/.keep"
        exit 0
    fi
    echo "Cleaning up.."
    set -x
    rm -rf "$pdf"
    exit $ARG
} 
trap clean_up EXIT

dirhistoryfile="$df/.dirhistoryfile"
cd() {
    builtin cd "$@" && (/bin/ls -lhF --color=always | less)
    [ $# -eq 0 ] && return
    cdcmpstr=$(echo $@ | sed 's/--//')
    [ "$cdcmpstr" = "-" ] && return
    [ "$cdcmpstr" = ".." ] && return
    # set -x
    echo $PWD >> $dirhistoryfile
    # set +x
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

# telemetry-parser -g 1 -f /mnt/nvm/NVMeMgr/Packages/Latest/fw_trace_fmt_strings.txt -d /dev/nvme0
alias -- -='cd -'
alias a='alias'
alias A='ansible'
alias b='echo -n "cd -: " ; builtin cd -'
alias c=cd
alias d='echo Directory alias from $dirhistoryfile; dir_history'
alias fd='eval $(sort $dirhistoryfile|uniq|sed -e s/--// -e s/\\s// -e 's/^\/$//'|fzf)'
alias cdf='echo cd $df; cd $df'
alias D='docker'
alias ff="git ls-files | grep"
alias G='git'
alias Ga='git add'
alias Gd='git diff'
alias Gh='git push'
alias Gi='git config --global user.email "peter.wt.ly@gmail.com"; git config --global user.name "Peter Ly"'
alias Gl='git pull'
alias Gc='git commit'
alias Gcm='git commit -m'
alias Gs='git status'
alias gg='ga && git commit --fixup=HEAD && GIT_SEQUENCE_EDITOR=: git rebase HEAD~2 -i --autosquash' # https://dev.to/heroku/what-are-your-preferred-bash-aliases-1m8a
alias h='bash_history'
alias hi='history'
alias iv='installnvim'
alias ifz='installfzf'
alias rdf='rm -rf $df'
alias l='ls -lhF --color=always | less'
alias la='ls -alhF --color=always | less'
alias ll='ls -alhF --color=always | less'
alias le='less'
alias np="echo $USER ALL\=\(ALL\) NOPASSWD:ALL"
alias ni='nix-env -i'
alias nqi='nix-env --query --installed'
alias p='popd'
alias s='ls -CF --color=always | less'
alias sa='ls -aCF --color=always | less'
alias sl='ls -aCF --color=always | less'
alias sb='echo source $df/bashrc; source $df/bashrc'
alias S='sudo'
alias SD='sudo $(fc -ln -1)'
alias t='ls -1tr  --color=always | less'
alias T='tmux -2 -f $df/tmux.conf new bash --rcfile $df/bashrc'
alias u='echo cd ..; builtin cd ..; ls -CF --color=always | less'
alias v='$EDITOR'
alias v.='$EDITOR .'
set -o history

[ -f "$df/fzf-key-bindings.bash" ] && source "$df/fzf-key-bindings.bash"
if [ ! -z $TMUX ]; then
    tmux source $df/tmux.conf
    tmux source $df/tmux.gruvbox
    source $df/tmux.bash
else
    tmux -2 new
fi

echo Note: last line in $df/bashrc

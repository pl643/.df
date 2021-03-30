#cat > /tmp/.bashrc
history -c
set +o history
HISTCONTROL=ignorespace
export HISTFILE=/tmp/.df/HISTFILE
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

PROMPT_COMMAND=reset_readline_prompt_mode_strings
# bash insert/normal indicator prompt introduced in ver 4.4
BASHVER=${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]}
if (( $(echo "${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]} >= 4.4" | bc -l) )); then
    PS1=' ' 
else
    PS1='\u@\h:\w (vi): '
fi

set -o vi
shopt -s autocd histappend

calc() {
    bc -l <<< "$@"
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

en() {
    file=$(echo $1|cut -f1 -d:)
    line=$(echo $1|cut -f2 -d:)
    $EDITOR $file -c :$line
}

installnvim() {
    set -x
    [ ! -d /tmp/.df ] && mkdir /tmp/.df
    [ ! -d /tmp/.df/nvim-linux64 ] && \
        wget -O /tmp/.df/nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz && \
        tar xfz /tmp/.df/nvim-linux64.tar.gz -C /tmp/.df && rm -f /tmp/.df/nvim-linux64.tar.gz
    if [ -f /tmp/.df/vimrc ] && [ -f /tmp/.df/nvim-linux64/bin/nvim ]; then
        export EDITOR="/tmp/.df/nvim-linux64/bin/nvim -u /tmp/.df/vimrc"
    else
        export EDITOR="nvim"
    fi
    set +x
    echo EDITOR: $EDITOR
    export VISUAL=$EDITOR
}

tnew () { 
    if [ -f ~/df/tmux.windows.name.update.sh ]; then
        tmux new -d -s "$1" bash --rcfile ~/df/tmux.windows.name.update.sh
    else
        tmux new -d -s "$1" bash
    fi
}

# c() {  # cd alias
#     if [ $# -eq 0 ]; then
#         dirs|tr ' ' '\n'|sort|uniq|nl -w 4
#         read -p "Enter number: " dir
#         if [ ! -z $dir ]; then
#             d=$(dirs|tr ' ' '\n'|sort|uniq|nl -w 4|head -$dir|tail -1|cut -f 2 -d$'\t')
#             if [ $d == '~' ]; then
#                 cd ~
#             else
#                 cd $d
#             fi
#         fi
#     else
#         pushd $1
#     fi
# }

clean_up() {
    ARG=$?
    [ -f /tmp/.df/.keep ] && return
    read -p "Keep /tmp/.df? " -rsn1 input
    if [ "$input" = "y" ]; then
        exit 0
    fi
    echo "cleaning up.."
    set -x
    rm -rf /tmp/.df
    exit $ARG
} 
trap clean_up EXIT

dirhistoryfile="/tmp/.df/.dirhistoryfile"
cd() {
    builtin cd "$@" && ls -CF --color=auto; 
    [ $# -eq 0 ] && return
    [ $@ = "-" ] && return
    [ $@ = ".." ] && return
    echo $@ >> $dirhistoryfile
}

dirbookmarkfile="/tmp/.df/.dirbookmark"
alias sdb="echo source $dirbookmarkfile; source $dirbookmarkfile"
db() { # bookmark current directory as alias for quick access
    if [ $# -eq 0 ]; then
        [ -f $dirbookmarkfile ] && cat $dirbookmarkfile
        return
    fi
    set -x
    newalias=$1
    eval alias $newalias=\'echo cd $PWD\; "cd $PWD"\'
    alias $newalias >> /tmp/.df/.dirbookmark
    set +x
}

ma() { # make new alias for the previous command
    set -x
    newalias=$1
    prevcmd=$(fc -ln -2|head -1|sed 's/^\s*//')
    eval alias $newalias=\'echo $prevcmd\; "$prevcmd"\'
    eval echo alias $newalias=\'$prevcmd\' >> /tmp/.aliases
    set +x
}

# telemetry-parser -g 1 -f /mnt/nvm/NVMeMgr/Packages/Latest/fw_trace_fmt_strings.txt -d /dev/nvme0
alias -- -='cd -'
alias .='cd ..'
alias a='alias'
alias A='ansible'
alias b='echo -n "cd -: " ; cd -'
alias c=cd
alias cdf='echo cd /tmp/.df; cd /tmp/.df'
alias D='docker'
alias ff="git ls-files | grep"
alias G='git'
alias Gh='git push'
alias Gl='git pull'
alias Gc='git commit'
alias gg='ga && git commit --fixup=HEAD && GIT_SEQUENCE_EDITOR=: git rebase HEAD~2 -i --autosquash' # https://dev.to/heroku/what-are-your-preferred-bash-aliases-1m8a
alias h='echo cd ~; cd'
alias hi='history'
alias iv='installnvim'
alias rdf='rm -rf /tmp/.df'
alias keepdf='echo touch /tmp/.df/.keep; touch /tmp/.df/.keep'
alias l='ls -lhF --color=auto'
alias la='ls -alhF --color=auto'
alias ll='ls -alhF --color=always|less -R'
alias le='less'
alias np="echo $USER ALL=NOPASSWD:   ALL| sudo tee -a /etc/sudoers"
alias ni='nix-env -i'
alias nqi='nix-env --query --installed'
alias p='popd'
alias s='ls -CF --color=auto'
alias t='ls -1tr  --color=auto'
alias sa='ls -aCF --color=auto'
alias sl='ls -aCF --color=always|less -R'
alias sb='echo source /tmp/.df/bashrc; source /tmp/.df/bashrc'
alias S='sudo'
alias SD='sudo $(fc -ln -1)'
alias u='echo cd ..; cd ..'
alias v='$EDITOR'
alias v.='$EDITOR .'
set -o history

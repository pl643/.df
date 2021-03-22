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
PS1=' '
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
c() {
    if [ $# -eq 0 ]; then
        dirs|tr ' ' '\n'|sort|uniq|nl -w 4
        read -p "Enter number: " dir
        if [ ! -z $dir ]; then
            d=$(dirs|tr ' ' '\n'|sort|uniq|nl -w 4|head -$dir|tail -1|cut -f 2 -d$'\t')
            if [ $d == '~' ]; then
                cd ~
            else
                cd $d
            fi
        fi
    else
        pushd $1
    fi
}
clean_up () {
    ARG=$?
    echo "cleaning up.."
    set -x
    rm -rf /tmp/.bashrc
    set +x
    exit $ARG
} 
trap clean_up EXIT
installnvim

# telemetry-parser -g 1 -f /mnt/nvm/NVMeMgr/Packages/Latest/fw_trace_fmt_strings.txt -d /dev/nvme0
alias -- -='cd -'
alias ..='cd ..'
alias A='ansible'
alias b='cd -'
alias D='docker'
alias e='$EDITOR'
alias e.='$EDITOR .'
alias ff="git ls-files | grep"
alias G='git'
alias gg='ga && git commit --fixup=HEAD && GIT_SEQUENCE_EDITOR=: git rebase HEAD~2 -i --autosquash' # https://dev.to/heroku/what-are-your-preferred-bash-aliases-1m8a
alias h='cd'
alias hi='history'
alias inv='installnvim'
alias rnv='rm -rf /tmp/.df'
alias l='ls -lhF --color=auto'
alias la='ls -alhF --color=auto'
alias le='less'
alias np="echo $USER ALL=NOPASSWD:   ALL| sudo tee -a /etc/sudoers"
alias p='popd'
alias s='ls -CF --color=auto'
alias t='ls -1tr  --color=auto'
alias sa='ls -aCF --color=auto'
alias S='sudo'
alias SD='sudo $(fc -ln -1)'
alias u='cd ..'
set -o history

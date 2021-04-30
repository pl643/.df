source $df/aliases
shopt -s expand_aliases
stty -echo
while true; do
    WD=$(echo $PWD|sed s!$HOME!~!)
    # echo USER $USER, WD $WD, HOME $HOME
    stty -echo
    read -p "$USER@$HOSTNAME:$WD $ [H] " -n1 key 
    # set -x
    # printf "key: $key\n"
    if [ -z $key ]; then
        printf '\n'
        continue
    fi
    if [ $key = \* ]; then
        printf 'inside *'
        set -x
        printf "cd *"
        stty echo
        read dir
        cd \*$dir
        set +x
        continue
    fi
    if [ $key = "/" ]; then
        # set -x
        printf "cd /"
        stty echo
        read dir
        cd /$dir
        continue
        # set +x
    fi
    if [ $key = "c" ]; then
        # set -x
        printf "cd "
        stty echo
        read dir
        stty -echo
        if [ -z $dir ]; then
            builtin cd
        else
            builtin cd "$dir"
        fi
        continue
        # set +x
    fi
    if [ $key = "b" ]; then
        b
        continue
    fi
    if [ $key = "d" ]; then
        d
        continue
    fi
    if [ $key = "l" ]; then
        l
        continue
    fi
    if [ $key = "s" ]; then
        s
        continue
    fi
    if [ $key = "i" ]; then
        echo "builtin cd $WD" > /tmp/.cd
        # printf "\n";
        break
    fi 
    if [ $key = "u" ]; then
        echo "cd .."
        cd ..
        continue
    fi 
    if [ $key = "v" ]; then
        v 
        continue
    fi 
    if [ $key = "" ]; then
        printf "\n"
        break
        tmux send-keys Escape \; send-keys Escape
    fi
    if [ $key = "" ]; then
            clear
            continue
    fi
    if [ $key = "" ]; then
            echo empty
            continue
    fi
    if [ $key = "" ]; then
            echo enter
            continue
    fi
    printf "\n"
    continue
    # if [ $key = "" ]; then
    # echo "$key not valid"
done
stty echo
# source /tmp/cd

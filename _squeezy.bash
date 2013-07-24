#!/bin/sh

_squeezy() 
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    if [[ ${cur} == -* ]] ; then
        opts=`squeezy -options`
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi

    if [[ ${prev} == -sync ]] ; then
        opts=`squeezy -players`
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi

    if [[ ${prev} == -play ]] ; then
       _filedir
        return 0
    fi

}

complete -F _pkg_delete $dirnames pi piu pm portmaster

for player in squeezy $(squeezy -players)
do
   player_lc=$(echo $player | tr 'A-Z' 'a-z')
   complete -F _squeezy $player_lc
   alias $player_lc="$player_lc"
done


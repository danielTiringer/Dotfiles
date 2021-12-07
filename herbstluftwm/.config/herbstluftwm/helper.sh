#!/usr/bin/env bash

function hc() {
    herbstclient "$@"
}


function set_tags_with_name() {
    # hc rename default "${tag_names[0]}" || true
    # for i in ${!tag_names[@]} ; do
    #     hc add "${tag_names[$i]}"
    #     key="${tag_keys[$i]}"
    #     if ! [ -z "$key" ] ; then
    #         hc keybind "$Mod-$key" use_index "$i"
    #         hc keybind "$Mod-Shift-$key" move_index "$i"
    #     fi
    # done
    hc rename default "${tag_names[0]}" 2>/dev/null || true
    
    for index in ${!tag_names[@]} ; do
        hc add "${tag_names[$index]}"
        
        # uncomment to debug in terminal
        # echo $index

        local key="${tag_keys[$index]}"
        if ! [ -z "$key" ] ; then
            hc keybind "$m-$key" use_index "$index"
            hc keybind "$m-Shift-$key" move_index "$index"
        fi
    done
}

function configure()
{
    local command="${1}"
    shift
    
    # associative array hack
    eval "declare -A hash="${1#*=}

    # loop over hash    
    for key in "${!hash[@]}"; do
        local value=${hash[$key]}        
        hc $command $key $value
        
        # uncomment to debug in terminal
        # echo $command $key $value
    done
}

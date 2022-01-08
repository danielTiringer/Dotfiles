#!/usr/bin/env bash

function configure()
{
    # associative array hack
    eval "declare -A hash="${1#*=}

    # loop over hash    
    for key in "${!hash[@]}"; do
        local value=${hash[$key]}        
        bspc config $key $value
        
        # uncomment to debug in terminal
        # echo $key $value
    done
}

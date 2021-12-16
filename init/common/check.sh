#!/bin/sh
# Displays a prompt for continuing the installation

echo 'Are you sure you want to proceed? [Y/n] '

while read -r input
do
    case $input in
        [Yy][Ee][Ss]|[Yy]) echo 'Please enter your password:'; sleep 1; break;;
        [Nn][Oo]|[Nn]) echo 'User aborted.'; exit 1;;
        * ) echo 'Please answer yes or no.';;
    esac
done

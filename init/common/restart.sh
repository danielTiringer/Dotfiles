#!/bin/sh
# Prompt the user to restart the computer

restart() {
    if [ -d "/etc/systemd/" ] ; then
        systemctl reboot
    else
        sudo reboot
    fi
}

echo "Installation completed."
echo 'Would you like to restart your computer now? [Y/n] '
while read -r -p  input
do
    case $input in
        [Yy][Ee][Ss]|[Yy]) echo 'Restarting in a few seconds...'; sleep 3; restart;;
        [Nn][Oo]|[Nn]) echo 'No restart at this time.'; exit 1;;
        * ) echo 'Please answer yes or no.';;
    esac
done

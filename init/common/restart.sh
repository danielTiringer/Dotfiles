# Prompt the user to restart the computer

while true
do
    echo "Installation completed."
    read -r -p 'Would you like to restart your computer now? [Y/n] ' input
    case $input in
        [Yy][Ee][Ss]|[Yy]) echo 'Restarting in a few seconds...'; sleep 3; systemctl reboot;;
        [Nn][Oo]|[Nn]) echo 'No restart at this time.'; exit 1;;
        * ) echo 'Please answer yes or no.';;
    esac
done

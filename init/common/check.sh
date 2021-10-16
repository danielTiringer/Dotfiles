# Displays a prompt for continuing the installation

while true
do
    read -r -p 'Are you sure you want to proceed? [Y/n] ' input
    case $input in
        [Yy][Ee][Ss]|[Yy]) echo 'Please enter your password:'; sleep 1; break;;
        [Nn][Oo]|[Nn]) echo 'User aborted.'; exit 1;;
        * ) echo 'Please answer yes or no.';;
    esac
done

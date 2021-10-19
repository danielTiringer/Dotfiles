# Installs postman

wget https://dl.pstmn.io/download/latest/linux64 -O ~/Downloads/postman-linux-x64.tar.gz
sudo tar -xvzf ~/Downloads/postman-linux-x64.tar.gz -C /opt
sudo ln -s /opt/Postman/Postman /usr/bin/postman
rm ~/Downloads/postman-linux-x64.tar.gz

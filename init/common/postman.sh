#!/bin/sh
# Installs postman

curl --location https://dl.pstmn.io/download/latest/linux64 --output $HOME/Downloads/postman-linux-x64.tar.gz
sudo tar --extract --verbose --gzip --file $HOME/Downloads/postman-linux-x64.tar.gz --directory /opt
sudo ln -s /opt/Postman/Postman /usr/bin/postman
rm ~/Downloads/postman-linux-x64.tar.gz

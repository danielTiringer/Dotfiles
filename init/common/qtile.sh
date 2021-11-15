# Installs qtile with pip3

pip3 install xcffib psutil dbus-next
pip3 install --no-cache-dir cairocffi

git clone git://github.com/qtile/qtile.git ~/Downloads/qtile
pip3 install ~/Downloads/qtile/
rm -rf ~/Downloads/qtile

sudo echo '[Desktop Entry]
Name=Qtile
Comment=Qtile Session
Exec=qtile start
Type=Application
Keywords=wm;tiling' | sudo tee /usr/share/xsessions/qtile.desktop

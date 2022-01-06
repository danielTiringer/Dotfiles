#!/bin/sh

# Enables the macbook fan control on startup
# https://github.com/linux-on-mac/mbpfan

if [ -d "/etc/systemd" ] ; then
	echo "[Unit]
Description=A fan manager daemon for MacBook Pro
After=syslog.target
After=sysinit.target

[Service]
Type=simple
ExecStart=/usr/sbin/mbpfan -f
ExecReload=/usr/bin/kill -HUP $MAINPID
PIDFile=/var/run/mbpfan.pid
Restart=always

[Install]
WantedBy=sysinit.target" | sudo tee /etc/systemd/system/mbpfan.service

	enable_service mbpfan.service
	sudo systemctl daemon-reload
	sudo systemctl start mbpfan.service
fi

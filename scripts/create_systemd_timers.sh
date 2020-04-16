#!/usr/bin/env sh

if [ "$(id -u)" -ne 0 ]; then
	echo "Please run this script with root access"
	exit 1
fi

echo "Install automatic downloader for updates? [Y/n]"
read -r answer
case "$answer" in
	[yY][eE][sS]|[yY])
		cp ./systemd/download-updates.timer /etc/systemd/system/download-updates.timer
		cp ./systemd/download-updates.service /etc/systemd/system/download-updates.service
		systemctl enable --now download-updates.timer
		;;
	[nN][oO]|[nN])
		echo "no"
		;;
	*)
		echo "invalid input"
		;;
esac


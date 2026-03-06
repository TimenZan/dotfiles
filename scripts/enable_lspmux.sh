#!/usr/bin/env sh

# TODO: generalize to all unit files in `systemd/`


if ! test -x ~/.cargo/bin/lspmux ; then
	echo "Lspmux is not installed (or in the wrong path), would you like to install it now? [Y/n]"
	read -r answer
	case "$answer" in
		[yY][eE][sS]|[yY])
			cargo install lspmux
			;;
		[nN][oO]|[nN])
			echo "Run \`cargo install lspmux\` to manually install it."
			;;

	esac
fi

dir=$(dirname -- "$0")

cp "$dir"/systemd/lspmux.service ~/.config/systemd/user/lspmux.service

systemctl --user daemon-reload
systemctl --user enable --now lspmux.service





#!/bin/bash

#####CONFIGURATION#####
headphones="alsa_output.usb-Logitech_Logitech_G633_Gaming_Headset_00000000-00.analog-stereo"
speakers="alsa_output.pci-0000_26_00.1.hdmi-stereo-extra1"

#####PROGRAM CODE#####
#Do not change unless you know what you are doing!

#Setting to opposite value, so it gets correctly setup
pacmd list-sinks | grep "active port" | grep "analog-output>" > /dev/null && pluggedin=false || pluggedin=true

while true
do
	#Checking state
	if pacmd list-sinks | grep "active port" | grep "analog-output>" > /dev/null
	then
		if ! $pluggedin
		then
			pluggedin=true
			#Setting default
			pacmd set-default-sink "$headphones"

			#Moving existing streams
			pactl list short sink-inputs|while read -r stream; do
				streamId=$(echo "$stream"|cut '-d ' -f1)
				pactl move-sink-input "$streamId" "$headphones" &> /dev/null
			done
		fi
	else
		if $pluggedin
		then
			pluggedin=false
			#Changing default
			pacmd set-default-sink "$speakers"

			#Moving existing streams
			pactl list short sink-inputs|while read -r stream; do
				streamId=$(echo "$stream"|cut '-d ' -f1)
				pactl move-sink-input "$streamId" "$speakers" &> /dev/null
			done
		fi
	fi
	sleep 0.1
done


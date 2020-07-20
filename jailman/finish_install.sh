#!/usr/local/bin/bash

initplugin "$1"

# Check if (in)complete download datasets exist, create if they do not.
createmount "$1" "${global_dataset_downloads}" /mnt/downloads
createmount "$1" "${global_dataset_downloads}"/complete /mnt/downloads/complete
createmount "$1" "${global_dataset_downloads}"/incomplete /mnt/downloads/incomplete

# start once to let service write default config
iocage exec "$1" service sabnzbd start

# Sleep is needed because iocage doesn’t read line by line but rather reads it in all at once
sleep 5
iocage exec "$1" service sabnzbd stop

# put our config in place
iocage exec "$1" sed -i '' -e 's?host = 127.0.0.1?host = 0.0.0.0?g' /config/sabnzbd.ini
iocage exec "$1" sed -i '' -e 's?download_dir = Downloads/incomplete?download_dir = /mnt/downloads/incomplete?g' /config/sabnzbd.ini
iocage exec "$1" sed -i '' -e 's?complete_dir = Downloads/complete?complete_dir = /mnt/downloads/complete?g' /config/sabnzbd.ini

iocage exec "$1" service sabnzbd start

exitplugin "$1"

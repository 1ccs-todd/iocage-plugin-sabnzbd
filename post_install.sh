#!/bin/sh
# Enable and start the service to generate the config file

# setup sabnzbd service
sysrc "sabnzbd_enable=YES"
sysrc "sabnzbd_conf_dir=/config"
sysrc "sabnzbd_user=_sabnzbd"
sysrc "sabnzbd_group=_sabnzbd"



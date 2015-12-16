#!/bin/bash
sudo mount /dev/disk/by-label/ssohjiroData /media/ssohjiroData/

#sudo mount --bind ~/workspace/rookieSvnRelease/client /var/www/clientRelease
#sudo mount --bind ~/workspace/rookieSvn/client/ /var/www/client
#sudo mount --bind ~/Pictures/ /media/ssohjiroData/shareFolder/Pictures

synergy &
indicator-sysmonitor &

sudo echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
xgamma -gamma 1.3

#~/runningServers/openDocuments/bin/www
#~/runningServers/static2/bin/www
#~/runningServers/gearMobileWebStore/bin/www

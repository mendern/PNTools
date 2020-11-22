#! /bin/sh
source  /etc/profile
hwclock -s
LD_LIBRARY_PATH=$PATH:/mnt/DMP6800
export LD_LIBRARY_PATH

mkdir -p /mnt/DMP6800/bin/HisData

ps -ef |grep /mnt/DMP6800  |grep -v grep | awk '{print $2}'| xargs kill -9
sync
sleep 2

mv -f /mnt/update/* /mnt/DMP6800/

chmod 777 /mnt/DMP6800/*

sync
sleep 2
 
mkdir -p /mnt/update/
chmod +x /mnt/DMP6800/mosquitto
/mnt/DMP6800/mosquitto -c /mnt/DMP6800/mosquitto.conf &
sleep 3
chmod +x /mnt/DMP6800/pgmMgr
/mnt/DMP6800/pgmMgr &
sleep 1
service vsftpd stop
#sleep 1
#service xinetd stop
sleep 30
service sshd stop
# /bin/sh

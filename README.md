# Synology DiskStation 
### Bridge interfaces
This startup script creates a network bridge (br0) between eth0 (LAN1) and eth1 (LAN2). By doing this, you can e.g. use LAN2 as a extra  port to your network. Make sure to read the script to understand what's happening before running, and don't forget to change to your preferred ip-addresses and subnet.


#### Compatibility
Tested on DS918+ running on version DSM 6.2.1-23824 Update 6

#### Script
As `root`, copy and paste the following
```bash
cat << \EOF > /usr/local/etc/rc.d/S99createbridge.sh
#!/bin/sh
# S99createbridge.sh
# 
# Creates a bridge (br0) between eth0 and eth1

case $1 in
start)
        echo "> Creating bridge (br0) between eth0 and eth1..."
        insmod /lib/modules/stp.ko
        insmod /lib/modules/bridge.ko
        brctl addbr br0 
        brctl stp br0 off
        ifconfig br0 10.242.1.200 netmask 255.255.255.0 up
        brctl addif br0 eth0
        brctl addif br0 eth1
        ifconfig eth0 10.242.1.200 promisc up
        ifconfig eth1 10.242.1.201 promisc up
        route add default gw 10.242.1.1 dev br0
        echo "> Done"
        ;;
stop)
        echo "> Deleting bridge (br0)..."
        ifconfig br0 down
        brctl delbr br0
        echo "> Done"
        ;;
*)
        echo "Usage: $0 [start|stop]"
        ;;
esac
EOF

chmod 755 /usr/local/etc/rc.d/S99createbridge.sh
```

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

# Synology DiskStation 
### Bridge interfaces
This startup script creates a network bridge (br0) between eth0 (LAN1) and eth1 (LAN2). By doing this, you can e.g. use LAN2 as a extra  port to your network. Make sure to read the script to understand what's happening before running, and don't forget to change to your preferred ip-addresses and subnet.


#### Compatibility
Tested on DS918+ running on version DSM 6.2.1-23824 Update 6


#### Run manually (One time)
As `root`, copy and paste the following
```bash
brctl addbr br0 
brctl stp br0 off
ifconfig br0 10.242.1.200 netmask 255.255.255.0 up

brctl addif br0 eth0
brctl addif br0 eth1

ifconfig eth0 10.242.1.200 netmask 255.255.255.0 promisc up
ifconfig eth1 10.242.1.201 netmask 255.255.255.0 promisc up

route add default gw 10.242.1.1 dev br0

ifconfig eth0 0.0.0.0
ifconfig eth1 0.0.0.0
```

#### Startup (Permanent)
Create a new triggered task in Task Scheduler with the commands above. To be on the safe side, add a `sleep 60` in the top to allow troubleshooting of broken bridge during reboot.

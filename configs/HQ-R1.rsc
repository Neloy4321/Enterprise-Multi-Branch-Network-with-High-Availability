#-------------------------------------------------------------------------
# Project: Enterprise Multi-Branch Network with High Availability
# Device: HQ-R1 (VRRP Master)
# Operating System: RouterOS v7.21.4
#-------------------------------------------------------------------------

/system identity set name=HQ-R1

# Layer 2 VLAN Interface Creation (All on ether1 to CORE-SW1)
/interface vlan
add interface=ether1 name=vlan10-HR vlan-id=10
add interface=ether1 name=vlan20-SALES vlan-id=20
add interface=ether1 name=vlan30-IT vlan-id=30
add interface=ether1 name=vlan40-SERVER vlan-id=40
add interface=ether1 name=vlan50-MGMT vlan-id=50

# VRRP High Availability Configuration (Priority 255 = Master)
/interface vrrp
add interface=vlan10-HR name=vrrp10 priority=255 vrid=10
add interface=vlan20-SALES name=vrrp20 priority=255 vrid=20
add interface=vlan30-IT name=vrrp30 priority=255 vrid=30
add interface=vlan40-SERVER name=vrrp40 priority=255 vrid=40
add interface=vlan50-MGMT name=vrrp50 priority=255 vrid=50

# IP Addressing (Physical Interconnects & WAN Links)
/ip address
add address=172.16.10.1/24 interface=vlan10-HR
add address=172.16.20.1/24 interface=vlan20-SALES
add address=172.16.30.1/24 interface=vlan30-IT
add address=172.16.40.1/24 interface=vlan40-SERVER
add address=172.16.50.1/24 interface=vlan50-MGMT
add address=10.0.1.1/30 interface=ether2 comment="WAN-01: to BR1-R1 ether2"
add address=10.0.2.1/30 interface=ether3 comment="WAN-02: to BR2-R1 ether2"

# VRRP Virtual Gateway IP Assignment
/ip address
add address=172.16.10.254/24 interface=vrrp10
add address=172.16.20.254/24 interface=vrrp20
add address=172.16.30.254/24 interface=vrrp30
add address=172.16.40.254/24 interface=vrrp40
add address=172.16.50.254/24 interface=vrrp50

# Centralized DHCP Server Scopes
/ip pool
add name=pool-HR ranges=172.16.10.100-172.16.10.200
add name=pool-SALES ranges=172.16.20.100-172.16.20.200
add name=pool-IT ranges=172.16.30.100-172.16.30.200
add name=pool-MGMT ranges=172.16.50.100-172.16.50.200

/ip dhcp-server
add address-pool=pool-HR interface=vlan10-HR name=dhcp-HR disabled=no
add address-pool=pool-SALES interface=vlan20-SALES name=dhcp-SALES disabled=no
add address-pool=pool-IT interface=vlan30-IT name=dhcp-IT disabled=no
add address-pool=pool-MGMT interface=vlan50-MGMT name=dhcp-MGMT disabled=no

/ip dhcp-server network
add address=172.16.10.0/24 dns-server=8.8.8.8 gateway=172.16.10.254
add address=172.16.20.0/24 dns-server=8.8.8.8 gateway=172.16.20.254
add address=172.16.30.0/24 dns-server=8.8.8.8 gateway=172.16.30.254
add address=172.16.50.0/24 dns-server=8.8.8.8 gateway=172.16.50.254

# WAN Internet Integration (Connected to Management Cloud)
/ip dhcp-client add interface=ether4 disabled=no use-peer-dns=yes use-peer-ntp=yes

# Central Central Internet Access via Source NAT
/ip firewall nat
add chain=srcnat out-interface=ether4 action=masquerade comment="Central Internet NAT"

# Enterprise Access Control Lists (Firewall Filter Rules)
/ip firewall filter
add chain=forward src-address=172.16.10.0/24 dst-address=172.16.30.0/24 action=drop comment="Block HR to IT"
add chain=forward src-address=172.16.110.0/24 dst-address=172.16.50.0/24 action=drop comment="Block BR1 to Management"
add chain=forward src-address=172.16.210.0/24 dst-address=172.16.50.0/24 action=drop comment="Block BR2 to Management"
add chain=input src-address=172.16.110.0/24 dst-address=172.16.50.1 action=drop comment="Block BR1 access to HQ Management IP"
add chain=input src-address=172.16.210.0/24 dst-address=172.16.50.1 action=drop comment="Block BR2 access to HQ Management IP"
add chain=input src-address=!172.16.30.0/24,172.16.50.0/24 protocol=tcp dst-port=22 action=drop comment="Restrict SSH to IT and Mgmt Only"

# OSPF Multi-Area Dynamic Routing Setup
/routing ospf instance
add name=ospf-hq router-id=1.1.1.1 originate-default=always
/routing ospf area
add instance=ospf-hq name=area0 area-id=0.0.0.0
/routing ospf interface-template
add area=area0 interfaces=ether2,ether3 type=ptp
add area=area0 interfaces=vlan10-HR,vlan20-SALES,vlan30-IT,vlan40-SERVER,vlan50-MGMT type=broadcast

# Infrastructure Management Service Hardening
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes
set ssh port=22 disabled=no

# Central Logging & Time Synchronization Client Policies
/system logging action add name=syslog-server remote=172.16.40.201 target=remote
/system logging add action=syslog-server topics=info,warning,error,critical
/ip dns set servers=8.8.8.8
/ntp client set enabled=yes
/ntp client servers add address=172.16.40.201
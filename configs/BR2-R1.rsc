#-------------------------------------------------------------------------
# Device: BR2-R1 (Branch-2 Gateway)
# Operating System: RouterOS v7.21.4
#-------------------------------------------------------------------------

/system identity set name=BR2-R1

# VLAN Interface Mapping (On ether1 connecting to BR2-SW1)
/interface vlan
add interface=ether1 name=vlan210-USERS vlan-id=210

# Physical Interfaces Network Topology Table IPs
/ip address
add address=172.16.210.1/24 interface=vlan210-USERS
add address=10.0.2.2/30 interface=ether2 comment="WAN-02: Connection to HQ-R1"
add address=10.0.4.2/30 interface=ether3 comment="WAN-04: Connection to HQ-R2"

# Local DHCP Scope Configuration
/ip pool add name=pool-BR2 ranges=172.16.210.100-172.16.210.200
/ip dhcp-server add address-pool=pool-BR2 interface=vlan210-USERS name=dhcp-BR2 disabled=no
/ip dhcp-server network add address=172.16.210.0/24 dns-server=8.8.8.8 gateway=172.16.210.1

# Dynamic Routing Setup (Area 20 Framework)
/routing ospf instance
add name=ospf-br2 router-id=4.4.4.4
/routing ospf area
add instance=ospf-br2 name=area20 area-id=0.0.0.20
/routing ospf interface-template
add area=area20 interfaces=ether2,ether3 type=ptp
add area=area20 interfaces=vlan210-USERS type=broadcast

# Infrastructure Protection Schemes
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes

# Centralized Management Pointers Setup
/system logging action add name=syslog-server remote=172.16.40.201 target=remote
/system logging add action=syslog-server topics=info,warning,error,critical
/ntp client set enabled=yes
/ntp client servers add address=172.16.40.201
#-------------------------------------------------------------------------
# Device: BR1-R1 (Branch-1 Gateway)
# Operating System: RouterOS v7.21.4
#-------------------------------------------------------------------------

/system identity set name=BR1-R1

# VLAN Interface Creation (On ether1 connecting to BR1-SW1)
/interface vlan
add interface=ether1 name=vlan110-USERS vlan-id=110

# Physical Layer Addressing Table Implementation
/ip address
add address=172.16.110.1/24 interface=vlan110-USERS
add address=10.0.1.2/30 interface=ether2 comment="WAN-01: Connection to HQ-R1"
add address=10.0.3.2/30 interface=ether3 comment="WAN-03: Connection to HQ-R2"

# Branch-1 DHCP Scope Deployment
/ip pool add name=pool-BR1 ranges=172.16.110.100-172.16.110.200
/ip dhcp-server add address-pool=pool-BR1 interface=vlan110-USERS name=dhcp-BR1 disabled=no
/ip dhcp-server network add address=172.16.110.0/24 dns-server=8.8.8.8 gateway=172.16.110.1

# Branch OSPF Configuration Model (Area 10 Mapping)
/routing ospf instance
add name=ospf-br1 router-id=3.3.3.3
/routing ospf area
add instance=ospf-br1 name=area10 area-id=0.0.0.10
/routing ospf interface-template
add area=area10 interfaces=ether2,ether3 type=ptp
add area=area10 interfaces=vlan110-USERS type=broadcast

# Infrastructure Hardening Policies
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes

# Monitoring Node Pointers Implementation
/system logging action add name=syslog-server remote=172.16.40.201 target=remote
/system logging add action=syslog-server topics=info,warning,error,critical
/ntp client set enabled=yes
/ntp client servers add address=172.16.40.201